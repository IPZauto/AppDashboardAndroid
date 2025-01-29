import QtQuick
import QtQuick.Controls

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

    function handleButton(){
        btn.playing = !btn.playing;
        if(btn.playing){
            btn_image.source = Qt.resolvedUrl("qrc:/resources/images/pause_circle_icon.png")
        }else{
            btn_image.source = Qt.resolvedUrl("qrc:/resources/images/play_circle_icon.png")
        }
    }
}
