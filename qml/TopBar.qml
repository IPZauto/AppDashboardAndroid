import QtQuick

// TopBar component: displays time, date, and current view title
Item {
    id: root
    height: bar.height + line.height
    property int cmargin: 40                // Content margin from left/right
    property string title: "Nav"            // Title of the screen
    property bool isLandscapeLayout: true   // Layout mode flag
    property string date: ""                // Current date passed from Main.qml (e.g., "10 February 2024")
    property string time: ""                // Current abbreviated day of week and time, passed from Main.qml (e.g., "Sun 12:38")

    Item {
        id: bar
        width: root.width
        height: root.isLandscapeLayout ? 100 : 200
        anchors.top: root.top
        anchors.topMargin: 0

        // Shows time property from root item (on left side of the topbar)
        CustomText {
            id: dateTime
            text: root.time
            font.pointSize: root.isLandscapeLayout ? 26 : 23
            anchors.left: parent.left
            anchors.leftMargin: root.cmargin
            anchors.verticalCenter: bar.verticalCenter
        }

        // Shows title of the screen (in the center of the topbar)
        CustomText {
            id: dataTitle
            text: root.title
            font.pointSize: root.isLandscapeLayout ? 26 : 23
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: bar.verticalCenter
        }

        // Shows date property from root item (on right side of the topbar)
        CustomText {
            id: dateLong
            text: root.date
            font.pointSize: root.isLandscapeLayout ? 26 : 23
            anchors.right: parent.right
            anchors.rightMargin: root.cmargin
            anchors.verticalCenter: bar.verticalCenter
        }
    }

    // Decorative line below the bar
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


