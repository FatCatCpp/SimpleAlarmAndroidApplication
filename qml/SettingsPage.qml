import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Item {
    id: item

    signal call()

    property int showWidth

    property bool detailVoice: false
    property bool detailOpacity: false
    property bool detailSelectSound: false
    property bool detailImage: false

    property real userOpacityValue

    property int playStatus: 0 // 0 - stopped; 1 - played; 2 - paused

    Rectangle {
        x: -400

        anchors.fill: parent
        color: "#F0F0F0"

        Image {
            id: backgroundImage

            visible: false

            source: "qrc:/images/basic.png"

            width: parent.width
            height: parent.height

            anchors.fill: parent

            opacity: 0.3
        }

        SettingsDelegate {
            id: selectSound

            width: parent.width * 0.9
            height: 100

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 100

            additionalItem: false

            z: 4

            valueText: "eye_of_the_tiger.mp3"

            buttonText: "Мелодия будильника"

            CustomRoundButton {
                id: buttonSelectSound

                diameter: 40

                visible: false

                anchors {
                    left: parent.left
                    leftMargin: (parent.width - 5 * width) / 2
                    top: parent.top
                    topMargin: 40
                }

                sourcePath: "qrc:/images/folder.png"
            }

            CustomRoundButton {
                id: buttonPlay

                diameter: 40

                visible: false

                anchors {
                    left: buttonSelectSound.right
                    leftMargin: width
                    top: parent.top
                    topMargin: 40
                }

                sourcePath: "qrc:/images/play.png"

                onClick: {
                    if (playStatus === 1) {
                        alarmAudio.pause()
                        sourcePath = "qrc:/images/play.png"
                        buttonStop.opacity = 1
                    } else if (playStatus === 2 || playStatus === 0) {
                        alarmAudio.play()
                        sourcePath = "qrc:/images/pause.png"
                    }
                }
            }

            CustomRoundButton {
                id: buttonStop

                diameter: 40

                visible: false

                anchors {
                    left: buttonPlay.right
                    leftMargin: width
                    top: parent.top
                    topMargin: 40
                }

                sourcePath: "qrc:/images/stop.png"

                onClick: {
                    if (playStatus === 1) {
                        buttonStop.enabled = false
                        alarmAudio.stop()
                        opacity = 0.3
                        buttonPlay.sourcePath = "qrc:/images/play.png"
                    } else {
                        buttonStop.enabled = true
                        opacity = 1
                    }
                }
            }

            onClickedRound: {
                if (detailSelectSound === false) {
                    detailSelectSound = true

                    hideButtons(true)
                } else {
                    detailSelectSound = false

                    hideButtons(false)
                }
            }
        }

        SettingsDelegate {
            id: voiceSound

            width: parent.width * 0.9
            height: 100

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 210

            valueText: "100 %"

            additionalItem: true

            buttonText: "Громкость звонка"

            CustomSlider {
                id: voiceSlider

                visible: false

                width: parent.width / 2
                height: 30

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40

                sliderDefaulrValue: 30

                onSliderValueChanged: {
                    voiceSlider.valueText = Math.round(value).toString() + "%"
                    alarmAudio.volume = value / 100
                }
            }

            z: 3

            onClickedRound: {
                if (detailVoice === false) {
                    detailVoice = true

                    voiceSlider.visible = true

                    alarmAudio.play()


                } else {
                    detailVoice = false

                    alarmAudio.stop()

                    voiceSlider.visible = false
                }
            }
        }

        SettingsDelegate {
            id: selectImage

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 320

            width: parent.width * 0.9
            height: 100

            additionalItem: false

            z: 2

            valueText: "мои котики"

            buttonText: "Фоновое изображение"

            CustomRoundButton {
                id: selectImageButton

                diameter: 40

                visible: false

                anchors {
                    left: parent.left
                    leftMargin: (parent.width - width) / 2
                    top: parent.top
                    topMargin: 40
                }

                sourcePath: "qrc:/images/folder.png"

                onClick: {

                }
            }

            onClickedRound: {
                if (detailImage === false) {
                    detailImage = true

                    selectImageButton.visible = true
                } else {
                    detailImage = false

                    selectImageButton.visible = false
                }
            }
        }

        SettingsDelegate {
            id: imageOpacity

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 430

            width: parent.width * 0.9
            height: 100

            additionalItem: true
            valueText: "30 %"

            CustomSlider {
                id: imageOpacitySlider

                visible: false

                width: parent.width / 2
                height: 30

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40

                sliderDefaulrValue: 30

                onSliderValueChanged: {
                    backgroundImage.opacity = value / 100
                    imageOpacity.valueText = Math.round(value).toString() + "%"
                }
            }

            onClickedRound: {
                if (detailOpacity === false) {
                    detailOpacity = true
                    backgroundImage.visible = true
                    selectSound.visible = false
                    selectImage.visible = false
                    voiceSound.visible = false

                    imageOpacitySlider.visible = true
                } else {
                    detailOpacity = false
                    backgroundImage.visible = false
                    selectSound.visible = true
                    selectImage.visible = true
                    voiceSound.visible = true
                    userOpacityValue = opacityValue

                    imageOpacitySlider.visible = false
                }
            }

            buttonText: "Прозрачность изображения"
        }

        CustomButton {
            id: button

            visible: false

            text: "Мелодия будильника"

            width: parent.width / 2

            anchors.centerIn: parent

            onClick: {
                if (alarmAudio.playbackState) {
                    alarmAudio.pause()
                    button.text = "Пауза"
                }

                alarmAudio.play()
            }
        }

        Button {
            id: buttonBack

            Text {
                id: textBnt
                text: "Назад"

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: name.right
                anchors.leftMargin: 5

                font.pixelSize: 15
            }

            width: parent.width / 4
            height: 50

            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.05

            anchors.left: selectSound.left

            background: Rectangle {
                color: "transparent"
                radius: 15
            }

            Image {
                id: name
                source: "qrc:/images/chevron.png"
                rotation: 180

                width: 30
                height: 30

                anchors.left: parent.left
                anchors.leftMargin: 10

                anchors.top: parent.top
                anchors.topMargin: 10
            }

            onClicked: {
                call()
                mainForm.opacityValue = userOpacityValue
            }
        }

        Audio {
            id: alarmAudio

            onPaused: {
                playStatus = 2;
                console.log("Pause!!!!")
            }

            onPlaying: {
                playStatus = 1;
                console.log("Play!!!!")
            }

            onStopped: {
                playStatus = 0;
                console.log("Stop!!!!")
            }

            source: "qrc:/sounds/eye_of_the_tiger.mp3"
        }
    }

    states: State {
        name: "show"
        PropertyChanges {
            target: item
            width: showWidth
        }
    }

    transitions: Transition {
        NumberAnimation {
            target: item
            properties: "width"
            easing.type: Easing.OutExpo
            duration: 500
        }
    }

    Item
    {
        visible: false

        state: "hiddenVoiceSound"
        states: [
            State {
                name: "showVoiceSound"
                when: detailVoice === true
                PropertyChanges { target: voiceSound; height: 210 }
            },
            State {
                name: "hiddenVoiceSound"
                when: someswitch.checked
                PropertyChanges { target: voiceSound; height: 100 }
            }
        ]
        transitions: Transition {
             PropertyAnimation { property: "height"; duration: 300; easing.type: Easing.InOutQuad }
        }
    }

    Item
    {
        visible: false

        state: "hidden"
        states: [
            State {
                name: "shown"
                when: detailOpacity === true
                PropertyChanges { target: imageOpacity; height: 210 }
            },
            State {
                name: "hidden"
                when: someswitch.checked
                PropertyChanges { target: imageOpacity; height: 100 }
            }
        ]
        transitions: Transition {
             PropertyAnimation { property: "height"; duration: 300; easing.type: Easing.InOutQuad }
        }
    }

    Item
    {
        visible: false

        state: "hiddenSelectSound"
        states: [
            State {
                name: "shownSelectSound"
                when: detailSelectSound === true
                PropertyChanges { target: selectSound; height: 210 }
            },
            State {
                name: "hiddenSelectSound"
                when: someswitch.checked
                PropertyChanges { target: selectSound; height: 100 }
            }
        ]
        transitions: Transition {
             PropertyAnimation { property: "height"; duration: 300; easing.type: Easing.InOutQuad }
        }
    }

    Item
    {
        visible: false

        state: "hiddenSelectSound"
        states: [
            State {
                name: "shownSelectSound"
                when: detailImage === true
                PropertyChanges { target: selectImage; height: 210 }
            },
            State {
                name: "hiddenSelectSound"
                when: someswitch.checked
                PropertyChanges { target: selectImage; height: 100 }
            }
        ]
        transitions: Transition {
             PropertyAnimation { property: "height"; duration: 300; easing.type: Easing.InOutQuad }
        }
    }

    function hideButtons(stateButtons) {
        buttonSelectSound.visible = stateButtons
        buttonStop.visible = stateButtons
        buttonPlay.visible = stateButtons
    }


    focus: true // important - otherwise we'll get no key events
//    Keys.onBackPressed: {
//        call()
//        if (event.key === Qt.Key_Back) {

//        }
//    }

//    Keys.onReleased: {
//        console.log("Back button captured - wunderbar !")
//        if (event.key === Qt.Key_Back) {
//            console.log("Back button captured - wunderbar !")
//            event.accepted = true
//            call()
//        }
//    }
}
