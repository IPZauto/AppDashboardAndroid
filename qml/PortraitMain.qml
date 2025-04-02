import QtQuick

Item {
    id: root

    property bool driver: true

    property double rightTemperature: 20.0
    property double leftTemperature: 20.0
    property int rightAir: 1
    property int leftAir: 1
    property int rightAirPosition: 1
    property int leftAirPosition: 1

    property bool btn1On: false
    property bool btn2On: false
    property bool btn3On: false
    property bool btn4On: false
    property bool btn5On: false
    property bool btn6On: false
    property bool btn7On: false
    property bool btn8On: false

    signal temperatureSwitched(bool pass, double temp)
    signal airSwitched(bool pass, int air)
    signal airPositionSwitched(bool pass, int mode)
    signal btnSwitched(int btn)


    Loader {
        id: componentLoader
        anchors.fill: parent
        source: root.driver ? Qt.resolvedUrl("TemperatureDriver.qml") : Qt.resolvedUrl("TemperaturePassenger.qml")
        asynchronous: true
        onLoaded: {
            if(componentLoader.item){
                componentLoader.item.temperature = root.driver ? root.leftTemperature : root.rightTemperature
                componentLoader.item.air = root.driver ? root.leftAir : root.rightAir

                componentLoader.item.airPosition = root.driver ? root.leftAirPosition : root.rightAirPosition

                componentLoader.item.btn1On = root.driver ? root.btn1On : root.btn5On
                componentLoader.item.btn2On = root.driver ? root.btn2On : root.btn6On
                componentLoader.item.btn3On = root.driver ? root.btn3On : root.btn7On
                componentLoader.item.btn4On = root.driver ? root.btn4On : root.btn8On

                componentLoader.item.passengerSwitched.connect((pass) => {root.driver = pass})
                componentLoader.item.passengerTempSwitched.connect(root.handleTempSwitch)
                componentLoader.item.passengerAirSwitched.connect(root.handleAirSwitch)
                componentLoader.item.passengerAirPositionSwitched.connect(root.handleAirPositionSwitch)
                componentLoader.item.passengerBtnSwitched.connect(root.handleBtnSwitch)

            }
        }
    }

    function handleTempSwitch(pass: bool, temp: double) {
        if(pass){
            // driver
            root.leftTemperature = temp
            if(root.btn7On){
                root.handleSyncOn()
            }
        }else{
            root.rightTemperature = temp
        }
        root.temperatureSwitched(pass, temp)
    }

    function handleAirSwitch(pass: bool, air: int) {
        if(pass){
            // driver
            root.leftAir = air
            if(root.btn7On){
                root.handleSyncOn()
            }
        }else{
            root.rightAir = air
        }
        root.airSwitched(pass, air)
    }

    function handleAirPositionSwitch(pass: bool, pos: int){
        if(pass){
            root.leftAirPosition = pos
        }else{
            root.rightAirPosition = pos
        }
        root.airPositionSwitched(pass, pos)
    }

    function handleSyncOn() {
        root.rightTemperature = root.leftTemperature
        root.rightAir = root.leftAir
        root.rightAirPosition = root.leftAirPosition
        if(componentLoader.item){
            componentLoader.item.temperature = root.driver ? root.leftTemperature : root.rightTemperature
            componentLoader.item.air = root.driver ? root.leftAir : root.rightAir
            componentLoader.item.airPosition = root.driver ? root.leftAirPosition : root.rightAirPosition
        }
    }

    function handleBtnSwitch(pass: bool, btn: int){
        if(pass){
            switch(btn){
            case 1:
                root.btn1On = !root.btn1On
                //root.btnSwitched(1)
                break
            case 2:
                root.btn2On = !root.btn2On
                //root.btnSwitched(2)
                break
            case 3:
                root.btn3On = !root.btn3On
                //root.btnSwitched(3)
                break
            case 4:
                root.btn4On = !root.btn4On
                //root.btnSwitched(4)
                break
            }
        }else{
            switch(btn){
            case 1:
                root.btn5On = !root.btn5On
                //root.btnSwitched(5)
                break
            case 2:
                root.btn6On = !root.btn6On
                //root.btnSwitched(6)
                break
            case 3:
                root.btn7On = !root.btn7On
                if(root.btn7On){
                    root.handleSyncOn()
                }
                //root.btnSwitched(7)
                break
            case 4:
                root.btn8On = !root.btn8On
                //root.btnSwitched(8)
                break
            }
        }
        const temp = pass ? 0 : 1
        root.btnSwitched(btn + 4 * temp)
    }
}
