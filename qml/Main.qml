import QtQuick

Window {
    id: root
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Hello World")
    color: "#000000"

    property int selectedView: 0

    TopBar{
        id: topBar
        width: root.width
        anchors.top: parent.top
        anchors.topMargin: 0
        z: 2
    }

    Item {
        id: mainScreen
        width: root.width
        height: root.height
        anchors.top: parent.top
        anchors.topMargin: 0

        NavScreen {
            height: mainScreen.height
            width: mainScreen.width
            visible: root.selectedView === 0
            enabled: root.selectedView === 0
        }

        GlobeScreen {
            height: mainScreen.height
            width: mainScreen.width
            visible: root.selectedView === 1
            enabled: root.selectedView === 1
        }

        MusicScreen {
            height: mainScreen.height
            width: mainScreen.width
            visible: root.selectedView === 2
            enabled: root.selectedView === 2
        }

        ReverseScreen {
            height: mainScreen.height
            width: mainScreen.width
            visible: root.selectedView === 3
            enabled: root.selectedView === 3
        }
    }

    function onViewSwitched(view){
        root.selectedView = view;
        topBar.title = view === 0 ? "Nav" : (view === 1 ? "Globe" : (view === 2 ? "Music" : "Reverse"));
    }

    CustomMenuBar {
        id: menu
        width:root.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        z: 2
        onViewSwitched: (view) => root.onViewSwitched(view)
    }
}
