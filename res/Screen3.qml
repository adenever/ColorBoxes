/****************************************************************************
**
** Copyright (C) 2018 Mihaly Borzsei
**
** ColorBoxes - Application Screen3 View
*/

import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    property alias boxCount:boxCountLabel.text
    header:
        Rectangle
    {
        width:mainwindow.width
        Label {
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("User Preferences")
            font.pixelSize: Qt.application.font.pixelSize * 2
            padding: Qt.application.font.pixelSize * 2
        }

    }
    Column{
        spacing:10
        anchors.left: parent.left
        anchors.leftMargin: mainwindow.width/10
        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin: header.height
        Label {
            id:boxCountLabel
            padding: 10
        }
        Row{
            Label {
                id:footerLabel2Screen3
                text: qsTr("Current Color is: ")
                padding: 10
            }
            Label {
                id:footerLabel3Screen3
                text: qsTr("%1").arg(colorboxSettings.selectedColor)
                font.capitalization:Font.AllUppercase
                padding: 10
            }
        }
    }

}
