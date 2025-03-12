import QtQuick

Rectangle {
    id: root
    color: "#000000"

    CustomText {
        id: test
        text: "NAVIGATION"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
