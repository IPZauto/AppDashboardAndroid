import QtQuick

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: backgroundColor

    property int separatorWidth: 7
    property string backgroundColor: "#000000"
    property string gradientColor: "#393f45"
    property string buttonEnabledColor: "#30ffffff"     // buttons to change temperature and airflow
    property string buttonDisabledColor: "#10ffffff"    // buttons to change temperature and airflow

    property int rectWidth: root.width * 0.05
    property int rectHeight: root.height * 0.25
    property int fanPositionIconSize: root.width * 0.05

    property double rightTemperature: 20.0
    property double leftTemperature: 20.0
    property int rightAir: 1
    property int leftAir: 1
    property int rightAirPosition: 1
    property int leftAirPosition: 1

    // SYNC, ... buttons, on the bottom of the screen
    property bool btn1On: false
    property bool btn2On: false
    property bool btn3On: false
    property bool btn4On: false
    property bool btn5On: false
    property bool btn6On: false
    property bool btn7On: false
    property bool btn8On: false

    // minimun i maximum values allowed
    property double minAllowedTemperature: 17.0
    property double maxAllowedTemperature: 30.0

    property int minAllowedBlowPower: 0
    property int maxAllowedBlowPower: 5


    // signals to pass data to other temperature files
    signal temperatureSwitched(bool pass, double temp)
    signal airSwitched(bool pass, int air)
    signal airPositionSwitched(bool pass, int mode)
    signal btnSwitched(int btn)

    //driver: true - driver, false - passenger; increase: true - add .5, false subtract .5
    function handleTemperatureChange(driver: bool, increase: bool, syncFun = false) {
        let change = 0.5
        if(!increase) {
            change = -change
        }

        if(driver){
            root.leftTemperature += change
        }
        if(!driver || root.btn7On){
            root.rightTemperature += change
            if(!driver && root.btn7On && !syncFun){
                root.handleBtnSwitch(7)
            }
        }
        root.temperatureSwitched(driver, driver ? root.leftTemperature : root.rightTemperature)
    }

    // driver: true - driver, false - passenger; increase: true - add 1, false subtract 1
    function handleAirChange(driver: bool, increase: bool, syncFun = false) {
        let change = 1
        if(!increase) {
            change = -change
        }

        if(driver){
            root.leftAir += change
        }

        if(!driver || root.btn7On){
            root.rightAir += change
            if(!driver && root.btn7On && !syncFun){
                root.handleBtnSwitch(7)
            }
        }
        root.airSwitched(driver, driver ? root.leftAir : root.rightAir)
    }

    function handleSyncOn(){
        var change = (root.leftTemperature - root.rightTemperature) * 2
        var n = Math.abs(change)
        for(var i=0; i<n; i++){
            root.handleTemperatureChange(false, change>0, true)
        }

        change = root.leftAir - root.rightAir
        n = Math.abs(change)
        for(i=0; i<n; i++){
            root.handleAirChange(false, change>0, true)
        }
    }

    // driver: true - driver, false - passenger; pos - position of airflow
    // (3 options: 1 - low,  2 - low & mid,  3 - mid)
    // only one active at the time
    function handleAirPositionChange(driver: bool, pos: int){
        if(!driver){
            root.rightAirPosition = pos
        }else{
            root.leftAirPosition = pos
        }
        root.airPositionSwitched(driver, !driver ? root.rightAirPosition : root.leftAirPosition)
    }

    // SYNC,... buttons at the bottom of the screen
    function handleBtnSwitch(btn: int){
        switch(btn){
        case 1:
            root.btn1On = !root.btn1On
            break
        case 2:
            root.btn2On = !root.btn2On
            break
        case 3:
            root.btn3On = !root.btn3On
            break
        case 4:
            root.btn4On = !root.btn4On
            break
        case 5:
            root.btn5On = !root.btn5On
            break
        case 6:
            root.btn6On = !root.btn6On
            break
        case 7:
            root.btn7On = !root.btn7On
            if(root.btn7On){
                root.handleSyncOn()
            }
            break
        case 8:
            root.btn8On = !root.btn8On
            break
        }
        root.btnSwitched(btn)
    }

    // Drivers controls
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

        // Controls for temperature
        Row {
            id: leftTempRow
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: leftAirColumn.right
            anchors.leftMargin: root.width * 0.04

            // Colorful bar (for visual purpose)
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

                // Increase temperature
                Rectangle {
                    id: rect2TempLeft
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color:  enabled ? buttonEnabledColor : buttonDisabledColor
                    border.color: "#ffffff"
                    border.width: width * 0.03125
                    enabled: root.leftTemperature < root.maxAllowedTemperature

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

                // Decrease temperature
                Rectangle {
                    id: rect1TempLeft
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: enabled ? buttonEnabledColor : buttonDisabledColor
                    border.color: "#ffffff"
                    border.width: width * 0.03125
                    enabled: root.leftTemperature > root.minAllowedTemperature

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
        }


        // Controls for airflow (power)
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

            // Shows current driver airflow power
            CustomText {
                id: leftAirText
                text: root.leftAir.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: root.height * 0.074
            }
        }

        // Actual buttons (functionality)
        Column {
            id: leftAirColumn
            anchors.verticalCenter: parent.verticalCenter
            spacing: root.height * 0.014
            anchors.left: parent.left
            anchors.leftMargin: root.width * 0.04

            // Increase airflow
            Rectangle {
                id: rect2AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: enabled ? buttonEnabledColor : buttonDisabledColor
                border.color: "#ffffff"
                border.width: width * 0.03125
                enabled: root.leftAir < root.maxAllowedBlowPower

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

            // Decrease airflow
            Rectangle {
                id: rect1AirLeft
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: enabled ? buttonEnabledColor : buttonDisabledColor
                border.color: "#ffffff"
                border.width: width * 0.03125
                enabled: root.leftAir > root.minAllowedBlowPower

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

        // Shows current temperature setting
        CustomText {
            id: leftTempText
            text: root.leftTemperature.toFixed(1)
            font.pointSize: root.height * 0.12
            anchors.right: parent.right
            anchors.rightMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }

        // Controls for airflow position
        Row {
            anchors.right: parent.right
            anchors.rightMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5
            spacing: root.width * 0.026
            anchors.top: leftTempText.bottom
            anchors.topMargin: (root.height - leftTempText.y - leftTempText.height - tempMenuBar.height - height) * 0.7

            // Low
            Image {
                id: fan1Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.leftAirPosition === 1 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(true, 1)
                }
            }

            // Low & mid
            Image {
                id: fan2Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.leftAirPosition === 2 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(true, 2)
                }
            }

            // Mid
            Image {
                id: fan3Left
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                opacity: root.leftAirPosition === 3 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(true, 3)
                }
            }
        }
    }






    // Passenger screen
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

            // Shows current driver airflow power
            CustomText {
                id: rightAirText
                text: root.rightAir.toString()
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

        // Shows passenger's current temperature setting
        CustomText {
            id: rightTempText
            text: root.rightTemperature.toFixed(1)
            font.pointSize: root.height * 0.111
            anchors.left: parent.left
            anchors.leftMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }


        // Controls for airflow (power)
        Column {
            id: rightAirColumn
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: root.width * 0.04
            anchors.verticalCenterOffset: 0
            spacing: root.height * 0.014

            // Increase power of airflow
            Rectangle {
                id: rect2AirRight
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: enabled ? buttonEnabledColor : buttonDisabledColor
                border.color: "#ffffff"
                border.width: width * 0.03125
                enabled: root.rightAir < root.maxAllowedBlowPower

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

            // Decrease power of airflow
            Rectangle {
                id: rect1AirRight
                width: root.rectWidth
                height: root.rectHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: enabled ? buttonEnabledColor : buttonDisabledColor
                border.color: "#ffffff"
                border.width: width * 0.03125
                enabled: root.rightAir > root.minAllowedBlowPower

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

        // Temperature setting
        Row {
            id: rightTempRow
            anchors.right: rightAirColumn.left
            anchors.rightMargin: root.width * 0.04
            anchors.verticalCenter: parent.verticalCenter


            Column {
                id: rightTempColumn
                spacing: root.height * 0.014

                // Increase temperature
                Rectangle {
                    id: rect2TempRight
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: enabled ? buttonEnabledColor : buttonDisabledColor
                    border.color: "#ffffff"
                    border.width: width * 0.03125
                    enabled: root.rightTemperature < root.maxAllowedTemperature

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

                // Decrease temperature
                Rectangle {
                    id: rect1TempRight
                    width: root.rectWidth
                    height: root.rectHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: enabled ? buttonEnabledColor : buttonDisabledColor
                    border.color: "#ffffff"
                    border.width: width * 0.03125
                    enabled: root.rightTemperature > root.minAllowedTemperature

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

            // Colorful bar (for visual purpose)
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

        // Airflow position setting for passenger
        Row {
            anchors.left: parent.left
            spacing: root.width * 0.026
            anchors.top: rightTempText.bottom
            anchors.topMargin: (root.height - rightTempText.y - rightTempText.height - tempMenuBar.height - height) * 0.7
            anchors.leftMargin: (root.width * 0.5 - 2 * root.rectWidth - 2 * root.width * 0.04 - root.rectWidth * 0.25 - width) * 0.5

            // Low
            Image {
                id: fan1Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.rightAirPosition === 1 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(false , 1)
                }
            }

            // Low & mid
            Image {
                id: fan2Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_low_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.rightAirPosition === 2 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(false, 2)
                }
            }
            // Mid
            Image {
                id: fan3Right
                source: Qt.resolvedUrl("qrc:/resources/images/car_fan_mid_left_icon.png")
                width: root.fanPositionIconSize
                height: width
                mirror: true
                opacity: root.rightAirPosition === 3 ? 1.0 : 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.handleAirPositionChange(false, 3)
                }
            }
        }
    }




    // Bottom menu bar with SYNC, ..
    // Each button has it's own "light" indicating if button is on/off
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
            property string lightColorOn: "#e6a340"             //on
            property string lightColorOff: "#5c646b"            //off
            property int buttonHeight: root.height * 0.12
            property int imageSize: root.height * 0.09

            // Left seat (driver) heating
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
                    onClicked: root.handleBtnSwitch(1)
                }
            }

            Separator {
                id: separator1
                height: row.height
                width: root.separatorWidth
            }

            // Steering wheel heating
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
                    onClicked: root.handleBtnSwitch(2)
                }
            }

            Separator {
                id: separator2
                height: row.height
                width: root.separatorWidth
            }

            // AUTO (not implemented)
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
                    onClicked: root.handleBtnSwitch(3)
                }
            }

            Separator {
                id: separator3
                height: row.height
                width: root.separatorWidth
            }

            // A/C
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
                    onClicked: root.handleBtnSwitch(4)
                }
            }

            Separator {
                id: separator4
                height: row.height
                width: root.separatorWidth
            }

            // Defrost front windshield
            Item {
                id: btn5Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light5
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn5On ? row.lightColorOn : row.lightColorOff
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
                    onClicked: root.handleBtnSwitch(5)
                }
            }

            Separator {
                id: separator5
                height: row.height
                width: root.separatorWidth
            }

            // Defrost rear windshield
            Item {
                id: btn6Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light6
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn6On ? row.lightColorOn : row.lightColorOff
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
                    onClicked: root.handleBtnSwitch(6)
                }
            }

            Separator {
                id: separator6
                height: row.height
                width: root.separatorWidth
            }

            // SYNC
            Item {
                id: btn7Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light7
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn7On ? row.lightColorOn : row.lightColorOff
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
                        root.handleBtnSwitch(7)
                        //root.handleSyncChange()
                    }
                }
            }

            Separator {
                id: separator7
                height: row.height
                width: root.separatorWidth
            }

            // Right seat (passenger) heating
            Item {
                id: btn8Container
                width: row.btnWidth
                height: row.buttonHeight + row.lightHeight + row.lightTopMargin

                property bool isOn: false

                Rectangle {
                    id: light8
                    width: row.lightWidth
                    height: row.lightHeight
                    color: root.btn8On ? row.lightColorOn : row.lightColorOff
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
                    onClicked: root.handleBtnSwitch(8)
                }
            }
        }
    }
}
