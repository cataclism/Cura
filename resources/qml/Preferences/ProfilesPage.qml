// Copyright (c) 2018 Ultimaker B.V.
// Uranium is released under the terms of the LGPLv3 or higher.

import QtQuick 2.8
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

import UM 1.2 as UM
import Cura 1.0 as Cura


Item
{
    id: base
    property var resetEnabled: false  // Keep PreferencesDialog happy

    UM.I18nCatalog { id: catalog; name: "cura"; }

    Cura.QualityManagementModel {
        id: qualitiesModel
    }

    Label {
        id: titleLabel

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 5 * screenScaleFactor
        }

        font.pointSize: 18
        text: catalog.i18nc("@title:tab", "Profiles")
    }

    Row  // Button Row
    {
        id: buttonRow
        anchors {
            left: parent.left
            right: parent.right
            top: titleLabel.bottom
        }
        height: childrenRect.height

        // Activate button
        Button
        {
            text: catalog.i18nc("@action:button", "Activate")
            iconName: "list-activate"
            //enabled: base.currentItem != null ? base.currentItem.id != Cura.MachineManager.activeQualityId : false;
            enabled: true // TODO
            onClicked: {
                // TODO
            }
        }

        // Create button
        Button
        {
            text: catalog.i18nc("@label", "Create")
            iconName: "list-add"
            //enabled: base.canCreateProfile() && !Cura.MachineManager.stacksHaveErrors
            enabled: true // TODO
            //visible: base.canCreateProfile()
            visible: true // TODO

            onClicked: {
                // TODO
            }
        }

        // Duplicate button
        Button
        {
            text: catalog.i18nc("@label", "Duplicate")
            iconName: "list-add"
            //enabled: ! base.canCreateProfile()
            enabled: true // TODO
            //visible: ! base.canCreateProfile()
            visible: true // TODO

            onClicked: {
                // TODO
            }
        }

        // Remove button
        Button
        {
            text: catalog.i18nc("@action:button", "Remove")
            iconName: "list-remove"
            //enabled: base.currentItem != null ? !base.currentItem.readOnly && !Cura.ContainerManager.isContainerUsed(base.currentItem.id) : false;
            enabled: true // TODO
            onClicked: {
                // TODO
            }
        }

        // Rename button
        Button
        {
            text: catalog.i18nc("@action:button", "Rename")
            iconName: "edit-rename"
            //enabled: base.currentItem != null ? !base.currentItem.readOnly : false;
            enabled: true // TODO
            onClicked: {
                // TODO
            }
        }

        // Import button
        Button
        {
            text: catalog.i18nc("@action:button", "Import")
            iconName: "document-import"
            onClicked: {
                // TODO
            }
        }

        // Export button
        Button
        {
            text: catalog.i18nc("@action:button", "Export")
            iconName: "document-export"
            //enabled: currentItem != null && !base.currentItem.readOnly
            enabled: true // TODO
            onClicked: {
                // TODO
            }
        }
    }



    Item {
        id: contentsItem

        anchors {
            top: titleLabel.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 5 * screenScaleFactor
            bottomMargin: 0
        }

        clip: true
    }

    Item
    {
        anchors {
            top: buttonRow.bottom
            topMargin: UM.Theme.getSize("default_margin").height
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        SystemPalette { id: palette }

        Label
        {
            id: captionLabel
            anchors {
                top: parent.top
                left: parent.left
            }
            visible: text != ""
            text: {
                // OLD STUFF
                return catalog.i18nc("@label %1 is printer name", "Printer: %1").arg(Cura.MachineManager.activeMachineName);
            }
            width: profileScrollView.width
            elide: Text.ElideRight
        }

        ScrollView
        {
            id: profileScrollView
            anchors {
                top: captionLabel.visible ? captionLabel.bottom : parent.top
                topMargin: captionLabel.visible ? UM.Theme.getSize("default_margin").height : 0
                bottom: parent.bottom
                left: parent.left
            }

            Rectangle {
                parent: viewport
                anchors.fill: parent
                color: palette.light
            }

            width: true ? (parent.width * 0.4) | 0 : parent.width

            ListView
            {
                id: qualityListView

                model: qualitiesModel

                section.property: "is_read_only"
                section.delegate: Rectangle
                {
                    height: childrenRect.height

                    Label
                    {
                        anchors.left: parent.left
                        anchors.leftMargin: UM.Theme.getSize("default_lining").width
                        text: section == "true" ? catalog.i18nc("@label", "Protected profiles") : catalog.i18nc("@label", "Custom profiles")
                        font.bold: true
                    }
                }

                delegate: Rectangle
                {
                    width: profileScrollView.width
                    height: childrenRect.height
                    color: ListView.isCurrentItem ? palette.highlight : (model.index % 2) ? palette.base : palette.alternateBase

                    Row
                    {
                        spacing: (UM.Theme.getSize("default_margin").width / 2) | 0
                        anchors.left: parent.left
                        anchors.leftMargin: UM.Theme.getSize("default_margin").width
                        anchors.right: parent.right
                        Label
                        {
                            width: Math.floor((parent.width * 0.3))
                            text: model.name
                            elide: Text.ElideRight
                            font.italic: {  // TODO: make it easier
                                return model.name == Cura.MachineManager.activeQualityOrQualityChangesName;
                            }
                            color: parent.ListView.isCurrentItem ? palette.highlightedText : palette.text;
                        }
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            parent.ListView.view.currentIndex = model.index;
                        }
                    }
                }

                onCurrentIndexChanged:
                {
                    var model = qualitiesModel.getItem(currentIndex);
                    // TODO
                }
            }
        }


        Item
        {
            id: detailsPanel

            anchors {
                left: profileScrollView.right
                leftMargin: UM.Theme.getSize("default_margin").width
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }

            Item
            {
                anchors.fill: parent

                Item    // Profile title Label
                {
                    id: profileName

                    width: parent.width
                    height: childrenRect.height

                    Label {
                        text: "TODO" // TODO
                        font: UM.Theme.getFont("large")
                    }
                }

            }
        }
    }
}
