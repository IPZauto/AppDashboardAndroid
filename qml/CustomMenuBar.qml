import QtQuick

Item {
    id: root
    height: menubar.height + line.height

    signal viewSwitched(int view)                           // Signal sent to Main.qml, informs to switch view (showed screen)
    signal fullScreenChaned(bool fullScreenOn)              // Signal sent to Main.qml, informs to toggle fullscreen
    property bool isLandscapeLayout: true
    property int iconSize: isLandscapeLayout ? 120 : 150

    // Function that handles button click action, sends the viewSwitched signal
    function buttonHandler(id){
        root.viewSwitched(id)
    }

    // Decorative line above the menu bar
    Rectangle {
        id: line
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.width - 300
        height: 2
    }

    // Menu bar with 4 buttons
    Item {
        id: menubar
        width: root.width
        height: root.isLandscapeLayout ? 150 : 300
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Row {
            id: menuRow
            spacing: (root.width - 4*root.iconSize - (root.width*0.2)) / 3
            width: childrenRect.width
            height: menubar.height
            anchors.centerIn: parent

            // Button switching to NavScreen.qml
            MenuButton {
                id: navButton
                anchors.verticalCenter: parent.verticalCenter
                width: root.iconSize
                height: root.iconSize
                property int id: 0
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_nav.png")
                }
                onClicked: root.buttonHandler(navButton.id)
            }

            // Button swiching to GlobeScreen.qml (functionality commented out)
            // Because the target functionality is not implemented, button acts as a fullscreen toggle button
            MenuButton {
                id: globeButton
                anchors.verticalCenter: parent.verticalCenter
                width: root.iconSize
                height: root.iconSize
                property int id: 1
                property bool fullScreenOn: true
                background: Image {
                    id: image
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_globe1.png")
                }
                //onClicked: root.buttonHandler(globeButton.id)
                onClicked: {
                    fullScreenOn = !fullScreenOn;
                    root.fullScreenChaned(fullScreenOn)
                }
            }

            // Button switching to MusicScreen.qml
            MenuButton {
                id: musicButton
                anchors.verticalCenter: parent.verticalCenter
                width: root.iconSize
                height: root.iconSize
                property int id: 2
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_music.png")
                }
                onClicked: root.buttonHandler(musicButton.id)
            }

            // Button switching to TemperatureScreen.qml
            MenuButton {
                id: temperatureButton
                anchors.verticalCenter: parent.verticalCenter
                width: root.iconSize
                height: root.iconSize
                property int id: 3
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_ac.png")
                }
                onClicked: root.buttonHandler(temperatureButton.id)
            }
        }
    }
}
