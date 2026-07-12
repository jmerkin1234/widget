import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

RowLayout {
    id: root

    property alias text: fontFamilyField.text
    property string label: ""

    Kirigami.FormData.label: root.label
    Layout.fillWidth: true
    spacing: Kirigami.Units.smallSpacing

    TextField {
        id: fontFamilyField
        Layout.fillWidth: true
        placeholderText: "Sans Serif"
    }

    Button {
        text: i18n("Pick")
        onClicked: {
            fontDialog.selectedFont = Qt.font({
                family: fontFamilyField.text.length > 0 ? fontFamilyField.text : "Sans Serif"
            })
            fontDialog.open()
        }
    }

    FontDialog {
        id: fontDialog
        onAccepted: fontFamilyField.text = selectedFont.family
    }
}
