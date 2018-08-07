/****************************************************************************
**
** Copyright (C) 2018 Mihaly Borzsei
**
** ColorBoxes - Application Screen1 View
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
Page {
    id:screen1
    property int boxHeight: (mainwindow.height-screen1.header.height-screen1.footer.height)/4
    property int boxWidth: (mainwindow.width)/4
    property int boxSize: boxHeight<boxWidth?boxHeight:boxWidth

    header:
        Rectangle{

        height:buttonRow.height+separator.height
        Row {
            id:buttonRow
            Rectangle{
                height:addButton.height*2
                width:mainwindow.width/2
                Button {id:addButton
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Add")
                    onPressed:
                    {
                        boxModel.append({
                                            "color":colorboxSettings.selectedColor
                                        }
                                        );
                        colorboxSettings.saveGrid();
                    }
                }
            }

            Rectangle{
                height:addButton.height*2
                width:mainwindow.width/2
                Button {
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Remove")
                    onPressed:
                    {
                        if (colorboxSettings.selectedIndex!==-1)
                        {
                            boxModel.remove(colorboxSettings.selectedIndex);
                            colorboxSettings.selectedIndex=-1;
                            colorboxSettings.saveGrid();
                        }else if (boxModel.count>0)
                        {
                            boxModel.remove(boxModel.count-1);
                            colorboxSettings.saveGrid();
                        }



                    }
                }
            }
        }
        Separator{
            id:separator
            anchors.bottom: parent.bottom}

    }
    Rectangle
    {
        anchors.left: parent.left
        anchors.leftMargin: screen1.boxSize/3
        anchors.top: parent.top
        anchors.topMargin: screen1.boxSize/3

        ScrollView{
            height:screen1.boxHeight*4
            contentHeight: boxGrid.height+screen1.boxSize
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn //ScrollBar.AsNeeded - suggestion as visual improvement
            clip:true

            Grid{
                spacing: screen1.boxSize/3
                columns: mainwindow.width/(boxSize+screen1.boxSize/3)
                id:boxGrid

                Repeater {
                    model: boxModel
                    RoundButton {

                        id: button
                        height:boxSize
                        width: boxSize
                        background: Rectangle{ color:model.color;
                            radius: colorboxSettings.radius
                            border.width: 3
                            border.color:
                                model.index===colorboxSettings.selectedIndex?"yellow":"black"

                        }
                        onPressed: {
                            //  console.log(model.index) // select action
                            colorboxSettings.selectedIndex=model.index;
                        }

                    }

                }
            }
        }
    }

    footer:
        Rectangle{
        height:footerLabelScreen1.height*2
        Separator{}
        Label {
            id:footerLabelScreen1
            text: colorboxSettings.amountOfBoxes
            anchors.horizontalCenter:  parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

    }

}
