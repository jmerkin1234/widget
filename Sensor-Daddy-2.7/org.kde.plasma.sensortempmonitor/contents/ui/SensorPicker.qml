import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.ksysguard.faces as Faces

Faces.Choices {
    id: root

    property string text: ""
    property string label: ""
    property bool syncing: false

    Kirigami.FormData.label: root.label
    Layout.fillWidth: true

    // KDE's picker blocks opening when maxAllowedSensors is already reached.
    // Allow a temporary second pick, then keep only the newest selected sensor.
    maxAllowedSensors: 2
    supportsColors: false
    labelsEditable: false

    function selectedSensorId() {
        return root.selected && root.selected.length > 0 ? root.selected[root.selected.length - 1] : ""
    }

    function syncSelectedFromText() {
        if (root.syncing) {
            return
        }

        var current = root.selectedSensorId()
        if (current === root.text) {
            return
        }

        root.syncing = true
        root.selected = root.text.length > 0 ? [root.text] : []
        root.syncing = false
    }

    onTextChanged: syncSelectedFromText()

    onSelectedChanged: {
        if (root.syncing) {
            return
        }

        var nextText = root.selectedSensorId()
        var selectedCount = root.selected ? root.selected.length : 0
        if (root.text === nextText && selectedCount <= 1) {
            return
        }

        root.syncing = true
        if (selectedCount > 1) {
            root.selected = nextText.length > 0 ? [nextText] : []
        }
        root.text = nextText
        root.syncing = false
    }

    Component.onCompleted: syncSelectedFromText()
}
