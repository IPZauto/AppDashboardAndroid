import QtQuick

Rectangle {
    id: root
    width: 1920
    height: 1080
    visible: true
    color: "#000000"

    property int selectedView: 0
    signal viewSent(int view)

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
        height: root.height - (topBar.height + menu.height)
        anchors.top: root.selectedView == 2 ? root.top : topBar.bottom
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
            height: root.height
            width: mainScreen.width
            visible: root.selectedView === 2
            enabled: root.selectedView === 2
            anchors.verticalCenterOffset: -topBar.height
        }

        ReverseScreen {
            height: mainScreen.height
            width: mainScreen.width
            visible: root.selectedView === 3
            enabled: root.selectedView === 3
        }
    }

    function onMyViewSwitched(view){
        root.selectedView = view;
        root.viewSent(view);
        topBar.title = view === 0 ? "Nav" : (view === 1 ? "Globe" : (view === 2 ? "Music" : "Reverse"));
    }

    CustomMenuBar {
        id: menu
        width:root.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        z: 2
        onViewSwitched: (view) => root.onMyViewSwitched(view)
    }

}
