import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Item {
    id: compactRoot

    required property var monitor

    implicitWidth: compactRow.implicitWidth
    implicitHeight: Math.max(compactRow.implicitHeight, Kirigami.Units.gridUnit)
    Layout.minimumWidth: implicitWidth
    Layout.preferredWidth: implicitWidth
    Layout.minimumHeight: implicitHeight
    Layout.preferredHeight: implicitHeight
    clip: true

    property real lockedDownloadWidth: 0
    property real lockedUploadWidth: 0

    function captureNetworkWidths() {
        lockedDownloadWidth = Math.ceil(downloadValueMetrics.width)
        lockedUploadWidth = Math.ceil(uploadValueMetrics.width)
    }

    TextMetrics {
        id: downloadValueMetrics
        font.family: compactRoot.monitor.fontFamily
        font.pixelSize: compactRoot.monitor.networkFontSize
        font.bold: compactRoot.monitor.networkBold
        text: compactRoot.monitor.networkDownloadText
        onWidthChanged: {
            if (!compactRoot.monitor.networkFixedWidth) {
                compactRoot.lockedDownloadWidth = Math.ceil(width)
            }
        }
    }

    TextMetrics {
        id: uploadValueMetrics
        font.family: compactRoot.monitor.fontFamily
        font.pixelSize: compactRoot.monitor.networkFontSize
        font.bold: compactRoot.monitor.networkBold
        text: compactRoot.monitor.networkUploadText
        onWidthChanged: {
            if (!compactRoot.monitor.networkFixedWidth) {
                compactRoot.lockedUploadWidth = Math.ceil(width)
            }
        }
    }

    Connections {
        target: compactRoot.monitor

        function onNetworkFixedWidthChanged() {
            if (compactRoot.monitor.networkFixedWidth) {
                compactRoot.captureNetworkWidths()
            }
        }
    }

    Component.onCompleted: captureNetworkWidths()

    RowLayout {
        id: compactRow
        anchors.centerIn: parent
        spacing: compactRoot.monitor.spacing

        RowLayout {
            visible: compactRoot.monitor.showCpu
            spacing: 2
            Layout.alignment: Qt.AlignVCenter

            Text {
                visible: !compactRoot.monitor.cpuUseIcon
                text: "CPU"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.labelFontSize
                font.bold: compactRoot.monitor.cpuBold
                color: compactRoot.monitor.cpuLabelColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Kirigami.Icon {
                visible: compactRoot.monitor.cpuUseIcon
                source: compactRoot.monitor.cpuIconPath
                Layout.preferredWidth: compactRoot.monitor.cpuIconSize
                Layout.preferredHeight: compactRoot.monitor.cpuIconSize
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                text: compactRoot.monitor.formatValue(compactRoot.monitor.cpuTemp, compactRoot.monitor.cpuPrecision) + "°C"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.cpuFontSize
                font.bold: compactRoot.monitor.cpuBold
                color: compactRoot.monitor.cpuFontColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                text: compactRoot.monitor.formatValue(compactRoot.monitor.cpuUsage, compactRoot.monitor.cpuPrecision) + "%"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.cpuFontSize
                font.bold: compactRoot.monitor.cpuBold
                color: compactRoot.monitor.cpuFontColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Rectangle {
            visible: false
            color: Kirigami.Theme.textColor
            opacity: 0.4
            Layout.preferredWidth: 1
            Layout.preferredHeight: Math.max(12, compactRow.implicitHeight * 0.55)
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            visible: compactRoot.monitor.showRam
            spacing: 2
            Layout.alignment: Qt.AlignVCenter

            Text {
                visible: !compactRoot.monitor.ramUseIcon
                text: "RAM"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.labelFontSize
                font.bold: compactRoot.monitor.ramBold
                color: compactRoot.monitor.ramLabelColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Kirigami.Icon {
                visible: compactRoot.monitor.ramUseIcon
                source: compactRoot.monitor.ramIconPath
                Layout.preferredWidth: compactRoot.monitor.ramIconSize
                Layout.preferredHeight: compactRoot.monitor.ramIconSize
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                text: compactRoot.monitor.formatValue(compactRoot.monitor.ramUsage, compactRoot.monitor.ramPrecision) + "%"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.ramFontSize
                font.bold: compactRoot.monitor.ramBold
                color: compactRoot.monitor.ramFontColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Rectangle {
            visible: false
            color: Kirigami.Theme.textColor
            opacity: 0.4
            Layout.preferredWidth: 1
            Layout.preferredHeight: Math.max(12, compactRow.implicitHeight * 0.55)
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            visible: compactRoot.monitor.showGpu
            spacing: 2
            Layout.alignment: Qt.AlignVCenter

            Text {
                visible: !compactRoot.monitor.gpuUseIcon
                text: "GPU"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.labelFontSize
                font.bold: compactRoot.monitor.gpuBold
                color: compactRoot.monitor.gpuLabelColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Kirigami.Icon {
                visible: compactRoot.monitor.gpuUseIcon
                source: compactRoot.monitor.gpuIconPath
                Layout.preferredWidth: compactRoot.monitor.gpuIconSize
                Layout.preferredHeight: compactRoot.monitor.gpuIconSize
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                text: compactRoot.monitor.formatValue(compactRoot.monitor.gpuTemp, compactRoot.monitor.gpuPrecision) + "°C"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.gpuFontSize
                font.bold: compactRoot.monitor.gpuBold
                color: compactRoot.monitor.gpuFontColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                text: compactRoot.monitor.formatValue(compactRoot.monitor.gpuUsage, compactRoot.monitor.gpuPrecision) + "%"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.gpuFontSize
                font.bold: compactRoot.monitor.gpuBold
                color: compactRoot.monitor.gpuFontColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Rectangle {
            visible: false
            color: Kirigami.Theme.textColor
            opacity: 0.4
            Layout.preferredWidth: 1
            Layout.preferredHeight: Math.max(12, compactRow.implicitHeight * 0.55)
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            visible: compactRoot.monitor.showStorage
            spacing: 2
            Layout.alignment: Qt.AlignVCenter

            Text {
                visible: !compactRoot.monitor.storageUseIcon
                text: "DISK"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.labelFontSize
                font.bold: compactRoot.monitor.storageBold
                color: compactRoot.monitor.storageLabelColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Kirigami.Icon {
                visible: compactRoot.monitor.storageUseIcon
                source: compactRoot.monitor.storageIconPath
                Layout.preferredWidth: compactRoot.monitor.storageIconSize
                Layout.preferredHeight: compactRoot.monitor.storageIconSize
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                text: compactRoot.monitor.formatValue(compactRoot.monitor.storageUsage, compactRoot.monitor.storagePrecision) + "%"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.storageFontSize
                font.bold: compactRoot.monitor.storageBold
                color: compactRoot.monitor.storageFontColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Rectangle {
            visible: false
            color: Kirigami.Theme.textColor
            opacity: 0.4
            Layout.preferredWidth: 1
            Layout.preferredHeight: Math.max(12, compactRow.implicitHeight * 0.55)
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            visible: compactRoot.monitor.showNetwork
            spacing: 2
            Layout.alignment: Qt.AlignVCenter

            Text {
                visible: !compactRoot.monitor.networkUseIcon
                text: "NET"
                font.family: compactRoot.monitor.fontFamily
                font.pixelSize: compactRoot.monitor.labelFontSize
                font.bold: compactRoot.monitor.networkBold
                color: compactRoot.monitor.networkLabelColor
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
            }
            Kirigami.Icon {
                visible: compactRoot.monitor.networkUseIcon
                source: compactRoot.monitor.networkIconPath
                Layout.preferredWidth: compactRoot.monitor.networkIconSize
                Layout.preferredHeight: compactRoot.monitor.networkIconSize
                Layout.alignment: Qt.AlignVCenter
            }
            RowLayout {
                spacing: 2
                Layout.alignment: Qt.AlignVCenter

                Text {
                    text: "D"
                    font.family: compactRoot.monitor.fontFamily
                    font.pixelSize: compactRoot.monitor.networkFontSize
                    font.bold: compactRoot.monitor.networkBold
                    color: compactRoot.monitor.networkFontColor
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignVCenter
                }

                Text {
                    text: compactRoot.monitor.networkDownloadText
                    font.family: compactRoot.monitor.fontFamily
                    font.pixelSize: compactRoot.monitor.networkFontSize
                    font.bold: compactRoot.monitor.networkBold
                    color: compactRoot.monitor.networkFontColor
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideLeft
                    Layout.minimumWidth: compactRoot.monitor.networkFixedWidth
                        ? compactRoot.lockedDownloadWidth : -1
                    Layout.preferredWidth: compactRoot.monitor.networkFixedWidth
                        ? compactRoot.lockedDownloadWidth : implicitWidth
                    Layout.maximumWidth: compactRoot.monitor.networkFixedWidth
                        ? compactRoot.lockedDownloadWidth : Infinity
                    Layout.alignment: Qt.AlignVCenter
                }
            }

            RowLayout {
                spacing: 2
                Layout.alignment: Qt.AlignVCenter

                Text {
                    text: "U"
                    font.family: compactRoot.monitor.fontFamily
                    font.pixelSize: compactRoot.monitor.networkFontSize
                    font.bold: compactRoot.monitor.networkBold
                    color: compactRoot.monitor.networkFontColor
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignVCenter
                }

                Text {
                    text: compactRoot.monitor.networkUploadText
                    font.family: compactRoot.monitor.fontFamily
                    font.pixelSize: compactRoot.monitor.networkFontSize
                    font.bold: compactRoot.monitor.networkBold
                    color: compactRoot.monitor.networkFontColor
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideLeft
                    Layout.minimumWidth: compactRoot.monitor.networkFixedWidth
                        ? compactRoot.lockedUploadWidth : -1
                    Layout.preferredWidth: compactRoot.monitor.networkFixedWidth
                        ? compactRoot.lockedUploadWidth : implicitWidth
                    Layout.maximumWidth: compactRoot.monitor.networkFixedWidth
                        ? compactRoot.lockedUploadWidth : Infinity
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }
}
