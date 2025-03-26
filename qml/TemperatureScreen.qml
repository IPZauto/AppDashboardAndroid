import QtQuick

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: backgroundColor

    property int separatorWidth: 7
    //property string backgroundColor: "#011226"
    property string backgroundColor: "#000000"
    property string gradientColor: "#393f45"
    property int rectWidth: root.width * 0.06
    property int rectHeight: root.height * 0.20

    //TO DO: tempMenuBar position

    Rectangle {
        id: leftPassenger
        height: root.height - tempMenuBar.height
        width: root.width*0.5
        anchors.top: root.top
        anchors.left: root.left

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.6; color: root.backgroundColor }
            GradientStop { position: 1.1; color: root.gradientColor }
        }

        Row {
            id: leftTempRow
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: leftAirColumn.right
            anchors.leftMargin: 100

            Rectangle {
                width: root.rectWidth * 0.25
                height: root.rectHeight*2 + 15

                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.1; color:  "#9c0606"}
                    GradientStop { position: 0.5; color: root.backgroundColor }
                    GradientStop { position: 0.9; color: "#5a9cd6" }
                }
            }


            Column {
                id: leftTempColumn
                spacing: 15

                Rectangle {
                    id: rect2TempLeft
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: 3

                    Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/plus_icon.png")
                        width: parent.width * 0.7
                        height: width
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: rect1TempLeft
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: 3

                    Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/minus_icon.png")
                        width: parent.width * 0.7
                        height: width
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }
        }


        Row {
            id: rowAirLeft
            height: root.rectHeight * 0.5
            width: fanLeft.width + leftAirText.width
            anchors.bottom: leftTempText.top
            anchors.bottomMargin: 40
            //anchors.horizontalCenter: leftTempText.horizontalCenter
            anchors.left: leftTempText.left

            Image {
                id: fanLeft
                width: root.rectWidth * 0.9
                source: Qt.resolvedUrl("qrc:/resources/images/fan_icon.png")
                height: width
                anchors.verticalCenter: parent.verticalCenter
            }

            CustomText {
                id: leftAirText
                text: "1"
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 80
                anchors.left: fanLeft.right
            }
        }

        Column {
            id: leftAirColumn
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15
            anchors.left: parent.left
            anchors.leftMargin: 80

            Rectangle {
                id: rect2AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: 3

                Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
                    width: parent.width * 0.7
                    height: width
                    rotation: -90
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                }
            }

            Rectangle {
                id: rect1AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: 3

                Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
                    width: parent.width * 0.7
                    height: width
                    rotation: -90
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                }
            }
        }


        CustomText {
            id: leftTempText
            text: "20.0"
            font.pointSize: 120
            anchors.right: parent.right
            anchors.rightMargin: (root.width*0.5 - 2* root.rectWidth - 2* 80 - root.rectWidth * 0.25 - width)*0.5
            anchors.verticalCenter: parent.verticalCenter
        }


        Row { //TO DO: margin - math
            anchors.right: parent.right
            anchors.rightMargin: 0
            spacing: 50
            anchors.top: leftTempText.bottom
            anchors.topMargin: 50

            Image {
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: 100
                height: width
            }
            Image {
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: 100
                height: width
                opacity: 0.5
            }
            Image {
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: 100
                height: width
                opacity: 0.5
            }
        }
    }







    Rectangle {
        id: rightPassenger
        height: root.height - tempMenuBar.height
        anchors.right: parent.right
        width: root.width*0.5
        anchors.top: root.top
        anchors.rightMargin: 0

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: -0.1; color: root.gradientColor }
            GradientStop { position: 0.4; color: root.backgroundColor }
        }

        Row {
            id: rowAirRight
            height: root.rectHeight * 0.5
            width: fanRight.width + rightAirText.width
            anchors.bottom: rightTempText.top
            anchors.bottomMargin: 40
            //anchors.horizontalCenter: leftTempText.horizontalCenter
            //anchors.left: rightTempText.left
            anchors.right: rightTempText.right

            CustomText {
                id: rightAirText
                text: "1"
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 80
            }

            Image {
                id: fanRight
                width: root.rectWidth * 0.9
                source: Qt.resolvedUrl("qrc:/resources/images/fan_icon.png")
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                //anchors.left: rightAirText.right
            }
        }

        CustomText {
            id: rightTempText
            text: "20.0"
            font.pointSize: 120
            anchors.left: parent.left
            anchors.leftMargin: (root.width*0.5 - 2* root.rectWidth - 2* 80 - root.rectWidth * 0.25 - width)*0.5
            anchors.verticalCenter: parent.verticalCenter
        }



        Column {
            id: rightAirColumn
            anchors.verticalCenter: parent.verticalCenter
            // anchors.left: parent.left
            // anchors.leftMargin: 50
            anchors.right: parent.right
            anchors.rightMargin: 80
            anchors.verticalCenterOffset: 0
            spacing: 15

            Rectangle {
                id: rect2AirRight
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: 3

                Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
                    width: parent.width * 0.7
                    height: width
                    rotation: -90
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                }
            }

            Rectangle {
                id: rect1AirRight
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: 3

                Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
                    width: parent.width * 0.7
                    height: width
                    rotation: -90
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                }
            }
        }

        Row {
            id: rightTempRow
            anchors.right: rightAirColumn.left
            anchors.rightMargin: 80
            anchors.verticalCenter: parent.verticalCenter


            Column {
                id: rightTempColumn
                // anchors.verticalCenter: parent.verticalCenter
                // anchors.right: parent.right
                // anchors.rightMargin: 50
                spacing: 15

                Rectangle {
                    id: rect2TempRight
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: 3

                    Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/plus_icon.png")
                        width: parent.width * 0.7
                        height: width
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: rect1TempRight
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: 3

                    Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/minus_icon.png")
                        width: parent.width * 0.7
                        height: width
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }

            Rectangle {
                width: root.rectWidth * 0.25
                height: root.rectHeight*2 + 15

                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.1; color:  "#9c0606"}
                    GradientStop { position: 0.5; color: root.backgroundColor }
                    GradientStop { position: 0.9; color: "#5a9cd6" }
                }
            }
        }

        Row {
            // TO DO: margin - math
            anchors.left: parent.left
            spacing: 50
            anchors.top: rightTempText.bottom
            anchors.topMargin: 50

            Image {
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: 100
                height: width
                opacity: 1.0
                mirror: true
            }
            Image {
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: 100
                height: width
                opacity: 0.5
                mirror: true
            }
            Image {
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: 100
                height: width
                opacity: 0.5
                mirror: true
            }
        }
    }





    Item {
        id: tempMenuBar
        width: root.width
        height: row.height + topLine.height
        anchors.bottom: root.bottom
        anchors.bottomMargin: 0


        Rectangle {
            id: topLine
            width: tempMenuBar.width
            height: 4
            color: "#ffffff"
            anchors.top: tempMenuBar.top
            anchors.margins: 0
            anchors.topMargin: 0
        }

        Row {
            id: row
            width: tempMenuBar.width
            height: root.height * 0.13
            anchors.top: topLine.bottom

            property int btnWidth: (row.width - root.separatorWidth*7)*0.125
            property int lightHeight: 10
            property double lightWidth: btnWidth - root.width*0.015
            property int lightTopMargin: root.width * 0.005
            property string lightColor: "#e6a340" //on?
            //property string lightColor: "#b2c4d9"
            //property string lightColor: "#5c646b" //off
            property int buttonHeight: root.height * 0.111

            Item{
                id: btn1Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                anchors.top: parent.top
                anchors.topMargin: 0

                Rectangle {
                    id: light1
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn1
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light1.bottom

                    background: Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/seat_heat_left_icon.png")
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 110
                        height: 110
                        anchors.verticalCenter: parent.verticalCenter
                        mirror: true
                    }
                }
            }

            Separator {
                id: separator1
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn1Container.right
                //anchors.leftMargin: 0
            }

            Item {
                id: btn2Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator1.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light2
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn2
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light2.bottom

                    background: Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/steering_wheel_heat_icon.png")
                        width: 100
                        height: 100
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.centerIn: parent
                    }
                }
            }

            Separator {
                id: separator2
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn2Container.right
                //anchors.leftMargin: 0
            }

            Item {

                id: btn3Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator2.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light3
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn3
                    width: row.btnWidth
                    height: row.buttonHeight
                    //anchors.left: separator2.right
                    //anchors.leftMargin: 0
                    anchors.top: light3.bottom

                    background: Rectangle {
                        color: root.backgroundColor
                        anchors.fill: parent

                        CustomText {
                            text: "AUTO"
                            font.pointSize: 48
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -10
                            font.bold: true
                        }
                    }
                }
            }

            Separator {
                id: separator3
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn3Container.right
                //anchors.leftMargin: 0
            }

            Item {
                id: btn4Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator3.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light4
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn4
                    width: row.btnWidth
                    height: row.buttonHeight
                    //anchors.left: separator3.right
                    //anchors.leftMargin: 0
                    anchors.top: light4.bottom

                    background: Rectangle {
                        color: root.backgroundColor
                        anchors.fill: parent

                        CustomText {
                            text: "A/C"
                            font.pointSize: 48
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -10
                            font.bold: true
                        }
                    }
                }
            }

            Separator {
                id: separator4
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn4Container.right
                //anchors.leftMargin: 0
            }

            Item {
                id: btn5Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator4.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light5
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn5
                    width: row.btnWidth
                    height: row.buttonHeight
                    //anchors.left: separator5.right
                    //anchors.leftMargin: 0
                    anchors.top: light5.bottom

                    background: Image {
                        id:frontHeatIcon
                        source: Qt.resolvedUrl("qrc:/resources/images/windshield_defrost_front_icon.png")
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 110
                        height: 90
                        anchors.top: parent.top

                        CustomText {
                            id: textFront
                            text: "FRONT"
                            anchors.top: frontHeatIcon.bottom
                            anchors.topMargin: -50
                            font.bold: true
                            font.pointSize: 26
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            Separator {
                id: separator5
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn5Container.right
                //anchors.leftMargin: 0
            }

            Item {
                id: btn6Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator5.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light6
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn6
                    width: row.btnWidth
                    height: row.buttonHeight
                    //anchors.left: separator5.right
                    //anchors.leftMargin: 0
                    anchors.top: light6.bottom

                    background: Image {
                        id: rearHeatIcon
                        source: Qt.resolvedUrl("qrc:/resources/images/windshield_defrost_rear_icon.png")
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 110
                        height: 90
                        anchors.top: parent.top

                        CustomText {
                            id: textRear
                            text: "REAR"
                            anchors.top: rearHeatIcon.bottom
                            anchors.topMargin: -50
                            font.bold: true
                            font.pointSize: 26
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            Separator {
                id: separator6
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn6Container.right
                //anchors.leftMargin: 0
            }

            Item {
                id: btn7Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator6.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light7
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn7
                    width: row.btnWidth
                    height: row.buttonHeight
                    //anchors.left: separator6.right
                    //anchors.leftMargin: 0
                    anchors.top: light7.bottom

                    background: Rectangle {
                        color: root.backgroundColor
                        anchors.fill: parent

                        CustomText {
                            text: "SYNC"
                            font.pointSize: 48
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -10
                            font.bold: true
                        }
                    }
                }
            }

            Separator {
                id: separator7
                height: row.height
                width: root.separatorWidth
                //anchors.left: btn7Container.right
                //anchors.leftMargin: 0
            }

            Item {
                id: btn8Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                //anchors.left: separator7.right
                //anchors.leftMargin: 0

                Rectangle {
                    id: light8
                    width: row.lightWidth
                    height: row.lightHeight
                    color: row.lightColor
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn8
                    width: row.btnWidth
                    height: row.buttonHeight
                    //anchors.left: separator7.right
                    anchors.top: light8.bottom

                    background: Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/seat_heat_left_icon.png")
                        width: 110
                        height: 110
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
}
