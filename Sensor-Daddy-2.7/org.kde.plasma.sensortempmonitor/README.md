# Sensor Daddy

Sensor Daddy is a KDE Plasma 6 system-monitor widget. The current release is
2.7 and its stable package ID is `org.kde.plasma.sensorcustommonitor`.

The widget supports its original compact text layout and the System Monitor
faces installed on the computer. All choices appear in the single native
**Appearance > Display Style** dropdown.

The original layout is supplied to that dropdown by the companion face package:

```text
org.kde.ksysguard.sensordaddyoriginal
```

Install or upgrade both packages:

```bash
kpackagetool6 --type KSysguard/SensorFace --install ../org.kde.ksysguard.sensordaddyoriginal
kpackagetool6 --type Plasma/Applet --install .
```

Use `--upgrade` instead of `--install` when they are already installed. Restart
`plasma-plasmashell.service` after runtime QML or controller metadata changes.

Future AI maintainers must read [AI_MAINTENANCE.md](AI_MAINTENANCE.md) before
changing this package.
