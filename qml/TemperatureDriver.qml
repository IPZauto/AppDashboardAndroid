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
    property int rectWidth: root.width * 0.1
    property int rectHeight: root.height * 0.25
    property int fanPositionIconSize: root.width * 0.1

    property double temperature: 20.0
    property int air: 1
    property int airPosition: 1
    property bool syncOn: false

    property bool btn1On: false
    property bool btn2On: false
    property bool btn3On: false
    property bool btn4On: false

    signal passengerSwitched(bool passenger) // true - driver, false - right passenger
    signal passengerTempSwitched(bool passenger, double temp)
    signal passengerAirSwitched(bool passenger, int air)
    signal passengerAirPositionSwitched(bool passenger, int pos)
    signal passengerBtnSwitched(bool passenger, int btn)

    signal syncSwitched()


    function handleTemperatureChange(side: bool, increase: bool, syncFun = false) { //side: true - right, false - left; increase: true - add .5, false subtract .5
        let change = 0.5
        if(!increase) {
            change = -change
        }

        root.temperature += change
        root.passengerTempSwitched(true, root.temperature)
    }

    function handleAirChange(side: bool, increase: bool, syncFun = false) { //side: true - right, false - left; increase: true - add .5, false subtract 1
        let change = 1
        if(!increase) {
            change = -change
        }
        if(!side){
            // left side
            root.air += change
            root.passengerAirSwitched(true, root.air)
        }
    }

    function handleAirPositionChange(mode: int){
        root.airPosition = mode
        root.passengerAirPositionSwitched(true, mode)
    }

    function handleBtnChange(btn: int){
        switch(btn){
        case 1:
            root.btn1On = !root.btn1On
            root.passengerBtnSwitched(true, 1)
            break
        case 2:
            root.btn2On = !root.btn2On
            root.passengerBtnSwitched(true, 2)
            break
        case 3:
            root.btn3On = !root.btn3On
            root.passengerBtnSwitched(true, 3)
            break
        case 4:
            root.btn4On = !root.btn4On
            root.passengerBtnSwitched(true, 4)
            break
        }
    }


    Rectangle {
        id: leftPassenger
        height: root.height - tempMenuBar.height
        width: root.width
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
            anchors.left: airColumn.right
            anchors.leftMargin: root.width * 0.04

            Rectangle {
                width: root.rectWidth * 0.25
                height: root.rectHeight * 2 + leftTempColumn.spacing

                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.1; color:  "#9c0606"}
                    GradientStop { position: 0.5; color: root.backgroundColor }
                    GradientStop { position: 0.9; color: "#5a9cd6" }
                }
            }


            Column {
                id: leftTempColumn
                spacing: root.height * 0.014

                Rectangle {
                    id: rect2TempLeft
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: root.temperature < 30.0 ? "#30ffffff" : "#10ffffff"
                    border.color: "#ffffff"
                    border.width: width * 0.03125
                    enabled: root.temperature < 30.0

                    Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/plus_icon.png")
                        width: parent.width * 0.7
                        height: width
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.handleTemperatureChange(false, true)
                    }
                }

                Rectangle {
                    id: rect1TempLeft
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: root.temperature > 17.0 ? "#30ffffff" : "#10ffffff"
                    border.color: "#ffffff"
                    border.width: width * 0.03125
                    enabled: root.temperature > 17.0

                    Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/minus_icon.png")
                        width: parent.width * 0.7
                        height: width
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.handleTemperatureChange(false, false)
                    }
                }
            }
        }


        Row {
            id: rowAirLeft
            height: root.rectHeight * 0.5
            width: fanLeft.width + airText.width
            anchors.bottom: leftTempText.top
            anchors.bottomMargin: root.height * 0.037
            anchors.left: leftTempText.left

            Image {
                id: fanLeft
                width: root.rectWidth * 0.9
                source: Qt.resolvedUrl("qrc:/resources/images/fan_icon.png")
                height: width
                anchors.verticalCenter: parent.verticalCenter
            }

            CustomText {
                id: airText
                text: root.air.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: root.height * 0.074
            }
        }

        Column {
            id: airColumn
            anchors.verticalCenter: parent.verticalCenter
            spacing: root.height * 0.014
            anchors.left: parent.left
            anchors.leftMargin: root.width * 0.04

            Rectangle {
                id: rect2AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: root.air < 5 ? "#30ffffff" : "#10ffffff"
                border.color: "#ffffff"
                border.width: width * 0.03125
                enabled: root.air < 5

                Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
                    width: parent.width * 0.7
                    height: width
                    rotation: -90
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirChange(false, true)
                }
            }

            Rectangle {
                id: rect1AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: root.air > 0 ? "#30ffffff" : "#10ffffff"
                border.color: "#ffffff"
                border.width: width * 0.03125
                enabled: root.air > 0

                Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
                    width: parent.width * 0.7
                    height: width
                    rotation: -90
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirChange(false, false)
                }
            }
        }


        CustomText {
            id: leftTempText
            text: root.temperature.toFixed(1)
            font.pointSize: root.height * 0.15
            anchors.right: switchToRightPassenger.left
            anchors.rightMargin: (root.width - 2 * root.rectWidth - 3 * root.width * 0.04 - root.rectWidth * 0.25 - width - switchToRightPassenger.width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }


        Row {
            anchors.right: switchToRightPassenger.left
            anchors.rightMargin: (root.width - 2 * root.rectWidth - 3 * root.width * 0.04 - root.rectWidth * 0.25 - width - switchToRightPassenger.width) * 0.5
            spacing: root.width * 0.026
            anchors.top: leftTempText.bottom
            anchors.topMargin: (root.height - leftTempText.y - leftTempText.height - tempMenuBar.height - height) * 0.7

            Image {
                id: fan1Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.airPosition === 1 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(1)
                }
            }
            Image {
                id: fan2Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.airPosition === 2 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(2)
                }
            }
            Image {
                id: fan3Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.airPosition === 3 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(3)
                }
            }
        }

        Image {
            id: switchToRightPassenger
            anchors.right: parent.right
            anchors.rightMargin: root.width * 0.04
            anchors.verticalCenter: parent.verticalCenter
            source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
            width: 80
            height: width * 2

            MouseArea {
                anchors.fill: parent
                onClicked: root.passengerSwitched(false)
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
            height: root.height * 0.0037
            color: "#ffffff"
            anchors.top: tempMenuBar.top
            anchors.margins: 0
            anchors.topMargin: 0
        }

        Row {
            id: row
            width: tempMenuBar.width
            height: buttonHeight + lightHeight + lightTopMargin
            anchors.top: topLine.bottom

            property int btnWidth: (row.width - root.separatorWidth * 3) * 0.25
            property int lightHeight: root.height * 0.0093
            property double lightWidth: btnWidth - root.width * 0.015
            property int lightTopMargin: root.width * 0.005
            property string lightColorOn: "#e6a340" //on?
            //property string lightColor: "#b2c4d9"
            property string lightColorOff: "#5c646b" //off
            property int buttonHeight: root.height * 0.12
            property int imageSize: root.height * 0.09

            Item{
                id: btn1Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin
                anchors.top: parent.top
                anchors.topMargin: 0

                property bool isOn: false

                Rectangle {
                    id: light1
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn1On ? row.lightColorOn : row.lightColorOff
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
                        width: row.imageSize
                        height: row.imageSize
                        anchors.verticalCenter: parent.verticalCenter
                        mirror: true
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        //btn1Container.isOn = !btn1Container.isOn
                        root.handleBtnChange(1)
                    }
                }
            }

            Separator {
                id: separator1
                height: row.height
                width: root.separatorWidth
            }

            Item {
                id: btn2Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light2
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn2On ? row.lightColorOn : row.lightColorOff
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
                        width: row.imageSize
                        height: row.imageSize
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        //btn2Container.isOn = !btn2Container.isOn
                        root.handleBtnChange(2)
                    }
                }
            }

            Separator {
                id: separator2
                height: row.height
                width: root.separatorWidth
            }

            Item {
                id: btn3Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light3
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn3On ? row.lightColorOn : row.lightColorOff
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn3
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light3.bottom

                    background: Rectangle {
                        color: root.backgroundColor
                        anchors.fill: parent

                        CustomText {
                            text: "AUTO"
                            font.pointSize: root.height * 0.045
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -10
                            font.bold: true
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        //btn3Container.isOn = !btn3Container.isOn
                        root.handleBtnChange(3)
                    }
                }
            }

            Separator {
                id: separator3
                height: row.height
                width: root.separatorWidth
            }

            Item {
                id: btn4Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light4
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn4On ? row.lightColorOn : row.lightColorOff
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn4
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light4.bottom

                    background: Rectangle {
                        color: root.backgroundColor
                        anchors.fill: parent

                        CustomText {
                            text: "A/C"
                            font.pointSize: root.height * 0.045
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -10
                            font.bold: true
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        //btn4Container.isOn = !btn4Container.isOn
                        root.handleBtnChange(4)
                    }
                }
            }
        }
    }
}
