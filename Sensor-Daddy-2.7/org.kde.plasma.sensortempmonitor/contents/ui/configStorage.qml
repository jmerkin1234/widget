import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: storagePage

    property alias cfg_showStorage: showStorageCheckBox.checked
    property alias cfg_storageFontSize: storageFontSizeSpinBox.value
    property alias cfg_storageFontColor: storageColorField.text
    property alias cfg_storageLabelColor: storageLabelColorField.text
    property alias cfg_storageBold: storageBoldCheckBox.checked
    property alias cfg_storagePrecision: storagePrecisionCheckBox.checked
    property alias cfg_storageUseIcon: storageUseIconCheckBox.checked
    property alias cfg_storageIconPath: storageIconPathField.text
    property alias cfg_storageIconSize: storageIconSizeSpinBox.value
    property alias cfg_storageUsageSensor: storageUsageSensorField.text

    CheckBox {
        id: showStorageCheckBox
        Kirigami.FormData.label: i18n("Show Storage:")
        text: i18n("Display storage information")
        checked: false
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Appearance")
    }

    SpinBox {
        id: storageFontSizeSpinBox
        Kirigami.FormData.label: i18n("Font size:")
        from: 8
        to: 48
        stepSize: 1
        value: 12
        enabled: showStorageCheckBox.checked
    }

    ColorField {
        id: storageColorField
        label: i18n("Value color:")
        text: "#FFD54F"
        enabled: showStorageCheckBox.checked
    }

    ColorField {
        id: storageLabelColorField
        label: i18n("Label color:")
        text: "#FFFFFF"
        enabled: showStorageCheckBox.checked && !storageUseIconCheckBox.checked
    }

    CheckBox {
        id: storageBoldCheckBox
        Kirigami.FormData.label: i18n("Bold:")
        text: i18n("Use bold text")
        checked: false
        enabled: showStorageCheckBox.checked
    }

    CheckBox {
        id: storagePrecisionCheckBox
        Kirigami.FormData.label: i18n("Decimal:")
        text: i18n("Show 1.9% under 10%")
        checked: false
        enabled: showStorageCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Label Type")
    }

    CheckBox {
        id: storageUseIconCheckBox
        Kirigami.FormData.label: i18n("Use icon:")
        text: i18n("Show icon instead of text")
        checked: false
        enabled: showStorageCheckBox.checked
    }

    TextField {
        id: storageIconPathField
        Kirigami.FormData.label: i18n("Icon name/path:")
        text: "drive-harddisk"
        enabled: showStorageCheckBox.checked && storageUseIconCheckBox.checked
    }

    SpinBox {
        id: storageIconSizeSpinBox
        Kirigami.FormData.label: i18n("Icon size:")
        from: 8
        to: 64
        stepSize: 1
        value: 16
        enabled: showStorageCheckBox.checked && storageUseIconCheckBox.checked
    }

    Label {
        text: i18n("Icon names: drive-harddisk, drive-harddisk-solidstate, folder")
        opacity: 0.7
        visible: storageUseIconCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Sensors")
    }

    SensorPicker {
        id: storageUsageSensorField
        label: i18n("Usage sensor:")
        text: "disk/all/usedPercent"
        enabled: showStorageCheckBox.checked
    }
}
