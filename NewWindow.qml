import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Item {
    id: item

    signal call()
    property int showWidth

    property bool her: false

    Rectangle {
        x: -400

        anchors.fill: parent
        color: "#F0F0F0"
//        color: "transparent"

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

            textDelegate: true
            valueText: "eye_of_the_tiger"

            buttonText: "Мелодия будильника"
        }

        SettingsDelegate {
            id: voiceSound

            width: parent.width * 0.9
            height: 100

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 210

            textDelegate: false

            buttonText: "Громкость звонка"
        }

        SettingsDelegate {
            id: selectImage

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 320

            width: parent.width * 0.9
            height: 100

            textDelegate: false

            buttonText: "Фоновое изображение"
        }

        SettingsDelegate {
            id: imageOpacity

            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left

            anchors.top: parent.top
            anchors.topMargin: 430

            width: parent.width * 0.9
            height: 100

            textDelegate: false

            onClickedRound: {
                if (her === false) {
                    her = true
                } else {
                    her = false
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
                color: "#FCFCFC"
                radius: 15
            }

            Image {
                id: name
                source: "qrc:/images/chevron_1.png"
                rotation: 180

                width: 30
                height: 30

                anchors.left: parent.left
                anchors.leftMargin: 10

                anchors.top: parent.top
                anchors.topMargin: 10
            }

            onClicked: call()
        }

        Audio {
            id: alarmAudio

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

    CheckBox {
        text: "hide/show"
        id: someswitch
        x: 10
        y: 10

        checked: true

        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 2



        state: "hidden"
        states: [
            State {
                name: "shown"
                when: her === true
                PropertyChanges { target: imageOpacity; height: 200 }
            },
            State {
                name: "hidden"
                when: someswitch.checked
                PropertyChanges { target: imageOpacity; height: 100 }
            }
        ]
        transitions: Transition {
             PropertyAnimation { property: "height"; duration: 500; easing.type: Easing.InOutQuad }
        }
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
