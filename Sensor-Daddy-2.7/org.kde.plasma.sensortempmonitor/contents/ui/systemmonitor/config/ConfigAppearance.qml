/*
    SPDX-FileCopyrightText: 2019 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2019 David Edmundson <davidedmundson@kde.org>
    SPDX-FileCopyrightText: 2019 Arjen Hiemstra <ahiemstra@heimr.nl>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.plasma.plasmoid
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: root

    signal configurationChanged

    function saveConfig() {
        appearanceUi.saveConfig()
        if (sensorUi && !root.originalStyleSelected) {
            sensorUi.saveConfig()
        }
        Plasmoid.faceController.reloadConfig()
    }

    // Workaround for Bug 424458, when reusing the controller/item things break
    readonly property var configController: Plasmoid.workaroundController(root)
    readonly property Item appearanceUi: configController.appearanceConfigUi
    readonly property Item sensorUi: configController.sensorsConfigUi
    readonly property bool originalStyleSelected:
        configController.faceId === "org.kde.ksysguard.sensordaddyoriginal"

    // We cannot directly override the contentItem since SimpleKCM is a
    // Kirigami.ScrollablePage which breaks if we override the contentItem. So
    // instead use a placeholder item and reparent the config UI into that item,
    // making sure to bind the required properties so sizing is correct.
    ColumnLayout {
        id: contents

        spacing: Kirigami.Units.largeSpacing
        implicitWidth: Math.max(
            appearanceContents.implicitWidth,
            sensorContents.visible ? sensorContents.implicitWidth : 0)
        implicitHeight: appearanceContents.implicitHeight
            + (sensorContents.visible
                ? spacing + sensorHeading.implicitHeight
                    + Kirigami.Units.smallSpacing
                    + sensorHelp.implicitHeight
                    + Kirigami.Units.smallSpacing
                    + sensorContents.implicitHeight
                : 0)

        Item {
            id: appearanceContents

            Layout.fillWidth: true
            implicitWidth: root.appearanceUi?.implicitWidth ?? 0
            implicitHeight: root.appearanceUi?.implicitHeight ?? 0
            children: root.appearanceUi

            Binding {
                target: root.appearanceUi
                property: "width"
                value: appearanceContents.width
                when: root.appearanceUi !== null
            }
        }

        Kirigami.Heading {
            id: sensorHeading
            visible: sensorContents.visible
            text: i18n("Sensor placement")
            level: 3
            Layout.fillWidth: true
        }

        Label {
            id: sensorHelp
            visible: sensorContents.visible
            text: i18n("Choose primary sensors for the full display and text-only sensors for the secondary list.")
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        Item {
            id: sensorContents

            visible: !root.originalStyleSelected && root.sensorUi !== null
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: root.sensorUi?.implicitWidth ?? 0
            implicitHeight: root.sensorUi?.implicitHeight ?? 0
            children: root.sensorUi

            Binding {
                target: root.sensorUi
                property: "width"
                value: sensorContents.width
                when: root.sensorUi !== null
            }
        }
    }

    Connections {
        target: root.appearanceUi
        function onConfigurationChanged() {
            root.configurationChanged()
        }
    }

    Connections {
        target: root.sensorUi
        function onConfigurationChanged() {
            root.configurationChanged()
        }
    }
}
