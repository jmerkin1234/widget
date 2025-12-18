import QtQuick
import QtQuick.Layouts
import org.kde.plasmoid
import org.kde.ksysguard.sensors as Sensors

Item {
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    property bool showUsage: Plasmoid.configuration.showUsage
    property bool showTemp: Plasmoid.configuration.showTemp
    property bool showIcon: Plasmoid.configuration.showIcon || false
    property bool showLabel: Plasmoid.configuration.showLabel !== false
    property string textColor: Plasmoid.configuration.textColor || "#00ff00"
    property int fontSize: Plasmoid.configuration.fontSize || 30
    property int iconSize: Plasmoid.configuration.iconSize || 30

    Plasmoid.compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/cpu.png")
            width: iconSize
            height: iconSize
            Layout.preferredWidth: iconSize
            Layout.preferredHeight: iconSize
            visible: showIcon
            fillMode: Image.PreserveAspectFit
        }

        Text {
            text: {
                let parts = []
                if (showLabel) parts.push("CPU")
                if (showUsage) parts.push(cpuUsage.formattedValue)
                if (showTemp) parts.push(cpuTemp.formattedValue)
                return parts.join(" ")
            }
            font.pointSize: fontSize
            color: textColor
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.minimumWidth: implicitWidth
            visible: text.length > 0
        }
    }

    Sensors.Sensor {
        id: cpuUsage
        sensorId: "cpu/all/usage"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: cpuTemp
        sensorId: "cpu/all/averageTemperature"
        updateRateLimit: 1000
    }
}
