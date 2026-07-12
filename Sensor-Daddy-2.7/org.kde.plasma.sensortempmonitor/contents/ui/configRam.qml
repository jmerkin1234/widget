import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: ramPage
    
    property alias cfg_showRam: showRamCheckBox.checked
    property alias cfg_ramFontSize: ramFontSizeSpinBox.value
    property alias cfg_ramFontColor: ramColorField.text
    property alias cfg_ramLabelColor: ramLabelColorField.text
    property alias cfg_ramBold: ramBoldCheckBox.checked
    property alias cfg_ramPrecision: ramPrecisionCheckBox.checked
    property alias cfg_ramUseIcon: ramUseIconCheckBox.checked
    property alias cfg_ramIconPath: ramIconPathField.text
    property alias cfg_ramIconSize: ramIconSizeSpinBox.value
    property alias cfg_ramUsageSensor: ramUsageSensorField.text
    
    CheckBox {
        id: showRamCheckBox
        Kirigami.FormData.label: i18n("Show RAM:")
        text: i18n("Display RAM information")
        checked: true
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Appearance")
    }
    
    SpinBox {
        id: ramFontSizeSpinBox
        Kirigami.FormData.label: i18n("Font size:")
        from: 8
        to: 48
        stepSize: 1
        value: 12
        enabled: showRamCheckBox.checked
    }
    
    ColorField {
        id: ramColorField
        label: i18n("Value color:")
        text: "#00BFFF"
        enabled: showRamCheckBox.checked
    }
    
    ColorField {
        id: ramLabelColorField
        label: i18n("Label color:")
        text: "#FFFFFF"
        enabled: showRamCheckBox.checked && !ramUseIconCheckBox.checked
    }
    
    CheckBox {
        id: ramBoldCheckBox
        Kirigami.FormData.label: i18n("Bold:")
        text: i18n("Use bold text")
        checked: false
        enabled: showRamCheckBox.checked
    }
    
    CheckBox {
        id: ramPrecisionCheckBox
        Kirigami.FormData.label: i18n("Decimal:")
        text: i18n("Show 1.9% under 10%")
        checked: false
        enabled: showRamCheckBox.checked
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Label Type")
    }
    
    CheckBox {
        id: ramUseIconCheckBox
        Kirigami.FormData.label: i18n("Use icon:")
        text: i18n("Show icon instead of text")
        checked: false
        enabled: showRamCheckBox.checked
    }
    
    TextField {
        id: ramIconPathField
        Kirigami.FormData.label: i18n("Icon name/path:")
        text: "memory"
        enabled: showRamCheckBox.checked && ramUseIconCheckBox.checked
    }
    
    SpinBox {
        id: ramIconSizeSpinBox
        Kirigami.FormData.label: i18n("Icon size:")
        from: 8
        to: 64
        stepSize: 1
        value: 16
        enabled: showRamCheckBox.checked && ramUseIconCheckBox.checked
    }
    
    Label {
        text: i18n("Icon names: memory, ram\nOr full path: /home/user/icon.png")
        opacity: 0.7
        visible: ramUseIconCheckBox.checked
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Sensors")
    }
    
    SensorPicker {
        id: ramUsageSensorField
        label: i18n("Usage sensor:")
        text: "memory/physical/usedPercent"
        enabled: showRamCheckBox.checked
    }
}
