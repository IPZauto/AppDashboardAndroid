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
    property bool songStoppedManually: false        // Property to manage auto-play function

    property int buttonSize: 80

    // Background gradient
    gradient: Gradient {
        orientation: Gradient.Horizontal
            GradientStop { position: -0.05; color: "#277070" }
            GradientStop { position: 0.25; color: "#000000" }
            GradientStop { position: 0.75; color: "#000000" }
            GradientStop { position: 1.05; color: "#277070" }
    }

    // Media player Qt element that handles audio output and auto-advance logic
    // onPlayingChanged -> plays next song when the current ended
    MediaPlayer {
        id: musicPlayer
        audioOutput: AudioOutput {id: audioOutput}
        onPlayingChanged: root.playNextSongWhenSongEnded()
    }

    // List of songs used by MediaPlayer
    // Name of the song contains "_" symbol where "space" is needed because of config files specification
    ListModel {
        id: playlistModel
        ListElement {url: "qrc:/resources/sounds/Harry_Styles_-_Daylight.mp3"}
        ListElement {url: "qrc:/resources/sounds/Harry_Styles_-_Satellite.mp3"}
        ListElement {url: "qrc:/resources/sounds/Hozier_-_Too_Sweet.mp3"}
    }

    // Function that plays current song defined by currentSongId
    // Starts the song, displays song title from the playlistModel (changes all "_" to " ")
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

    // Function implenenting the logic to play next song
    function playNextSong(){
        musicPlayer.stop();
        root.songStoppedManually= true;
        root.currentSongId = root.currentSongId >= playlistModel.count-1 ? 0 : root.currentSongId+1;
        playCurrentSong();

    }

    // Function implenenting the logic to play previous song
    function playPreviousSong(){
        musicPlayer.stop();
        root.songStoppedManually= true;
        root.currentSongId = root.currentSongId == 0 ? playlistModel.count - 1 : root.currentSongId-1;
        playCurrentSong();
    }


    // Logic for auto-play function
    // If song ended on its own (!songStoppedMaunally) then plays next song
    function playNextSongWhenSongEnded(){
        if(!root.songStoppedManually){
            root.playNextSong();
        }
        else{
            root.songStoppedManually = false;
        }

    }

    // Text in the center of the screen
    // Displays title of the played song
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

        // Shows song progress
        // onMoved signal informs MediaPlayer element of the change
        Slider {
            id: musicSlider
            height: musicContainer.height
            width: musicContainer.width * 0.9
            value: musicPlayer.position / musicPlayer.duration  // Sets value based on the song duration
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 1
            live: true

            onMoved: {
                musicPlayer.setPosition(musicSlider.value * musicPlayer.duration)
            }

            // Backgrund rectangle
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

            // Slider handle currently invisible
            handle: Rectangle {
                x: musicSlider.visualPosition * (musicSlider.width - width)
                y: musicSlider.topPadding + musicSlider.availableHeight / 2 - height / 2
                width: 20
                height: 20
                implicitWidth: 8
                implicitHeight: 8
                color: "transparent"

            }

            // Rectangle showing progress (changes dynamically)
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

    // Controls for switching the song and play/stop button
    Item {
        id: controlsContainer
        width: 3 * root.buttonSize + 200
        height: root.buttonSize
        anchors.top: musicContainer.bottom
        anchors.topMargin: root.height * 0.06
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            spacing: (controlsContainer.width) / 3
            width: childrenRect.width
            height: controlsContainer.height
            anchors.centerIn: parent

            // Previous song button
            // Sets the songStoppedManualy property to true
            // Stops the current song and switches to the previous one in the playlistModel
            Image {
                id: leftArrow
                source: Qt.resolvedUrl("qrc:/resources/images/arrow_back_icon.png")
                width: root.buttonSize
                height: root.buttonSize
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

            // Play/Stop button
            PlayStopButton {
                id: onOffButton
                width: root.buttonSize
                height: root.buttonSize
                onClicked: {
                    root.songStoppedManually = true;
                    !musicPlayer.playing ? root.playCurrentSong() : musicPlayer.pause();
                }
            }

            // Next song button
            // Sets the songStoppedManualy property to true
            // Stops the current song and switches to the next one in the playlistModel
            Image {
                id: rightArrow
                source: Qt.resolvedUrl("qrc:/resources/images/arrow_forward_icon.png")
                width: root.buttonSize
                height: root.buttonSize
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


    // Changes the muted property
    function changeMuted() {
        root.muted = !root.muted;
    }

    // Mutes and unmutes sound by changing musicPlayer (MediaPlayer) property
    // Changes displayed icon
    function muteSound(){
        changeMuted();
        if(root.muted){
            soundIcon.source = Qt.resolvedUrl("qrc:/resources/images/sound_icon_internet33.png");
        }else{
            soundIcon.source = Qt.resolvedUrl("qrc:/resources/images/sound_icon_internet31.png");
        }
        musicPlayer.audioOutput.muted = root.muted;
    }

    // Volume slider and mute button
    Item {
        id: volumeContainer
        width: root.width * 0.045
        height: root.height * 0.6  + root.buttonSize
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenterOffset: -20

        // Volume slider
        // onMoved property changes the volume value
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
            live: true
            orientation: Qt.Vertical

            onMoved: {
                root.volume = volumeSlider.value;
                audioOutput.volume = root.volume;
            }

            // Static background
            background: Rectangle {
                id: volumeBackgroundRec
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

            // Slider handle
            handle: Rectangle {
                x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                implicitWidth: 8
                implicitHeight: 8
                color: "transparent"
            }

            // Dynamic fill of the slider depending on current volume
            Rectangle {
                id: fill
                height: (1 - volumeSlider.visualPosition) * volumeBackgroundRec.height
                x: volumeBackgroundRec.x + volumeBackgroundRec.width*0.1
                y: volumeBackgroundRec.y + volumeBackgroundRec.height
                width: volumeBackgroundRec.width * 0.8
                color: "#ffffff"
                radius: 10
                transform: Scale { origin.x: volumeBackgroundRec.x; origin.y: volumeBackgroundRec.y; yScale: -1}
            }
        }

        // Mute button
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
                onClicked: root.muteSound();
            }
        }
    }
}
