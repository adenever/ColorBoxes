/****************************************************************************
**
** Copyright (C) 2018 Mihaly Borzsei
**
** ColorBoxes - Application Main View
*/

import QtQuick.LocalStorage 2.0

import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

import "Database.js" as Settings
ApplicationWindow {
    id:mainwindow
    visible: true
    width: Screen.width / 2
    height: Screen.height / 1.8
    title: qsTr("Color Boxes")
    Item{
        id: colorboxSettings
        property int selectedIndex: -1  // Selection on Screen 1
        property string selectedColor: "mediumaquamarine" // Selected Color on Screen 2
        property string customColor: "mediumaquamarine" // Custom Color on Screen 2
        //internal
        onCustomColorChanged: Settings.dbUpdateCustomColor(customColor);
        onSelectedColorChanged: Settings.dbUpdateSelectedColor(selectedColor);
        onSelectedIndexChanged: Settings.dbUpdateSelectedIndex(selectedIndex);
        property alias model: boxModel
        property string amountOfBoxes: qsTr("There are %1 boxes","",boxModel.count).arg(boxModel.count)
        property int radius: 10
        function saveGrid()
        {
          Settings.dbUpdateColorBoxes(boxModel);
        }
        ListModel {
            id: boxModel

            Component.onCompleted: {
                Settings.init(boxModel)
                Settings.dbloadSettings();

            }
            ListElement {
                color: "red"
            }

    }

    }

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Screen 1")
        }
        TabButton {
            text: qsTr("Screen 2")
        }
        TabButton {
            text: qsTr("Screen 3")
        }

    }
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Screen1{
        }
        Screen2{
            id:screen2
            selectedColor:colorboxSettings.selectedColor
            customColor  :colorboxSettings.customColor
        }
        Screen3{boxCount: colorboxSettings.amountOfBoxes

        }

    }

}
