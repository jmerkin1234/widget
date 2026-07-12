import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

Kirigami.FormLayout {
    id: generalPage
    
    property alias cfg_updateInterval: updateIntervalSpinBox.value
    property alias cfg_spacing: spacingSpinBox.value
    property alias cfg_labelFontSize: labelFontSizeSpinBox.value
    property alias cfg_fontFamily: fontPicker.text
    property alias cfg_autoFullView: autoFullViewCheckBox.checked
    
    CheckBox {
        id: autoFullViewCheckBox
        visible: Plasmoid.faceController?.faceId !== "org.kde.ksysguard.sensordaddyoriginal"
        Kirigami.FormData.label: i18n("Adaptive layout:")
        text: i18n("Show detailed view on the desktop, compact view in panels")
        checked: false
    }

    Label {
        text: i18n("Ported from the stock System Monitor Sensor widget. When on, the desktop shows the full detailed list, and panels automatically switch to it if there's enough room.")
        wrapMode: Text.WordWrap
        opacity: 0.7
        Layout.maximumWidth: 300
        visible: autoFullViewCheckBox.visible && autoFullViewCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
    }

    SpinBox {
        id: updateIntervalSpinBox
        Kirigami.FormData.label: i18n("Update interval (ms):")
        from: 500
        to: 10000
        stepSize: 100
        value: 2000
    }
    
    SpinBox {
        id: spacingSpinBox
        Kirigami.FormData.label: i18n("Item spacing:")
        from: 0
        to: 30
        stepSize: 1
        value: 8
    }
    
    SpinBox {
        id: labelFontSizeSpinBox
        Kirigami.FormData.label: i18n("Label font size:")
        from: 8
        to: 48
        stepSize: 1
        value: 11
    }

    FontPicker {
        id: fontPicker
        label: i18n("Font family:")
    }
    
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Sensor Information")
    }
    
    Label {
        text: i18n("Click any sensor field to browse the full KDE sensor tree with search, categories, and the sensors exposed by your system.\n\nLabel and value colors are configured in each CPU/RAM/GPU/Storage/Network tab.")
        wrapMode: Text.WordWrap
        opacity: 0.7
        Layout.maximumWidth: 300
    }
}
