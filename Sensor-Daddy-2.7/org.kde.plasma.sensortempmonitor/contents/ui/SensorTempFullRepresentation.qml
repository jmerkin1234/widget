import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

ColumnLayout {
    id: fullRoot

    required property var monitor
    required property real compactImplicitWidth

    spacing: 10
    Layout.preferredWidth: Math.max(300, compactImplicitWidth + 40)
    Layout.preferredHeight: 320

    PlasmaComponents.Label {
        text: i18n("Sensor Daddy")
        font.family: fullRoot.monitor.fontFamily
        font.bold: true
        font.pixelSize: 16
        Layout.alignment: Qt.AlignHCenter
    }

    ColumnLayout {
        visible: fullRoot.monitor.showCpu
        spacing: 4

        PlasmaComponents.Label {
            text: "CPU"
            font.family: fullRoot.monitor.fontFamily
            font.bold: fullRoot.monitor.cpuBold
            color: fullRoot.monitor.cpuLabelColor
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Temperature:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.formatValue(fullRoot.monitor.cpuTemp, fullRoot.monitor.cpuPrecision) + "°C"
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.cpuBold
                color: fullRoot.monitor.cpuFontColor
            }
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Usage:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.formatValue(fullRoot.monitor.cpuUsage, fullRoot.monitor.cpuPrecision) + "%"
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.cpuBold
                color: fullRoot.monitor.cpuFontColor
            }
        }
    }

    Rectangle {
        visible: false
        height: 1
        Layout.fillWidth: true
        color: Kirigami.Theme.textColor
        opacity: 0.2
    }

    ColumnLayout {
        visible: fullRoot.monitor.showRam
        spacing: 4

        PlasmaComponents.Label {
            text: "RAM"
            font.family: fullRoot.monitor.fontFamily
            font.bold: fullRoot.monitor.ramBold
            color: fullRoot.monitor.ramLabelColor
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Usage:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.formatValue(fullRoot.monitor.ramUsage, fullRoot.monitor.ramPrecision) + "%"
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.ramBold
                color: fullRoot.monitor.ramFontColor
            }
        }
    }

    Rectangle {
        visible: false
        height: 1
        Layout.fillWidth: true
        color: Kirigami.Theme.textColor
        opacity: 0.2
    }

    ColumnLayout {
        visible: fullRoot.monitor.showGpu
        spacing: 4

        PlasmaComponents.Label {
            text: "GPU"
            font.family: fullRoot.monitor.fontFamily
            font.bold: fullRoot.monitor.gpuBold
            color: fullRoot.monitor.gpuLabelColor
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Temperature:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.formatValue(fullRoot.monitor.gpuTemp, fullRoot.monitor.gpuPrecision) + "°C"
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.gpuBold
                color: fullRoot.monitor.gpuFontColor
            }
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Usage:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.formatValue(fullRoot.monitor.gpuUsage, fullRoot.monitor.gpuPrecision) + "%"
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.gpuBold
                color: fullRoot.monitor.gpuFontColor
            }
        }
    }

    Rectangle {
        visible: false
        height: 1
        Layout.fillWidth: true
        color: Kirigami.Theme.textColor
        opacity: 0.2
    }

    ColumnLayout {
        visible: fullRoot.monitor.showStorage
        spacing: 4

        PlasmaComponents.Label {
            text: i18n("Storage")
            font.family: fullRoot.monitor.fontFamily
            font.bold: fullRoot.monitor.storageBold
            color: fullRoot.monitor.storageLabelColor
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Usage:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.formatValue(fullRoot.monitor.storageUsage, fullRoot.monitor.storagePrecision) + "%"
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.storageBold
                color: fullRoot.monitor.storageFontColor
            }
        }
    }

    Rectangle {
        visible: false
        height: 1
        Layout.fillWidth: true
        color: Kirigami.Theme.textColor
        opacity: 0.2
    }

    ColumnLayout {
        visible: fullRoot.monitor.showNetwork
        spacing: 4

        PlasmaComponents.Label {
            text: i18n("Network")
            font.family: fullRoot.monitor.fontFamily
            font.bold: fullRoot.monitor.networkBold
            color: fullRoot.monitor.networkLabelColor
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Download:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.networkDownloadText
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.networkBold
                color: fullRoot.monitor.networkFontColor
            }
        }
        RowLayout {
            PlasmaComponents.Label {
                text: i18n("Upload:")
                font.family: fullRoot.monitor.fontFamily
            }
            PlasmaComponents.Label {
                text: fullRoot.monitor.networkUploadText
                font.family: fullRoot.monitor.fontFamily
                font.bold: fullRoot.monitor.networkBold
                color: fullRoot.monitor.networkFontColor
            }
        }
    }

    Item {
        Layout.fillHeight: true
    }
}
