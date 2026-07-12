import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Appearance")
        icon: "preferences-desktop-color"
        source: "systemmonitor/config/ConfigAppearance.qml"
    }
    ConfigCategory {
        name: i18n("CPU")
        icon: "cpu"
        source: "configCpu.qml"
    }
    ConfigCategory {
        name: i18n("RAM")
        icon: "memory"
        source: "configRam.qml"
    }
    ConfigCategory {
        name: i18n("GPU")
        icon: "video-display"
        source: "configGpu.qml"
    }
    ConfigCategory {
        name: i18n("Storage")
        icon: "drive-harddisk"
        source: "configStorage.qml"
    }
    ConfigCategory {
        name: i18n("Network")
        icon: "network-wired"
        source: "configNetwork.qml"
    }
}
