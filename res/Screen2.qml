/****************************************************************************
**
** Copyright (C) 2018 Mihaly Borzsei
**
** ColorBoxes - Application Screen2 View
*/


import QtQuick 2.9
import QtQuick.Controls 2.2
Page {
    id:screen2
    property int boxHeight: (mainwindow.height-screen2.header.height-screen2.footer.height)/2
    property int boxWidth: (mainwindow.width)/4
    property int boxSize: boxHeight<boxWidth?boxHeight:boxWidth
    property string selectedColor: ""
    property string customColor: ""
    ListModel {
        id: colorModel
        ListElement {
            name: qsTr("Red")
            color: "red"

        }
        ListElement {
            name: qsTr("Orange")
            color: "orange"
        }
        ListElement {
            name: qsTr("Yellow")
            color: "yellow"
        }
        ListElement {
            name: qsTr("Green")
            color: "green"
        }
        ListElement {
            name: qsTr("Blue")
            color: "blue"
        }
        ListElement {
            name: qsTr("Indigo")
            color: "indigo"
        }
        ListElement {
            name: qsTr("Violet")
            color: "violet"
        }
    }
    function setColor() // Set color on both screen
    {
        colorBox.background.color=colorboxSettings.selectedColor;
        if (colorboxSettings.selectedIndex!==-1)
        {
            colorboxSettings.model.get(colorboxSettings.selectedIndex).color=colorboxSettings.selectedColor;
        }

    }
    function setCustomColor()
    {
        if(svgColorText.text.length>0)
        {
            svgButton.background.color=svgColorText.text
            colorboxSettings.selectedColor=svgColorText.text;

        }
        else
        {
            svgButton.background.color=svgColorText.placeholderText
            colorboxSettings.selectedColor=svgColorText.placeholderText;
        }
        colorboxSettings.customColor=colorboxSettings.selectedColor;
    }
    header:
        Rectangle{
        id:headerBox
        height:buttonRow.height+separator.height
        Row {
            id:buttonRow
            width: parent.width

            Frame {
                id: frame
                height: mainwindow/10 //page.height / 10
                width: parent.width
                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater {
                        model: colorModel
                        Button {

                            id: button2
                            objectName:"ColorButton"
                            background: Rectangle{ color:model.color;
                            }
                            text: model.name
                            onPressed: {
                                colorboxSettings.selectedColor=colorModel.get(model.index).color;
                                setColor();
                            }
                        }

                    }
                    Button{
                        id:svgButton
                        background: Rectangle{ color:customColor;
                            border.width: 2
                        }

                        text:qsTr("SVG color by name :");
                        onPressed:
                        {
                            setCustomColor();
                            setColor();
                        }


                    }
                    TextField{
                        id:svgColorText
                        text:customColor
                        placeholderText: "mediumaquamarine"
                        background: Rectangle{ color:"white";border.width: 2
                        }

                        onEditingFinished:
                        {
                            setCustomColor();
                            setColor();
                        }
                    }
                }
            }
        }
        Separator{
            id:separator
            anchors.bottom: parent.bottom}

    }
    Rectangle{
        id:contents
        anchors.left: parent.left
        anchors.leftMargin: (mainwindow.width-colorBox.background.width)/2
        anchors.top: parent.top
        anchors.topMargin: boxHeight-colorBox.background.height/2
        //anchors.horizontalCenter:  parent.horizontalCenter
        Button{
            id:colorBox
            anchors.verticalCenter: contents.verticalCenter

            background: Rectangle{ color:screen2.selectedColor
                width: boxSize
                height:boxSize
                border.width: 2
                radius: colorboxSettings.radius

            }
        }
    }
    footer:
        Rectangle{
        height:footerLabel1Screen2.height*2
        Row{
            anchors.horizontalCenter:  parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Label {
                id:footerLabel1Screen2
                text: qsTr("Current Color is: ")
            }
            Label {
                id:footerLabel2Screen2
                text: qsTr("%1").arg(colorboxSettings.selectedColor)
                font.capitalization:Font.AllUppercase
            }
        }
    }

}
