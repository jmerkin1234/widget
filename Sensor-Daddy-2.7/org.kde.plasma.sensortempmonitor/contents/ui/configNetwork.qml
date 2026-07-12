import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: networkPage

    property alias cfg_showNetwork: showNetworkCheckBox.checked
    property alias cfg_networkFontSize: networkFontSizeSpinBox.value
    property alias cfg_networkFontColor: networkColorField.text
    property alias cfg_networkLabelColor: networkLabelColorField.text
    property alias cfg_networkBold: networkBoldCheckBox.checked
    property alias cfg_networkFixedWidth: networkFixedWidthCheckBox.checked
    property alias cfg_networkUnit: networkUnitComboBox.currentIndex
    property alias cfg_networkUseIcon: networkUseIconCheckBox.checked
    property alias cfg_networkIconPath: networkIconPathField.text
    property alias cfg_networkIconSize: networkIconSizeSpinBox.value
    property alias cfg_networkDownloadSensor: networkDownloadSensorField.text
    property alias cfg_networkUploadSensor: networkUploadSensorField.text

    CheckBox {
        id: showNetworkCheckBox
        Kirigami.FormData.label: i18n("Show Network:")
        text: i18n("Display network information")
        checked: false
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Appearance")
    }

    SpinBox {
        id: networkFontSizeSpinBox
        Kirigami.FormData.label: i18n("Font size:")
        from: 8
        to: 48
        stepSize: 1
        value: 12
        enabled: showNetworkCheckBox.checked
    }

    ColorField {
        id: networkColorField
        label: i18n("Value color:")
        text: "#B388FF"
        enabled: showNetworkCheckBox.checked
    }

    ColorField {
        id: networkLabelColorField
        label: i18n("Label color:")
        text: "#FFFFFF"
        enabled: showNetworkCheckBox.checked && !networkUseIconCheckBox.checked
    }

    CheckBox {
        id: networkBoldCheckBox
        Kirigami.FormData.label: i18n("Bold:")
        text: i18n("Use bold text")
        checked: false
        enabled: showNetworkCheckBox.checked
    }

    CheckBox {
        id: networkFixedWidthCheckBox
        Kirigami.FormData.label: i18n("Stable panel width:")
        text: i18n("Freeze download and upload at their current widths")
        checked: false
        enabled: showNetworkCheckBox.checked
    }

    Label {
        text: i18n("Enable this when the displayed values are the width you want. Future value changes will not shift panel items.")
        wrapMode: Text.WordWrap
        opacity: 0.7
        Layout.maximumWidth: 300
        visible: networkFixedWidthCheckBox.checked
    }

    ComboBox {
        id: networkUnitComboBox
        Kirigami.FormData.label: i18n("Speed unit:")
        model: [
            i18n("Auto"),
            i18n("KB/s"),
            i18n("MB/s"),
            i18n("GB/s")
        ]
        currentIndex: 0
        enabled: showNetworkCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Label Type")
    }

    CheckBox {
        id: networkUseIconCheckBox
        Kirigami.FormData.label: i18n("Use icon:")
        text: i18n("Show icon instead of text")
        checked: false
        enabled: showNetworkCheckBox.checked
    }

    TextField {
        id: networkIconPathField
        Kirigami.FormData.label: i18n("Icon name/path:")
        text: "network-wired"
        enabled: showNetworkCheckBox.checked && networkUseIconCheckBox.checked
    }

    SpinBox {
        id: networkIconSizeSpinBox
        Kirigami.FormData.label: i18n("Icon size:")
        from: 8
        to: 64
        stepSize: 1
        value: 16
        enabled: showNetworkCheckBox.checked && networkUseIconCheckBox.checked
    }

    Label {
        text: i18n("Icon names: network-wired, network-wireless, network-connect")
        opacity: 0.7
        visible: networkUseIconCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Sensors")
    }

    SensorPicker {
        id: networkDownloadSensorField
        label: i18n("Download sensor:")
        text: "network/all/download"
        enabled: showNetworkCheckBox.checked
    }

    SensorPicker {
        id: networkUploadSensorField
        label: i18n("Upload sensor:")
        text: "network/all/upload"
        enabled: showNetworkCheckBox.checked
    }
}
