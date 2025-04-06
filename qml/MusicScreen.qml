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
        font.pointSize: root.width * 0.02
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: musicContainer
        width: 2 * root.width / 3
        height: root.height * 0.015
        y: 2 * (root.height)/3 - 6 * height
        anchors.horizontalCenter: parent.horizontalCenter

        Slider {
            id: musicSlider
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

                musicPlayer.setPosition(musicSlider.value * musicPlayer.duration)

            }

            background: Rectangle {
                id: musicBackgroundRec
                y: musicSlider.topPadding + musicSlider.availableHeight / 2 - height / 2
                width: musicSlider.width
                height: musicSlider.height
                radius: 1
                color: "#ffffff"
                opacity: 0.2
                border.color: "#ffffff"
                border.width: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -5
            }

            handle: Rectangle {
                x: musicSlider.visualPosition * (musicSlider.width - width)
                y: musicSlider.topPadding + musicSlider.availableHeight / 2 - height / 2
                width: 20
                height: 20

                implicitWidth: 8
                implicitHeight: 8
                color: "#abcbac"
            }

            Rectangle {
                id: musicFill
                width: musicSlider.visualPosition * musicBackgroundRec.width
                x: musicBackgroundRec.x + musicBackgroundRec.width*0
                y: musicBackgroundRec.y + musicBackgroundRec.height*0.2
                height: musicBackgroundRec.height * 0.6
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
        width: 3 * 80 + 200
        height: 80
        anchors.top: musicContainer.bottom
        anchors.topMargin: root.height * 0.06
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            spacing: (controlsContainer.width) / 3
            width: childrenRect.width
            height: controlsContainer.height
            anchors.centerIn: parent

            Image {
                id: leftArrow
                source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
                width: 80
                height: 80
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: leftArrowArea
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
                id: rightArrow
                source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
                width: 80
                height: 80
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: rightArrowArea
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
            soundIcon.source = Qt.resolvedUrl("qrc:/resources/images/sound_icon_internet33.png");
        }else{
            soundIcon.source = Qt.resolvedUrl("qrc:/resources/images/sound_icon_internet31.png");
        }
        musicPlayer.audioOutput.muted = root.muted;
    }

    Item {
        id: volumeContainer
        width: root.width * 0.045
        height: root.height * 0.6  + 80
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenterOffset: -20

        Slider {
            id: volumeSlider
            height: root.height*0.52
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
                root.volume = volumeSlider.value;
                audioOutput.volume = root.volume;
            }

            background: Rectangle {
                id: volumeBackgroundRec
                //x: slider.leftPadding
                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                width: volumeSlider.width*0.15
                height: volumeSlider.height
                radius: 1
                color: "#ffffff"
                opacity: 0.2
                border.color: "#ffffff"
                border.width: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -5
            }

            handle: Rectangle {
                x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                implicitWidth: 8
                implicitHeight: 8
                color: "transparent"
            }

            Rectangle {
                id: fill
                height: (1 - volumeSlider.visualPosition) * volumeBackgroundRec.height
                //height: backgroundRec.height
                x: volumeBackgroundRec.x + volumeBackgroundRec.width*0.1
                y: volumeBackgroundRec.y + volumeBackgroundRec.height
                width: volumeBackgroundRec.width * 0.8
                color: "#ffffff"
                radius: 10
                transform: Scale { origin.x: volumeBackgroundRec.x; origin.y: volumeBackgroundRec.y; yScale: -1}
            }
        }

        Image {
            id: soundIcon
            width: 50
            anchors.top: parent.top
            anchors.bottom: volumeSlider.top
            anchors.topMargin: 0
            source: Qt.resolvedUrl("qrc:/resources/images/sound_icon_internet31.png")
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: root.manageSound();
            }
        }
    }
}
