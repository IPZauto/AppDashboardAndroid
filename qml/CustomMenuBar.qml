import QtQuick

Item {
    id: root
    height: menubar.height + line.height

    signal viewSwitched(int view)

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
        height: 150
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0


        Row {
            id: menuRow
            spacing: (root.width - 400 - 400) / 3
            width: childrenRect.width
            height: menubar.height
            anchors.centerIn: parent

            MenuButton {
                id: navButton
                anchors.verticalCenter: parent.verticalCenter
                property int id: 0
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_nav.png")
                }
                onClicked: root.buttonHandler(navButton.id)
            }

            MenuButton {
                id: globeButton
                anchors.verticalCenter: parent.verticalCenter
                property int id: 1
                background: Image {
                    id: image
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_globe1.png")
                }
                onClicked: root.buttonHandler(globeButton.id)
            }

            MenuButton {
                id: musicButton
                anchors.verticalCenter: parent.verticalCenter
                property int id: 2
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_music.png")
                }
                onClicked: root.buttonHandler(musicButton.id)
            }

            MenuButton {
                id: reverseButton
                anchors.verticalCenter: parent.verticalCenter
                property int id: 3
                background: Image {
                    source: Qt.resolvedUrl("qrc:/resources/images/icon_reverse2.png")
                }
                onClicked: root.buttonHandler(reverseButton.id)
            }
        }
    }
}

