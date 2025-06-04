import QtQuick

Item {
    id: root
    height: menubar.height + line.height

    signal viewSwitched(int view)
    signal fullScreenChaned(bool fullScreenOn)
    property bool isLandscapeLayout: true
    property int iconSize: isLandscapeLayout ? 120 : 150

    function buttonHandler(id){
        root.viewSwitched(id)
    }

    Rectangle {
        id: line
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.width - 300
        height: 2
    }

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

            MenuButton {
                id: reverseButton
                anchors.verticalCenter: parent.verticalCenter
                width: root.iconSize
                height: root.iconSize
                property int id: 3
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_ac.png")
                }
                onClicked: root.buttonHandler(reverseButton.id)
            }
        }
    }
}
