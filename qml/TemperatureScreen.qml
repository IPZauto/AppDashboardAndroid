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
    property int rectWidth: root.width * 0.05
    property int rectHeight: root.height * 0.25
    property int fanPositionIconSize: root.height * 0.1

    property double rightTemperature: 20.0
    property double leftTemperature: 20.0
    property int rightAir: 1
    property int leftAir: 1
    property int rightAirPosition: 1
    property int leftAirPosition: 1
    property bool syncOn: false

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

            root.rightTemperature += change
            if(root.rightTemperature == 17.0){
                rect1TempRight.enabled = false
                rect1TempRight.color = "#10ffffff"
            } else {
                rect1TempRight.enabled = true
                rect1TempRight.color = "#30ffffff"
            }

            if(root.rightTemperature == 30.0){
                rect2TempRight.enabled = false
                rect2TempRight.color = "#10ffffff"
            } else {
                rect2TempRight.enabled = true
                rect2TempRight.color = "#30ffffff"
            }
            rightTempText.text = root.rightTemperature.toFixed(1)  
        }

        if(!side){
            // left side

            root.leftTemperature += change
            if(root.leftTemperature == 17.0){
                rect1TempLeft.enabled = false
                rect1TempLeft.color = "#10ffffff"
            } else {
                rect1TempLeft.enabled = true
                rect1TempLeft.color = "#30ffffff"
            }

            if(root.leftTemperature == 30.0){
                rect2TempLeft.enabled = false
                rect2TempLeft.color = "#10ffffff"
            } else {
                rect2TempLeft.enabled = true
                rect2TempLeft.color = "#30ffffff"
            }
            leftTempText.text = root.leftTemperature.toFixed(1)
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

            root.rightAir += change
            if(root.rightAir == 0){
                rect1AirRight.enabled = false
                rect1AirRight.color = "#10ffffff"
            } else {
                rect1AirRight.enabled = true
                rect1AirRight.color = "#30ffffff"
            }

            if(root.rightAir == 5){
                rect2AirRight.enabled = false
                rect2AirRight.color = "#10ffffff"
            }else{
                rect2AirRight.enabled = true
                rect2AirRight.color = "#30ffffff"
            }

            rightAirText.text = root.rightAir.toString()
        }
        if(!side){
            // left side
            root.leftAir += change
            if(root.leftAir == 0){
                rect1AirLeft.enabled = false
                rect1AirLeft.color = "#10ffffff"
            }else {
                rect1AirLeft.enabled = true
                rect1AirLeft.color = "#30ffffff"
            }

            if(root.leftAir == 5){
                rect2AirLeft.enabled = false
                rect2AirLeft.color = "#10ffffff"
            }else{
                rect2AirLeft.enabled = true
                rect2AirLeft.color = "#30ffffff"
            }

            leftAirText.text = root.leftAir.toString()
        }
    }

    function handleSyncChange(){
        root.syncOn = !syncOn
        if(syncOn){
            var change = (root.leftTemperature - root.rightTemperature) * 2
            var n = Math.abs(change)
            for(var i=0; i<n; i++){
                root.handleTemperatureChange(true, change>0, true)
            }

            change = root.leftAir - root.rightAir
            n = Math.abs(change)
            for(var i=0; i<n; i++){
                root.handleAirChange(true, change>0, true)
            }
        }
    }

    // function handleAirPositionChange(side: bool, mode: int){
    //     if(side){
    //         root.rightAirPosition = mode
    //     }else{
    //         root.leftAirPosition = mode
    //     }
    // }


    Rectangle {
        id: leftPassenger
        height: root.height - tempMenuBar.height
        width: root.width * 0.5
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
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: width * 0.03125

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
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: width * 0.03125

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
            width: fanLeft.width + leftAirText.width
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
                id: leftAirText
                text: "1"
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: root.height * 0.074
            }
        }

        Column {
            id: leftAirColumn
            anchors.verticalCenter: parent.verticalCenter
            spacing: root.height * 0.014
            anchors.left: parent.left
            anchors.leftMargin: root.width * 0.04

            Rectangle {
                id: rect2AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: width * 0.03125

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
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: width * 0.03125

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
            text: "20.0"
            font.pointSize: root.height * 0.12
            anchors.right: parent.right
            anchors.rightMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }


        Row { //TO DO: margin - math  WTF why rightTempText.x ok and left not?
            anchors.right: parent.right
            anchors.rightMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5
            spacing: root.width * 0.026
            anchors.top: leftTempText.bottom
            anchors.topMargin: (root.height - rightTempText.x - leftTempText.height - tempMenuBar.height - height) * 0.5

            Image {
                id: fan1Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.leftAirPosition === 1 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.leftAirPosition = 1
                }
            }
            Image {
                id: fan2Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.leftAirPosition === 2 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.leftAirPosition = 2
                }
            }
            Image {
                id: fan3Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.leftAirPosition === 3 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.leftAirPosition = 3
                }
            }
        }
    }







    Rectangle {
        id: rightPassenger
        height: root.height - tempMenuBar.height
        anchors.right: parent.right
        width: root.width * 0.5
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
            anchors.bottomMargin: root.height * 0.037
            anchors.right: rightTempText.right

            CustomText {
                id: rightAirText
                text: "1"
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
            text: "20.0"
            font.pointSize: root.height * 0.111
            anchors.left: parent.left
            anchors.leftMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }



        Column {
            id: rightAirColumn
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
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: width * 0.03125

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
                color: "#30ffffff"
                border.color: "#ffffff"
                border.width: width * 0.03125

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
            anchors.right: rightAirColumn.left
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
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: width * 0.03125

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
                    color: "#30ffffff"
                    border.color: "#ffffff"
                    border.width: width * 0.03125

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
            anchors.left: parent.left
            spacing: root.width * 0.026
            anchors.top: rightTempText.bottom
            anchors.topMargin: (root.height - rightTempText.x - rightTempText.height - tempMenuBar.height - height) * 0.5
            anchors.leftMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5

            Image {
                id: fan1Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.rightAirPosition === 1 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.rightAirPosition = 1
                }
            }
            Image {
                id: fan2Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.rightAirPosition === 2 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.rightAirPosition = 2
                }
            }
            Image {
                id: fan3Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.rightAirPosition === 3 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.rightAirPosition = 3
                }
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

            property int btnWidth: (row.width - root.separatorWidth * 7) * 0.125
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
                    color: btn1Container.isOn ? row.lightColorOn : row.lightColorOff
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
                    onClicked: btn1Container.isOn = !btn1Container.isOn
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
                    color: btn2Container.isOn ? row.lightColorOn : row.lightColorOff
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
                    onClicked: btn2Container.isOn = !btn2Container.isOn
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
                    color: btn3Container.isOn ? row.lightColorOn : row.lightColorOff
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
                    onClicked: btn3Container.isOn = !btn3Container.isOn
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
                    color: btn4Container.isOn ? row.lightColorOn : row.lightColorOff
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
                    onClicked: btn4Container.isOn = !btn4Container.isOn
                }
            }

            Separator {
                id: separator4
                height: row.height
                width: root.separatorWidth
            }

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
                        root.handleSyncChange()
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
