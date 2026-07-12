import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

RowLayout {
    id: root

    property alias text: colorInput.text
    property string label: ""

    Kirigami.FormData.label: root.label
    Layout.fillWidth: true
    spacing: Kirigami.Units.smallSpacing

    function channelToHex(value) {
        var text = Math.round(value * 255).toString(16)
        return text.length === 1 ? "0" + text : text
    }

    function colorToHex(value) {
        return "#" + channelToHex(value.r) + channelToHex(value.g) + channelToHex(value.b)
    }

    TextField {
        id: colorInput
        Layout.fillWidth: true
        placeholderText: "#FFFFFF"
    }

    Rectangle {
        Layout.preferredWidth: Kirigami.Units.gridUnit
        Layout.preferredHeight: Kirigami.Units.gridUnit
        radius: 3
        color: colorInput.text.length > 0 ? colorInput.text : "transparent"
        border.color: Kirigami.Theme.textColor
        border.width: 1
        opacity: root.enabled ? 1 : 0.5
    }

    Button {
        text: i18n("Pick")
        onClicked: {
            colorDialog.selectedColor = colorInput.text.length > 0 ? colorInput.text : "#ffffff"
            colorDialog.open()
        }
    }

    ColorDialog {
        id: colorDialog
        onAccepted: colorInput.text = root.colorToHex(selectedColor)
    }
}
