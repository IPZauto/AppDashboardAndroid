import QtQuick

// Root temperature screen file, displays LandscapeTemperature.qml or PortraitTemperature.qml based on window size
// Passes data between temperature files (functions below)
Item {
    id: root

    property bool landscape: width > height

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

    // Loads chosen file and sets properties values
    Loader {
        id: componentLoader
        anchors.fill: parent
        source: root.landscape ? Qt.resolvedUrl("LandscapeTemperature.qml") : Qt.resolvedUrl("PortraitTemperature.qml")
        asynchronous: true
        onLoaded: {
            if(componentLoader.item){
                componentLoader.item.rightTemperature = root.rightTemperature
                componentLoader.item.leftTemperature = root.leftTemperature
                componentLoader.item.rightAir = root.rightAir
                componentLoader.item.leftAir = root.leftAir
                componentLoader.item.rightAirPosition = root.rightAirPosition
                componentLoader.item.leftAirPosition = root.leftAirPosition

                componentLoader.item.btn1On = root.btn1On
                componentLoader.item.btn2On = root.btn2On
                componentLoader.item.btn3On = root.btn3On
                componentLoader.item.btn4On = root.btn4On
                componentLoader.item.btn5On = root.btn5On
                componentLoader.item.btn6On = root.btn6On
                componentLoader.item.btn7On = root.btn7On
                componentLoader.item.btn8On = root.btn8On

                componentLoader.item.temperatureSwitched.connect(root.handleTempSwitch)
                componentLoader.item.airSwitched.connect(root.handleAirSwitch)
                componentLoader.item.airPositionSwitched.connect(root.handleAirPositionSwitch)
                componentLoader.item.btnSwitched.connect(root.handleBtnSwitch)
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
            break
        case 8:
            root.btn8On = !root.btn8On
            break
        }
    }

    //onWidthChanged: componentLoader.source = landscape ? Qt.resolvedUrl("LandscapeMain.qml") : Qt.resolvedUrl("PortraitMain.qml")
    //onHeightChanged: componentLoader.source = landscape ? Qt.resolvedUrl("LandscapeMain.qml") : Qt.resolvedUrl("PortraitMain.qml")
}
