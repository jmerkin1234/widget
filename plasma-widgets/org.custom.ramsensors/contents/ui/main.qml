import QtQuick
import QtQuick.Layouts
import org.kde.plasmoid
import org.kde.ksysguard.sensors as Sensors

Item {
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    property bool showIcon: Plasmoid.configuration.showIcon || false
    property bool showLabel: Plasmoid.configuration.showLabel !== false
    property string textColor: Plasmoid.configuration.textColor || "#ffff00"
    property int fontSize: Plasmoid.configuration.fontSize || 30
    property int iconSize: Plasmoid.configuration.iconSize || 30

    Plasmoid.compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/ram.png")
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
                if (showLabel) parts.push("RAM")
                parts.push(ramUsed.formattedValue)
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
        id: ramUsed
        sensorId: "memory/physical/usedPercent"
        updateRateLimit: 1000
    }
}
