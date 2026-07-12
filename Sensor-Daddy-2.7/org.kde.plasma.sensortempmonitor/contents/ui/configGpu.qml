import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: gpuPage
    
    property alias cfg_showGpu: showGpuCheckBox.checked
    property alias cfg_gpuFontSize: gpuFontSizeSpinBox.value
    property alias cfg_gpuFontColor: gpuColorField.text
    property alias cfg_gpuLabelColor: gpuLabelColorField.text
    property alias cfg_gpuBold: gpuBoldCheckBox.checked
    property alias cfg_gpuPrecision: gpuPrecisionCheckBox.checked
    property alias cfg_gpuUseIcon: gpuUseIconCheckBox.checked
    property alias cfg_gpuIconPath: gpuIconPathField.text
    property alias cfg_gpuIconSize: gpuIconSizeSpinBox.value
    property alias cfg_gpuTempSensor: gpuTempSensorField.text
    property alias cfg_gpuUsageSensor: gpuUsageSensorField.text
    
    CheckBox {
        id: showGpuCheckBox
        Kirigami.FormData.label: i18n("Show GPU:")
        text: i18n("Display GPU information")
        checked: true
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Appearance")
    }
    
    SpinBox {
        id: gpuFontSizeSpinBox
        Kirigami.FormData.label: i18n("Font size:")
        from: 8
        to: 48
        stepSize: 1
        value: 12
        enabled: showGpuCheckBox.checked
    }
    
    ColorField {
        id: gpuColorField
        label: i18n("Value color:")
        text: "#FF6600"
        enabled: showGpuCheckBox.checked
    }
    
    ColorField {
        id: gpuLabelColorField
        label: i18n("Label color:")
        text: "#FFFFFF"
        enabled: showGpuCheckBox.checked && !gpuUseIconCheckBox.checked
    }
    
    CheckBox {
        id: gpuBoldCheckBox
        Kirigami.FormData.label: i18n("Bold:")
        text: i18n("Use bold text")
        checked: false
        enabled: showGpuCheckBox.checked
    }
    
    CheckBox {
        id: gpuPrecisionCheckBox
        Kirigami.FormData.label: i18n("Decimal:")
        text: i18n("Show 1.9% under 10%")
        checked: false
        enabled: showGpuCheckBox.checked
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Label Type")
    }
    
    CheckBox {
        id: gpuUseIconCheckBox
        Kirigami.FormData.label: i18n("Use icon:")
        text: i18n("Show icon instead of text")
        checked: false
        enabled: showGpuCheckBox.checked
    }
    
    TextField {
        id: gpuIconPathField
        Kirigami.FormData.label: i18n("Icon name/path:")
        text: "gpu"
        enabled: showGpuCheckBox.checked && gpuUseIconCheckBox.checked
    }
    
    SpinBox {
        id: gpuIconSizeSpinBox
        Kirigami.FormData.label: i18n("Icon size:")
        from: 8
        to: 64
        stepSize: 1
        value: 16
        enabled: showGpuCheckBox.checked && gpuUseIconCheckBox.checked
    }
    
    Label {
        text: i18n("Icon names: gpu, video-display, graphics-card\nOr full path: /home/user/icon.png")
        opacity: 0.7
        visible: gpuUseIconCheckBox.checked
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Sensors")
    }
    
    SensorPicker {
        id: gpuTempSensorField
        label: i18n("Temperature sensor:")
        text: "gpu/gpu0/temperature"
        enabled: showGpuCheckBox.checked
    }
    
    SensorPicker {
        id: gpuUsageSensorField
        label: i18n("Usage sensor:")
        text: "gpu/gpu0/usage"
        enabled: showGpuCheckBox.checked
    }
}
