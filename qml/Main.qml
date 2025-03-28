import QtQuick

Window {
    id: root
    width: 1920
    height: 1080
    visible: true
    color: "#000000"
    property bool fullScreenOn: true
    visibility: fullScreenOn ? Window.FullScreen : Window.Windowed


    property int selectedView: 0
    property bool isLandscape: root.width > root.height
    //signal viewSent(int view)

    TopBar{
        id: topBar
        width: root.width
        anchors.top: parent.top
        anchors.topMargin: 0
        z: 2
        isLandscapeLayout: root.isLandscape
    }

    Item {
        id: mainScreen
        width: root.width
        height: root.height - (topBar.height + menu.height)
        anchors.top: root.selectedView == 2 ? parent.top : topBar.bottom
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

        TemperatureScreen {
            height: mainScreen.height
            width: mainScreen.width
            visible: root.selectedView === 3
            enabled: root.selectedView === 3
        }
    }

    function onMyViewSwitched(view){
        root.selectedView = view;
        //root.viewSent(view);
        topBar.title = view === 0 ? "Nav" : (view === 1 ? "Globe" : (view === 2 ? "Music" : "Temperature"));
    }

    CustomMenuBar {
        id: menu
        width:root.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        z: 2
        onViewSwitched: (view) => root.onMyViewSwitched(view)
        onFullScreenChaned: (fullScreenOn) => root.fullScreenOn = fullScreenOn
        isLandscapeLayout: root.isLandscape
    }

}






// import QtQuick

// Window {
//     id: root
//     width: 1920
//     height: 1080
//     visible: true
//     // color: "#000000"

//     //property int selectedView: 0
//     property int selectedMainView: 0
//     property bool isLandscape: root.width > root.height

//     Loader {
//         id: layoutLoader
//         anchors.fill: parent
//         source: root.isLandscape ? Qt.resolvedUrl("./LandscapeMain.qml") : Qt.resolvedUrl("./PortraitMain.qml")
//         onLoaded: {
//             if(layoutLoader.item){  //item: This property holds the top-level object that is currently loaded.
//                 layoutLoader.item.selectedView = root.selectedMainView

//                 layoutLoader.item.viewSent.connect(function(view){
//                     root.selectedMainView = view
//                 })
//             }
//         }
//     }

//     onWidthChanged: manageLayout()

//     Component.onCompleted: {
//         manageLayout();
//     }

//     function manageLayout(){
//         root.isLandscape = root.width > root.height;
//         layoutLoader.source = root.isLandscape ? Qt.resolvedUrl("./LandscapeMain.qml") : Qt.resolvedUrl("./PortraitMain.qml");
//     }

//     CustomText {
//         id: test
//         z: 20
//         font.pointSize: 50
//         text: root.selectedMainView
//     }

//     // TopBar{
//     //     id: topBar
//     //     width: root.width
//     //     anchors.top: parent.top
//     //     anchors.topMargin: 0
//     //     z: 2
//     // }

//     // Item {
//     //     id: mainScreen
//     //     width: root.width
//     //     height: root.height
//     //     anchors.top: parent.top
//     //     anchors.topMargin: 0

//     //     NavScreen {
//     //         height: mainScreen.height
//     //         width: mainScreen.width
//     //         visible: root.selectedView === 0
//     //         enabled: root.selectedView === 0
//     //     }

//     //     GlobeScreen {
//     //         height: mainScreen.height
//     //         width: mainScreen.width
//     //         visible: root.selectedView === 1
//     //         enabled: root.selectedView === 1
//     //     }

//     //     MusicScreen {
//     //         height: mainScreen.height
//     //         width: mainScreen.width
//     //         visible: root.selectedView === 2
//     //         enabled: root.selectedView === 2
//     //     }

//     //     ReverseScreen {
//     //         height: mainScreen.height
//     //         width: mainScreen.width
//     //         visible: root.selectedView === 3
//     //         enabled: root.selectedView === 3
//     //     }
//     // }

//     // function onViewSwitched(view){
//     //     root.selectedView = view;
//     //     topBar.title = view === 0 ? "Nav" : (view === 1 ? "Globe" : (view === 2 ? "Music" : "Reverse"));
//     // }

//     // CustomMenuBar {
//     //     id: menu
//     //     width:root.width
//     //     anchors.bottom: parent.bottom
//     //     anchors.bottomMargin: 0
//     //     z: 2
//     //     onViewSwitched: (view) => root.onViewSwitched(view)
//     // }
// }

