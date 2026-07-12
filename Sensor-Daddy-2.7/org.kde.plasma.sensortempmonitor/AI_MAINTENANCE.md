# Sensor Daddy AI maintenance guide

Read this entire file before modifying Sensor Daddy. It records the decisions
made during live Plasma testing so they are not accidentally reversed.

## Identity and release rule

- Widget name: `Sensor Daddy`
- Widget ID: `org.kde.plasma.sensorcustommonitor`
- Current release: `2.7`
- Plasma requirement: Plasma 6
- Companion face ID: `org.kde.ksysguard.sensordaddyoriginal`
- Companion face source: `../org.kde.ksysguard.sensordaddyoriginal/`

Do not change either package ID. Plasma uses the widget ID to preserve panel
instances and configuration.

Every delivered functional update must increment the widget version in
`metadata.json`. Keep the companion face version aligned with the widget
release. This version bump rule applies to code, behavior, configuration, and
packaging changes. Documentation-only edits do not increment the version.

## Non-negotiable Appearance design

There must be one Appearance tab and one native Display Style dropdown. Do not
add a second style selector above or beside KDE's native dropdown.

`Sensor Daddy (Original)` is a real KSysGuard sensor face registered by the
companion package. It appears in the same dropdown as Text Only, Pie Chart,
Line Chart, Bar Chart, Color Grid, Grid, Horizontal Bars, Applications Table,
and Process Table.

The original layout and a System Monitor face are mutually exclusive. Never
render both simultaneously; doing so makes Text Only duplicate the original
row. `main.qml` derives `useOriginalStyle` from this face ID:

```text
org.kde.ksysguard.sensordaddyoriginal
```

When `useOriginalStyle` is true, show only `SensorTempCompactRepresentation`.
The original style is intentionally compact-only even if `autoFullView` is set.
When another face is selected, show only the controller-provided compact or
full representation.

## Sensor ownership

The original style uses the existing CPU, RAM, GPU, Storage, and Network pages.
Those pages configure the widget's original eight sensor subscriptions.

System Monitor faces use the native sensor-placement editor embedded below the
style settings in the Appearance tab. It must support separate:

- primary/full-display sensors;
- secondary text-only sensors.

Do not bind `Plasmoid.faceController.highPrioritySensorIds`,
`lowPrioritySensorIds`, `sensorColors`, or `sensorLabels` unconditionally in
`main.qml`. Such bindings overwrite choices made in the native sensor editor.
The controller and its config UI must own and persist those values.

The sensor-placement editor is hidden for `Sensor Daddy (Original)` because the
original layout is configured by the five existing sensor pages.

## Controller integration

The widget metadata must retain both:

```json
"X-Plasma-Provides": ["org.kde.plasma.systemcustommonitor", "org.kde.plasma.systemmonitor"],
"X-Plasma-RootPath": "org.kde.plasma.systemmonitor"
```

`X-Plasma-RootPath` causes Plasma to instantiate KDE's native System Monitor
C++ applet and inject `faceController`, `workaroundController()`, and
`openSystemMonitor()`. Without it, the Appearance page is blank.

Changing this metadata on disk does not retrofit an already-running applet
object. Perform a real restart when required:

```bash
systemctl --user restart plasma-plasmashell.service
```

`org.kde.PlasmaShell.refreshCurrentShell` is not a full process restart and is
insufficient for changing the applet's C++ type.

## GPU data

Use KSystemStats through `org.kde.ksysguard.sensors`. Do not spawn and parse
`nvidia-smi` on every update. On the tested NVIDIA GTX 1080 Ti, these IDs are
valid:

```text
gpu/gpu0/temperature
gpu/gpu0/usage
gpu/all/usage
gpu/gpu0/usedVram
gpu/gpu0/power
```

