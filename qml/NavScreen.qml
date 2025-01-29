import QtQuick

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#000000"

    CustomText {
        id: test
        text: "NAVIGATION"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
