import QtQuick

Item {
    id: root

    property bool driver: true

    property double rightTemperature: 20.0
    property double leftTemperature: 21.0
    property int rightAir: 1
    property int leftAir: 1
    property int rightAirPosition: 1
    property int leftAirPosition: 1
    property bool syncOn: false


    Loader {
        id: componentLoader
        anchors.fill: parent
        source: root.driver ? Qt.resolvedUrl("TemperatureDriver.qml") : Qt.resolvedUrl("TemperaturePassenger.qml")
        onLoaded: {
            if(componentLoader.item){
                componentLoader.item.passengerSwitched.connect((pass) => {root.driver = pass})
                componentLoader.item.passengerTempSwitched.connect(root.handleTempSwitch)
                componentLoader.item.temperature = root.driver ? root.leftTemperature : root.rightTemperature
                componentLoader.item.passengerAirSwitched.connect(root.handleAirSwitch)
                componentLoader.item.air = root.driver ? root.leftAir : root.rightAir
                componentLoader.item.passengerAirPositionSwitched.connect(root.handleAirPositionSwitch)
                componentLoader.item.airPosition = root.driver ? root.leftAirPosition : root.rightAirPosition

            }
        }
    }

    function handleTempSwitch(pass: bool, temp: double) {
        if(pass){
            // driver
            root.leftTemperature = temp
        }else{
            root.rightTemperature = temp
        }
    }

    function handleAirSwitch(pass: bool, air: int) {
        if(pass){
            // driver
            root.leftAir = air
        }else{
            root.rightAir = air
        }
    }

    function handleAirPositionSwitch(pass: bool, pos: int){
        if(pass){
            root.leftAirPosition = pos
        }else{
            root.rightAirPosition = pos
        }
    }
}