`nvidia-smi` is useful only as a diagnostic or optional NVIDIA-specific
fallback. Live testing confirmed KSystemStats and `nvidia-smi` agree: an
uncapped OpenGL load raised KSystemStats utilization from 0% to 36-44%, while a
separate NVIDIA sample reached roughly 27-52%. VRAM allocation does not imply
nonzero GPU-engine utilization; an idle desktop may legitimately report 0%.

Never store a regular expression such as `gpu/gpu\\d+/usage` as a sensor ID.
KSystemStats requires a concrete ID such as `gpu/gpu0/usage`.

## Stable network width

The Network page exposes `networkFixedWidth`. While it is disabled, the compact
view tracks the rendered width of each download and upload value independently.
Enabling it freezes those two current widths; do not replace this with guessed
maximum strings, which creates excessive empty panel space. The D/U labels are
separate and the values are right-aligned. Preserve this as an option rather
than forcing it for every user.

`networkUnit` selects rate formatting: `0` is automatic, `1` is KB/s, `2` is
MB/s, and `3` is GB/s. Fixed modes convert the raw bytes-per-second sensor value
using decimal SI divisors (1000, 1,000,000, and 1,000,000,000). Do not use the
sensor's preformatted adaptive string when a fixed unit is selected.

## Package locations and commands

Development sources:

```text
~/Downloads/org.kde.plasma.sensortempmonitor/
~/Downloads/org.kde.ksysguard.sensordaddyoriginal/
```

Installed locations:

```text
~/.local/share/plasma/plasmoids/org.kde.plasma.sensorcustommonitor/
~/.local/share/ksysguard/sensorfaces/org.kde.ksysguard.sensordaddyoriginal/
```

Install or upgrade the face first, then the widget:

```bash
kpackagetool6 --type KSysguard/SensorFace --upgrade ~/Downloads/org.kde.ksysguard.sensordaddyoriginal
kpackagetool6 --type Plasma/Applet --upgrade ~/Downloads/org.kde.plasma.sensortempmonitor
```

The package type spelling is exactly `KSysguard/SensorFace`.

## Required validation

At minimum, validate JSON and XML, run the Qt 6 linter, upgrade both packages,
and run the widget in `plasmawindowed`:

```bash
python3 -m json.tool metadata.json
python3 -c 'import xml.etree.ElementTree as ET; ET.parse("contents/config/main.xml")'
/usr/lib/qt6/bin/qmllint contents/ui/main.qml
plasmawindowed org.kde.plasma.sensorcustommonitor
```

The generic `/usr/bin/qmllint` launcher may incorrectly point to a missing Qt 5
binary; use `/usr/lib/qt6/bin/qmllint` directly.

Test all installed faces in compact and full/detailed modes. The live test set
on this system was:

```text
org.kde.ksysguard.applicationstable
org.kde.ksysguard.barchart
org.kde.ksysguard.colorgrid
org.kde.ksysguard.facegrid
org.kde.ksysguard.horizontalbars
org.kde.ksysguard.linechart
org.kde.ksysguard.piechart
org.kde.ksysguard.processtable
org.kde.ksysguard.textonly
org.kde.ksysguard.sensordaddyoriginal
```

## Known upstream and framework noise

- Applications Table emits a detailed-view `contentItem` binding-loop warning
  in KDE's untouched stock System Monitor wrapper too. This is upstream, not a
  Sensor Daddy regression.
- Bar Chart can emit a benign invalid-model-index diagnostic during startup.
- Plasma's legacy multi-page configuration loader passes unrelated `cfg_*`
  properties to every page, producing many `Setting initial properties failed`
  warnings. Judge actual page rendering and controller errors separately.
- A missing `workaroundController` or null `appearanceConfigUi` is not benign;
  it indicates that the applet was created without the native controller or
  that Plasma has not been fully restarted after metadata changes.

## Backup

The untouched pre-integration 2.1 source is preserved at:

```text
~/Downloads/org.kde.plasma.sensortempmonitor-2.1-before-kde-integration-20260712/
```

Do not delete or overwrite that backup.
