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

    signal passengerSwitched(bool passenger) // true - driver, false - right passenger
    signal passengerTempSwitched(bool passenger, double temp)
    signal passengerAirSwitched(bool passenger, int air)
    signal passengerAirPositionSwitched(bool passenger, int pos)

    function handleTemperatureChange(side: bool, increase: bool, syncFun = false) { //side: true - right, false - left; increase: true - add .5, false subtract .5
        let change = 0.5
        if(!increase) {
            change = -change
        }

        if(side || root.syncOn){
            // right side
            if(side && !syncFun){
                root.syncOn = false
                btn7Container.isOn = false
            }
            root.temperature += change
            //rightTempText.text = root.temperature.toFixed(1)
            root.passengerTempSwitched(false, root.temperature)
        }
    }

    function handleAirChange(side: bool, increase: bool, syncFun = false) { //side: true - right, false - left; increase: true - add .5, false subtract 1
        let change = 1
        if(!increase) {
            change = -change
        }

        if(side || root.syncOn){
            // right side
            if(side && !syncFun){
                root.syncOn = false
                btn7Container.isOn = false
            }

            root.air += change
            //airText.text = root.air.toString()
            root.passengerAirSwitched(false, root.air)
        }
    }

    /*function handleSyncChange(){
        root.syncOn = !syncOn
        if(syncOn){
            var change = (root.leftTemperature - root.temperature) * 2
            var n = Math.abs(change)
            for(var i=0; i<n; i++){
                root.handleTemperatureChange(true, change>0, true)
            }

            change = root.leftAir - root.air
            n = Math.abs(change)
            for(var i=0; i<n; i++){
                root.handleAirChange(true, change>0, true)
            }
        }
    }*/

    function handleAirPositionChange(mode: int){
        root.airPosition = mode
        root.passengerAirPositionSwitched(false, mode)
    }

    Rectangle {
        id: rightPassenger
        height: root.height - tempMenuBar.height
        anchors.right: parent.right
        width: root.width
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
            width: fanRight.width + airText.width
            anchors.bottom: rightTempText.top
            anchors.bottomMargin: root.height * 0.037
            anchors.right: rightTempText.right

            CustomText {
                id: airText
                text: root.air.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: root.height * 0.074
            }

            Image {
                id: fanRight
                width: root.rectWidth * 0.9
                source: Qt.resolvedUrl("qrc:/resources/images/fan_icon.png")
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
            }
        }

        CustomText {
            id: rightTempText
            text: root.temperature.toFixed(1)
            font.pointSize: root.height * 0.2
            anchors.left: switchToDriver.right
            anchors.leftMargin: (root.width - 2 * root.rectWidth - 3 * root.width * 0.04 - root.rectWidth * 0.25 - width - switchToDriver.width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }



        Column {
            id: airColumn
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: root.width * 0.04
            anchors.verticalCenterOffset: 0
            spacing: root.height * 0.014

            Rectangle {
                id: rect2AirRight
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
                    onClicked: root.handleAirChange(true, true)
                }
            }

            Rectangle {
                id: rect1AirRight
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
                    onClicked: root.handleAirChange(true, false)
                }
            }
        }

        Row {
            id: rightTempRow
            anchors.right: airColumn.left
            anchors.rightMargin: root.width * 0.04
            anchors.verticalCenter: parent.verticalCenter


            Column {
                id: rightTempColumn
                spacing: root.height * 0.014

                Rectangle {
                    id: rect2TempRight
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
                        onClicked: root.handleTemperatureChange(true, true)
                    }
                }

                Rectangle {
                    id: rect1TempRight
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
                        onClicked: root.handleTemperatureChange(true, false)
                    }
                }
            }

            Rectangle {
                width: root.rectWidth * 0.25
                height: root.rectHeight * 2 + rightTempColumn.spacing

                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.1; color:  "#9c0606"}
                    GradientStop { position: 0.5; color: root.backgroundColor }
                    GradientStop { position: 0.9; color: "#5a9cd6" }
                }
            }
        }

        Row {
            anchors.left: switchToDriver.right
            spacing: root.width * 0.026
            anchors.top: rightTempText.bottom
            anchors.topMargin: (root.height - rightTempText.y - rightTempText.height - tempMenuBar.height - height) * 0.7
            anchors.leftMargin: (root.width - 2 * root.rectWidth - 3 * root.width * 0.04 - root.rectWidth * 0.25 - width - switchToDriver.width) * 0.5

            Image {
                id: fan1Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.airPosition === 1 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(1)
                }
            }
            Image {
                id: fan2Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.airPosition === 2 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(2)
                }
            }
            Image {
                id: fan3Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.airPosition === 3 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(3)
                }
            }
        }

        Image {
            id: switchToDriver
            anchors.left: parent.left
            anchors.leftMargin: root.width * 0.04
            anchors.verticalCenter: parent.verticalCenter
            source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
            width: 80
            height: width * 2

            MouseArea {
                anchors.fill: parent
                onClicked: root.passengerSwitched(true)
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

            Item {
                id: btn5Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light5
                    width: row.lightWidth
                    height: row.lightHeight
                    color: btn5Container.isOn ? row.lightColorOn : row.lightColorOff
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn5
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light5.bottom

                    background: Image {
                        id:frontHeatIcon
                        source: Qt.resolvedUrl("qrc:/resources/images/windshield_defrost_front_icon.png")
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: row.imageSize
                        height: row.imageSize * 0.9
                        anchors.top: parent.top

                        CustomText {
                            id: textFront
                            text: "FRONT"
                            anchors.top: frontHeatIcon.bottom
                            anchors.topMargin: -50
                            font.bold: true
                            font.pointSize: root.height * 0.03
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: btn5Container.isOn = !btn5Container.isOn
                }
            }

            Separator {
                id: separator5
                height: row.height
                width: root.separatorWidth
            }

            Item {
                id: btn6Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light6
                    width: row.lightWidth
                    height: row.lightHeight
                    color: btn6Container.isOn ? row.lightColorOn : row.lightColorOff
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn6
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light6.bottom

                    background: Image {
                        id: rearHeatIcon
                        source: Qt.resolvedUrl("qrc:/resources/images/windshield_defrost_rear_icon.png")
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: row.imageSize
                        height: row.imageSize * 0.9
                        anchors.top: parent.top

                        CustomText {
                            id: textRear
                            text: "REAR"
                            anchors.top: rearHeatIcon.bottom
                            anchors.topMargin: -50
                            font.bold: true
                            font.pointSize: root.height * 0.03
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: btn6Container.isOn = !btn6Container.isOn
                }
            }

            Separator {
                id: separator6
                height: row.height
                width: root.separatorWidth
            }

            Item {
                id: btn7Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light7
                    width: row.lightWidth
                    height: row.lightHeight
                    color: btn7Container.isOn ? row.lightColorOn : row.lightColorOff
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn7
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light7.bottom

                    background: Rectangle {
                        color: root.backgroundColor
                        anchors.fill: parent

                        CustomText {
                            text: "SYNC"
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
                        btn7Container.isOn = !btn7Container.isOn
                        //root.handleSyncChange()
                    }
                }
            }

            Separator {
                id: separator7
                height: row.height
                width: root.separatorWidth
            }

            Item {
                id: btn8Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light8
                    width: row.lightWidth
                    height: row.lightHeight
                    color: btn8Container.isOn ? row.lightColorOn : row.lightColorOff
                    anchors.top: parent.top
                    anchors.topMargin: row.lightTopMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MenuButton {
                    id: btn8
                    width: row.btnWidth
                    height: row.buttonHeight
                    anchors.top: light8.bottom

                    background: Image {
                        source: Qt.resolvedUrl("qrc:/resources/images/seat_heat_left_icon.png")
                        width: row.imageSize
                        height: row.imageSize
                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: btn8Container.isOn = !btn8Container.isOn
                }
            }
        }
    }
}
