import QtQuick
import QtQuick.Controls

// Play/Stop button from MusicScreen.qml
Button {
    id: btn
    width: 100
    height: 100
    property bool playing: false

    background: Image {
        id: btn_image
        source: Qt.resolvedUrl("qrc:/resources/images/play_circle_icon.png")
    }

    onClicked: handleButton()

    // Changes button icon when the button is clicked (onClicked signal)
    function handleButton(){
        btn.playing = !btn.playing;
        if(btn.playing){
            btn_image.source = Qt.resolvedUrl("qrc:/resources/images/pause_circle_icon.png")
        }else{
            btn_image.source = Qt.resolvedUrl("qrc:/resources/images/play_circle_icon.png")
        }
    }
}
