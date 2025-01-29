import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: root
    width: 1920
    height: 1080
    property int currentSongId: 0
    property double volume: 0.1
    property bool muted: false
    property bool songStoppedManually: false

    gradient: Gradient {
        orientation: Gradient.Horizontal
            GradientStop { position: -0.05; color: "#277070" }
            GradientStop { position: 0.25; color: "#000000" }
            GradientStop { position: 0.75; color: "#000000" }
            GradientStop { position: 1.05; color: "#277070" }
    }

    MediaPlayer {
        id: musicPlayer
        audioOutput: AudioOutput {id: audioOutput}
        onPlayingChanged: root.playNextSongWhenSongEnded()
    }

    ListModel {
        id: playlistModel
        ListElement {url: "qrc:/resources/sounds/Harry_Styles_-_Daylight.mp3"}
        ListElement {url: "qrc:/resources/sounds/Harry_Styles_-_Satellite.mp3"}
        ListElement {url: "qrc:/resources/sounds/Hozier_-_Too_Sweet.mp3"}
    }

    function playCurrentSong(){

        if(root.currentSongId>=0 && root.currentSongId<playlistModel.count){
            musicPlayer.source = Qt.resolvedUrl(playlistModel.get(root.currentSongId).url);
        }else{
            root.currentSongId = 0;
        }
        musicPlayer.play();
        musicText.text = playlistModel.get(root.currentSongId).url.slice((playlistModel.get(root.currentSongId).url).lastIndexOf("/")+1).replace(/_/g," ");
        onOffButton.playing = false;
        onOffButton.handleButton();
    }

    function playNextSong(){
        musicPlayer.stop();
        root.songStoppedManually= true;
        root.currentSongId = root.currentSongId >= playlistModel.count-1 ? 0 : root.currentSongId+1;
        playCurrentSong();

    }

    function playPreviousSong(){
        musicPlayer.stop();
        root.songStoppedManually= true;
        root.currentSongId = root.currentSongId == 0 ? playlistModel.count - 1 : root.currentSongId-1;
        playCurrentSong();
    }


    function playNextSongWhenSongEnded(){
        if(!root.songStoppedManually){
            root.playNextSong();
        }
        else{
            root.songStoppedManually=false;
        }

    }

    CustomText {
        id: musicText
        text: "MUSIC"
        font.pointSize: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: musicContainer
        width: 2*root.width / 3
        height: 10
        y: 2*(root.height)/3 - 6 * height
        anchors.horizontalCenter: parent.horizontalCenter

        Slider {
            id: slider_music
            height: musicContainer.height
            width: musicContainer.width * 0.9
            value: musicPlayer.position / musicPlayer.duration
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 1
            //stepSize: 0.01
            live: true
            //snapMode: Slider.SnapOnRelease

            onMoved: {

                musicPlayer.setPosition(slider_music.value * musicPlayer.duration)

            }

            background: Rectangle {
                id: backgroundRec_music
                y: slider_music.topPadding + slider_music.availableHeight / 2 - height / 2
                width: slider_music.width
                height: slider_music.height
                radius: 1
                color: "#ffffff"
                opacity: 0.2
                border.color: "#ffffff"
                border.width: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -5
            }

            handle: Rectangle {
                x: slider_music.visualPosition * (slider_music.width - width)
                y: slider_music.topPadding + slider_music.availableHeight / 2 - height / 2
                width: 20
                height: 20

                implicitWidth: 8
                implicitHeight: 8
                color: "#abcbac"
            }

            Rectangle {
                id: fill_music
                width: slider_music.visualPosition * backgroundRec_music.width
                x: backgroundRec_music.x + backgroundRec_music.width*0
                y: backgroundRec_music.y + backgroundRec_music.height*0.2
                height: backgroundRec_music.height * 0.6
                color: "#ffffff"
                radius: 10
            }
        }



    }

    //MediaPlayer position
    // ProgressBar {
    //     id: progressBar
    //     width: 2*root.width/3
    //     height: 10
    //     value: musicPlayer.position / musicPlayer.duration
    //     y: 2*(root.height)/3 - 6 * height
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     from: 0
    //     to: 1

    // }

    Item {
        id: controlsContainer
        width: 3*80+ 200
        height: 80
        anchors.top: musicContainer.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            spacing: (controlsContainer.width) / 3
            width: childrenRect.width
            height: controlsContainer.height
            anchors.centerIn: parent

            Image {
                id: left_arrow
                source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
                width: 80
                height: 80
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: left_arrow_area
                    anchors.fill: parent
                    onClicked:{
                        root.songStoppedManually = true;
                        root.playPreviousSong();
                    }
                }
            }

            PlayStopButton {
                id: onOffButton
                width: 80
                height: 80
                onClicked: {
                    root.songStoppedManually = true;
                    !musicPlayer.playing ? root.playCurrentSong() : musicPlayer.pause();
                }
            }

            Image {
                id: right_arrow
                source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
                width: 80
                height: 80
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: right_arrow_area
                    anchors.fill: parent
                    onClicked: {

                        root.songStoppedManually = true;
                        root.playNextSong();
                    }
                }
            }
        }
    }

    function checkMuted() {
        root.muted = !root.muted;
    }

    function manageSound(){
        checkMuted();
        if(root.muted){
            sound_icon.source = "qrc:/resources/images/sound_icon_internet33.png";
        }else{
            sound_icon.source = "qrc:/resources/images/sound_icon_internet31.png";
        }
        musicPlayer.audioOutput.muted = root.muted;
    }

    Item {
        id: _item
        width: 80
        height: 1*root.width/3 + 80
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenterOffset: -20

        Slider {
            id: slider
            height: root.width*0.29
            width: root.height*0.1
            value: 0.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 1
            //stepSize: 0.01
            live: true
            orientation: Qt.Vertical
            //snapMode: Slider.SnapOnRelease

            onMoved: {
                root.volume = slider.value;
                audioOutput.volume = root.volume;
            }

            background: Rectangle {
                id: backgroundRec
                //x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: slider.width*0.15
                height: slider.height
                radius: 1
                color: "#ffffff"
                opacity: 0.2
                border.color: "#ffffff"
                border.width: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -5
            }

            handle: Rectangle {
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 8
                implicitHeight: 8
                color: "transparent"
            }

            Rectangle {
                id: fill
                height: (1 - slider.visualPosition) * backgroundRec.height
                //height: backgroundRec.height
                x: backgroundRec.x + backgroundRec.width*0.1
                y: backgroundRec.y + backgroundRec.height
                width: backgroundRec.width * 0.8
                color: "#ffffff"
                radius: 10
                transform: Scale { origin.x: backgroundRec.x; origin.y: backgroundRec.y; yScale: -1}
            }
        }

        Image {
            id: sound_icon
            width: 50
            anchors.top: parent.top
            anchors.bottom: slider.top
            anchors.topMargin: 0
            source: "qrc:/resources/images/sound_icon_internet31.png"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: root.manageSound();
            }
        }
    }
}
