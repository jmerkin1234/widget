import QtQuick
import QtQuick.Layouts
import QtQml
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.ksysguard.sensors as Sensors
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    preferredRepresentation: root.useOriginalStyle
        ? compactRepresentation
        : root.autoFullView
        ? (Plasmoid.formFactor === PlasmaCore.Types.Planar ? fullRepresentation : null)
        : compactRepresentation
    implicitWidth: !root.useOriginalStyle
        && root.autoFullView
        && Plasmoid.formFactor === PlasmaCore.Types.Planar
        ? (fullRepresentationItem?.implicitWidth ?? 0)
        : (compactRepresentationItem?.implicitWidth ?? 0)
    implicitHeight: !root.useOriginalStyle
        && root.autoFullView
        && Plasmoid.formFactor === PlasmaCore.Types.Planar
        ? (fullRepresentationItem?.implicitHeight ?? 0)
        : (compactRepresentationItem?.implicitHeight ?? 0)
    switchWidth: !root.useOriginalStyle && root.autoFullView
        ? switchSizeFromSize(
            PlasmaCore.Types.Horizontal,
            compactRepresentationItem?.Layout.maximumWidth ?? Infinity,
            Kirigami.Units.iconSizes.enormous - 1)
        : -1
    switchHeight: !root.useOriginalStyle && root.autoFullView
        ? switchSizeFromSize(
            PlasmaCore.Types.Vertical,
            compactRepresentationItem?.Layout.maximumHeight ?? Infinity,
            Kirigami.Units.iconSizes.enormous - 1)
        : -1

    Plasmoid.title: root.useOriginalStyle
        ? i18n("Sensor Daddy")
        : (Plasmoid.faceController?.title || i18n("Sensor Daddy"))
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    Plasmoid.configurationRequired: kdeConfigurationRequired
    toolTipSubText: !root.useOriginalStyle && totalSensor.sensorId
        ? i18nc("Sensor name: value", "%1: %2", totalSensor.name, totalSensor.formattedValue)
        : ""

    readonly property bool kdeConfigurationRequired: {
        const controller = Plasmoid.faceController
        const highPrioritySensorIds = controller?.highPrioritySensorIds ?? []
        const lowPrioritySensorIds = controller?.lowPrioritySensorIds ?? []
        const totalSensors = controller?.totalSensors ?? []
        return !root.useOriginalStyle
            && Boolean(controller)
            && highPrioritySensorIds.length === 0
            && lowPrioritySensorIds.length === 0
            && totalSensors.length === 0
            && !["org.kde.ksysguard.applicationstable",
                "org.kde.ksysguard.processtable"].includes(controller.faceId)
    }

    readonly property int cpuFontSize: Plasmoid.configuration.cpuFontSize
    readonly property string cpuFontColor: Plasmoid.configuration.cpuFontColor
    readonly property string cpuTempSensor: Plasmoid.configuration.cpuTempSensor
    readonly property string cpuUsageSensor: Plasmoid.configuration.cpuUsageSensor
    readonly property bool showCpu: Plasmoid.configuration.showCpu
    readonly property bool cpuBold: Plasmoid.configuration.cpuBold
    readonly property string cpuLabelColor: Plasmoid.configuration.cpuLabelColor
    readonly property bool cpuPrecision: Plasmoid.configuration.cpuPrecision
    readonly property bool cpuUseIcon: Plasmoid.configuration.cpuUseIcon
    readonly property string cpuIconPath: Plasmoid.configuration.cpuIconPath
    readonly property int cpuIconSize: Plasmoid.configuration.cpuIconSize

    readonly property int ramFontSize: Plasmoid.configuration.ramFontSize
    readonly property string ramFontColor: Plasmoid.configuration.ramFontColor
    readonly property string ramUsageSensor: Plasmoid.configuration.ramUsageSensor
    readonly property bool showRam: Plasmoid.configuration.showRam
    readonly property bool ramBold: Plasmoid.configuration.ramBold
    readonly property string ramLabelColor: Plasmoid.configuration.ramLabelColor
    readonly property bool ramPrecision: Plasmoid.configuration.ramPrecision
    readonly property bool ramUseIcon: Plasmoid.configuration.ramUseIcon
    readonly property string ramIconPath: Plasmoid.configuration.ramIconPath
    readonly property int ramIconSize: Plasmoid.configuration.ramIconSize

    readonly property int gpuFontSize: Plasmoid.configuration.gpuFontSize
    readonly property string gpuFontColor: Plasmoid.configuration.gpuFontColor
    readonly property string gpuTempSensor: Plasmoid.configuration.gpuTempSensor
    readonly property string gpuUsageSensor: Plasmoid.configuration.gpuUsageSensor
    readonly property bool showGpu: Plasmoid.configuration.showGpu
    readonly property bool gpuBold: Plasmoid.configuration.gpuBold
    readonly property string gpuLabelColor: Plasmoid.configuration.gpuLabelColor
    readonly property bool gpuPrecision: Plasmoid.configuration.gpuPrecision
    readonly property bool gpuUseIcon: Plasmoid.configuration.gpuUseIcon
    readonly property string gpuIconPath: Plasmoid.configuration.gpuIconPath
    readonly property int gpuIconSize: Plasmoid.configuration.gpuIconSize

    readonly property int storageFontSize: Plasmoid.configuration.storageFontSize
    readonly property string storageFontColor: Plasmoid.configuration.storageFontColor
    readonly property string storageUsageSensor: Plasmoid.configuration.storageUsageSensor
    readonly property bool showStorage: Plasmoid.configuration.showStorage
    readonly property bool storageBold: Plasmoid.configuration.storageBold
    readonly property string storageLabelColor: Plasmoid.configuration.storageLabelColor
    readonly property bool storagePrecision: Plasmoid.configuration.storagePrecision
    readonly property bool storageUseIcon: Plasmoid.configuration.storageUseIcon
    readonly property string storageIconPath: Plasmoid.configuration.storageIconPath
    readonly property int storageIconSize: Plasmoid.configuration.storageIconSize

    readonly property int networkFontSize: Plasmoid.configuration.networkFontSize
    readonly property string networkFontColor: Plasmoid.configuration.networkFontColor
    readonly property string networkDownloadSensor: Plasmoid.configuration.networkDownloadSensor
    readonly property string networkUploadSensor: Plasmoid.configuration.networkUploadSensor
    readonly property bool showNetwork: Plasmoid.configuration.showNetwork
    readonly property bool networkBold: Plasmoid.configuration.networkBold
    readonly property bool networkFixedWidth: Plasmoid.configuration.networkFixedWidth
    readonly property int networkUnit: Plasmoid.configuration.networkUnit
    readonly property string networkLabelColor: Plasmoid.configuration.networkLabelColor
    readonly property bool networkUseIcon: Plasmoid.configuration.networkUseIcon
    readonly property string networkIconPath: Plasmoid.configuration.networkIconPath
    readonly property int networkIconSize: Plasmoid.configuration.networkIconSize

    readonly property int labelFontSize: Plasmoid.configuration.labelFontSize
    readonly property int spacing: Plasmoid.configuration.spacing
    readonly property bool autoFullView: Plasmoid.configuration.autoFullView
    readonly property bool useOriginalStyle:
        Plasmoid.faceController?.faceId === "org.kde.ksysguard.sensordaddyoriginal"
    readonly property int updateInterval: Plasmoid.configuration.updateInterval
    readonly property string fontFamily: Plasmoid.configuration.fontFamily

    property real cpuTemp: 0
    property real cpuUsage: 0
    property real ramUsage: 0
    property real gpuTemp: 0
    property real gpuUsage: 0
    property real storageUsage: 0
    property real networkDownload: 0
    property real networkUpload: 0

    function formatValue(value, usePrecision) {
        var numericValue = Number(value) || 0
        if (usePrecision && numericValue < 10) {
            return numericValue.toFixed(1)
        }
        return Math.round(numericValue).toString()
    }

    function formatBytesPerSecond(value) {
        var numericValue = Math.max(0, Number(value) || 0)
        var units = ["B/s", "KiB/s", "MiB/s", "GiB/s"]
        var unitIndex = 0

        while (numericValue >= 1024 && unitIndex < units.length - 1) {
            numericValue = numericValue / 1024
            unitIndex += 1
        }

        var precision = numericValue < 10 && unitIndex > 0 ? 1 : 0
        return numericValue.toFixed(precision) + " " + units[unitIndex]
    }

    function networkRateText(sensor, fallbackValue) {
        if (networkUnit === 0) {
            return sensor.formattedValue.length > 0
                ? sensor.formattedValue
                : formatBytesPerSecond(fallbackValue)
        }

        const divisors = [1, 1000, 1000000, 1000000000]
        const unitNames = ["B/s", "KB/s", "MB/s", "GB/s"]
        const scaledValue = Math.max(0, Number(fallbackValue) || 0) / divisors[networkUnit]
        const precision = scaledValue < 1 ? 2 : (scaledValue < 10 ? 1 : 0)
        return scaledValue.toFixed(precision) + " " + unitNames[networkUnit]
    }

    function switchSizeFromSize(formFactor, compactMax, fullMin) {
        if (Plasmoid.formFactor === PlasmaCore.Types.Planar) {
            return -1
        }

        if (Plasmoid.formFactor === formFactor) {
            return 1
        }

        if (!Number.isFinite(compactMax)) {
            compactMax = Kirigami.Units.iconSizes.enormous - 1
        }

        if (fullMin <= 0) {
            fullMin = Kirigami.Units.iconSizes.enormous - 1
        }

        return Math.max(compactMax, fullMin)
    }

    function sumSizes(first, second, gap) {
        return Math.max(0, Number(first) || 0)
            + Math.max(0, Number(second) || 0)
            + Math.max(0, Number(gap) || 0)
    }

    function sumMaximumSizes(first, second, gap) {
        if (!Number.isFinite(first) || !Number.isFinite(second)) {
            return Infinity
        }
        return sumSizes(first, second, gap)
    }

    function openSystemMonitor() {
        if (typeof Plasmoid.openSystemMonitor === "function") {
            Plasmoid.openSystemMonitor()
        } else {
            executable.connectSource("plasma-systemmonitor")
        }
    }

    readonly property string networkDownloadText:
        networkRateText(networkDownloadSensorObj, networkDownload)

    readonly property string networkUploadText:
        networkRateText(networkUploadSensorObj, networkUpload)

    function hasVisibleBefore(sectionName) {
        if (sectionName === "ram") {
            return showCpu
        }
        if (sectionName === "gpu") {
            return showCpu || showRam
        }
        if (sectionName === "storage") {
            return showCpu || showRam || showGpu
        }
        if (sectionName === "network") {
            return showCpu || showRam || showGpu || showStorage
        }
        return false
    }

    Sensors.Sensor {
        id: cpuTempSensorObj
        sensorId: root.cpuTempSensor
        enabled: root.showCpu && root.cpuTempSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.cpuTemp = Number(value) || 0
    }

    Sensors.Sensor {
        id: cpuUsageSensorObj
        sensorId: root.cpuUsageSensor
        enabled: root.showCpu && root.cpuUsageSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.cpuUsage = Number(value) || 0
    }

    Sensors.Sensor {
        id: ramUsageSensorObj
        sensorId: root.ramUsageSensor
        enabled: root.showRam && root.ramUsageSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.ramUsage = Number(value) || 0
    }

    Sensors.Sensor {
        id: gpuTempSensorObj
        sensorId: root.gpuTempSensor
        enabled: root.showGpu && root.gpuTempSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.gpuTemp = Number(value) || 0
    }

    Sensors.Sensor {
        id: gpuUsageSensorObj
        sensorId: root.gpuUsageSensor
        enabled: root.showGpu && root.gpuUsageSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.gpuUsage = Number(value) || 0
    }

    Sensors.Sensor {
        id: storageUsageSensorObj
        sensorId: root.storageUsageSensor
        enabled: root.showStorage && root.storageUsageSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.storageUsage = Number(value) || 0
    }

    Sensors.Sensor {
        id: networkDownloadSensorObj
        sensorId: root.networkDownloadSensor
        enabled: root.showNetwork && root.networkDownloadSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.networkDownload = Number(value) || 0
    }

    Sensors.Sensor {
        id: networkUploadSensorObj
        sensorId: root.networkUploadSensor
        enabled: root.showNetwork && root.networkUploadSensor.length > 0
        updateRateLimit: root.updateInterval
        onValueChanged: root.networkUpload = Number(value) || 0
    }

    Sensors.Sensor {
        id: totalSensor
        sensorId: Plasmoid.faceController?.totalSensors[0] || ""
        enabled: !root.useOriginalStyle && sensorId.length > 0
        updateRateLimit: Plasmoid.faceController?.updateRateLimit ?? root.updateInterval
    }

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName)
        }
    }

    compactRepresentation: RowLayout {
        id: compactHost

        readonly property real sensorTempImplicitWidth: sensorTempCompact.implicitWidth

        spacing: 0
        Layout.minimumWidth: root.useOriginalStyle
            ? sensorTempCompact.Layout.minimumWidth
            : kdeSystemMonitorCompact.Layout.minimumWidth
        Layout.minimumHeight: root.useOriginalStyle
            ? sensorTempCompact.Layout.minimumHeight
            : kdeSystemMonitorCompact.Layout.minimumHeight
        Layout.preferredWidth: root.useOriginalStyle
            ? sensorTempCompact.Layout.preferredWidth
            : kdeSystemMonitorCompact.Layout.preferredWidth
        Layout.preferredHeight: root.useOriginalStyle
            ? sensorTempCompact.Layout.preferredHeight
            : kdeSystemMonitorCompact.Layout.preferredHeight
        Layout.maximumWidth: root.useOriginalStyle
            ? sensorTempCompact.Layout.maximumWidth
            : kdeSystemMonitorCompact.Layout.maximumWidth
        Layout.maximumHeight: root.useOriginalStyle
            ? sensorTempCompact.Layout.maximumHeight
            : kdeSystemMonitorCompact.Layout.maximumHeight
        Layout.fillWidth: root.useOriginalStyle
            ? sensorTempCompact.Layout.fillWidth
            : kdeSystemMonitorCompact.Layout.fillWidth
        Layout.fillHeight: root.useOriginalStyle
            ? sensorTempCompact.Layout.fillHeight
            : kdeSystemMonitorCompact.Layout.fillHeight

        SensorTempCompactRepresentation {
            id: sensorTempCompact
            monitor: root
            visible: root.useOriginalStyle
            Layout.alignment: Qt.AlignVCenter
        }

        KdeSystemMonitorCompactRepresentation {
            id: kdeSystemMonitorCompact
            monitor: root
            visible: !root.useOriginalStyle
            Layout.alignment: Qt.AlignVCenter
        }
    }

    fullRepresentation: ColumnLayout {
        id: fullHost

        spacing: 0
        Layout.minimumWidth: root.useOriginalStyle
            ? sensorTempFull.Layout.minimumWidth
            : kdeSystemMonitorFull.Layout.minimumWidth
        Layout.minimumHeight: root.useOriginalStyle
            ? sensorTempFull.Layout.minimumHeight
            : kdeSystemMonitorFull.Layout.minimumHeight
        Layout.preferredWidth: root.useOriginalStyle
            ? sensorTempFull.Layout.preferredWidth
            : kdeSystemMonitorFull.Layout.preferredWidth
        Layout.preferredHeight: root.useOriginalStyle
            ? sensorTempFull.Layout.preferredHeight
            : kdeSystemMonitorFull.Layout.preferredHeight
        Layout.maximumWidth: root.useOriginalStyle
            ? sensorTempFull.Layout.maximumWidth
            : kdeSystemMonitorFull.Layout.maximumWidth
        Layout.maximumHeight: root.useOriginalStyle
            ? sensorTempFull.Layout.maximumHeight
            : kdeSystemMonitorFull.Layout.maximumHeight
        Layout.fillWidth: root.useOriginalStyle
            ? sensorTempFull.Layout.fillWidth
            : kdeSystemMonitorFull.Layout.fillWidth
        Layout.fillHeight: root.useOriginalStyle
            ? sensorTempFull.Layout.fillHeight
            : kdeSystemMonitorFull.Layout.fillHeight

        SensorTempFullRepresentation {
            id: sensorTempFull
            monitor: root
            compactImplicitWidth: root.compactRepresentationItem?.sensorTempImplicitWidth ?? 0
            visible: root.useOriginalStyle
            Layout.fillWidth: true
        }

        KdeSystemMonitorFullRepresentation {
            id: kdeSystemMonitorFull
            monitor: root
            visible: !root.useOriginalStyle
            Layout.fillWidth: true
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton
        onClicked: root.openSystemMonitor()
    }

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18nc("@action", "Open System Monitor…")
            icon.name: "utilities-system-monitor"
            onTriggered: root.openSystemMonitor()
        }
    ]
}
