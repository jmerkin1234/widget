import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: cpuPage
    
    property alias cfg_showCpu: showCpuCheckBox.checked
    property alias cfg_cpuFontSize: cpuFontSizeSpinBox.value
    property alias cfg_cpuFontColor: cpuColorField.text
    property alias cfg_cpuLabelColor: cpuLabelColorField.text
    property alias cfg_cpuBold: cpuBoldCheckBox.checked
    property alias cfg_cpuPrecision: cpuPrecisionCheckBox.checked
    property alias cfg_cpuUseIcon: cpuUseIconCheckBox.checked
    property alias cfg_cpuIconPath: cpuIconPathField.text
    property alias cfg_cpuIconSize: cpuIconSizeSpinBox.value
    property alias cfg_cpuTempSensor: cpuTempSensorField.text
    property alias cfg_cpuUsageSensor: cpuUsageSensorField.text
    
    CheckBox {
        id: showCpuCheckBox
        Kirigami.FormData.label: i18n("Show CPU:")
        text: i18n("Display CPU information")
        checked: true
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Appearance")
    }
    
    SpinBox {
        id: cpuFontSizeSpinBox
        Kirigami.FormData.label: i18n("Font size:")
        from: 8
        to: 48
        stepSize: 1
        value: 12
        enabled: showCpuCheckBox.checked
    }
    
    ColorField {
        id: cpuColorField
        label: i18n("Value color:")
        text: "#00FF00"
        enabled: showCpuCheckBox.checked
    }
    
    ColorField {
        id: cpuLabelColorField
        label: i18n("Label color:")
        text: "#FFFFFF"
        enabled: showCpuCheckBox.checked && !cpuUseIconCheckBox.checked
    }
    
    CheckBox {
        id: cpuBoldCheckBox
        Kirigami.FormData.label: i18n("Bold:")
        text: i18n("Use bold text")
        checked: false
        enabled: showCpuCheckBox.checked
    }
    
    CheckBox {
        id: cpuPrecisionCheckBox
        Kirigami.FormData.label: i18n("Decimal:")
        text: i18n("Show 1.9% under 10%")
        checked: false
        enabled: showCpuCheckBox.checked
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Label Type")
    }
    
    CheckBox {
        id: cpuUseIconCheckBox
        Kirigami.FormData.label: i18n("Use icon:")
        text: i18n("Show icon instead of text")
        checked: false
        enabled: showCpuCheckBox.checked
    }
    
    TextField {
        id: cpuIconPathField
        Kirigami.FormData.label: i18n("Icon name/path:")
        text: "cpu"
        enabled: showCpuCheckBox.checked && cpuUseIconCheckBox.checked
    }
    
    SpinBox {
        id: cpuIconSizeSpinBox
        Kirigami.FormData.label: i18n("Icon size:")
        from: 8
        to: 64
        stepSize: 1
        value: 16
        enabled: showCpuCheckBox.checked && cpuUseIconCheckBox.checked
    }
    
    Label {
        text: i18n("Icon names: cpu, processor, chip\nOr full path: /home/user/icon.png")
        opacity: 0.7
        visible: cpuUseIconCheckBox.checked
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Sensors")
    }
    
    SensorPicker {
        id: cpuTempSensorField
        label: i18n("Temperature sensor:")
        text: "cpu/cpu0/temperature"
        enabled: showCpuCheckBox.checked
    }
    
    SensorPicker {
        id: cpuUsageSensorField
        label: i18n("Usage sensor:")
        text: "cpu/all/usage"
        enabled: showCpuCheckBox.checked
    }
}
