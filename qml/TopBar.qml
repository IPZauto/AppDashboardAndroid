import QtQuick

Item {
    id: root
    height: bar.height + line.height
    property int cmargin: 40
    property string title: "Nav"
    property bool isLandscapeLayout: true

    Item {
        id: bar
        width: root.width
        height: root.isLandscapeLayout ? 100 : 200
        anchors.top: root.top
        anchors.topMargin: 0

        CustomText {
            id: dateDay
            text: "Sob"
            font.pointSize: root.isLandscapeLayout ? 26 : 32
            anchors.left: parent.left
            anchors.leftMargin: root.cmargin
            anchors.verticalCenter: bar.verticalCenter
        }

        CustomText {
            id: dateTime
            text: "13:09"
            font.pointSize: root.isLandscapeLayout ? 26 : 32
            anchors.left: dateDay.right
            anchors.leftMargin: root.cmargin
            anchors.verticalCenter: bar.verticalCenter
        }

        CustomText {
            id: dataTitle
            text: root.title
            font.pointSize: root.isLandscapeLayout ? 26 : 32
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: bar.verticalCenter
        }

        CustomText {
            id: dateLong
            text: "18 grudnia 2024"
            font.pointSize: root.isLandscapeLayout ? 26 : 32
            anchors.right: parent.right
            anchors.rightMargin: root.cmargin
            anchors.verticalCenter: bar.verticalCenter
        }
    }

    Rectangle {
        id: line
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.width - 300
        height: 2
    }

}


