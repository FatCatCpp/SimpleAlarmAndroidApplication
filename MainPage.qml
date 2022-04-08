import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Item {
    signal settingsOpen()

    Switch {
        id: everyDaySwitch

        checked: true

        indicator: Rectangle {
            implicitWidth: 48
            implicitHeight: 26
            x: everyDaySwitch.leftPadding
            y: parent.height / 2 - height / 2
            radius: 13
            color: everyDaySwitch.checked ? "#17a81a" : "#ffffff"
            border.color: everyDaySwitch.checked ? "#17a81a" : "#cccccc"

            Rectangle {
                x: everyDaySwitch.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: everyDaySwitch.down ? "#cccccc" : "#ffffff"
                border.color: everyDaySwitch.checked ? (everyDaySwitch.down ? "#17a81a" : "#21be2b") : "#999999"
            }
        }

        contentItem: Text {
            text: everyDaySwitch.text
            font: everyDaySwitch.font
            opacity: enabled ? 1.0 : 0.3
            color: everyDaySwitch.down ? "#17a81a" : "#21be2b"
            verticalAlignment: Text.AlignVCenter
//            leftPadding: everyDaySwitch.indicator.width + everyDaySwitch.spacing
        }

        anchors {
            top: parent.top
            topMargin: 30

            left: parent.left
            leftMargin: 30
        }

        onCheckedChanged: {
            alarmAudio.play()
        }
    }

    Audio {
        id: alarmAudio

        source: "qrc:/sounds/eye_of_the_tiger.wav"
    }

    Tumbler {
        id: tumblerHours

        model: Controller.createHours()

        font.pixelSize: 30

        width: 30

        anchors.top: parent.top
        anchors.topMargin: parent.height / 3
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - 2 * width - 30) / 2
    }

    Tumbler {
        id: tumblerMinutes

        model: Controller.createMinutes()

        font.pixelSize: 30

        width: 30

        anchors.top: tumblerHours.top
        anchors.left: tumblerHours.right
        anchors.leftMargin: 20

        SoundEffect {
            id: sound
            source: "qrc:/sounds/slash-21834.wav"
//            volume:
        }

        onCurrentIndexChanged: {
            sound.play()
        }
    }

    Button {
        id: settingsButton

        onClicked: {
            settingsOpen()
//            activationWindow.state = "showAuthWindow"
        }

        width: 30
        height: 30

        Image {
            source: "qrc:/images/settings.png"
            anchors.fill: parent
        }

        opacity: settingsButton.down ? 0.8 : (settingsButton.hovered ? 0.9 : 1)

        anchors {
            right: parent.right
            rightMargin: 30

            top: parent.top
            topMargin: 30
        }

        background: Rectangle {
            color: "transparent"
        }

        MouseArea {
            id: buttonArea
            anchors.fill: parent

            cursorShape: Qt.PointingHandCursor

            onPressed: mouse.accepted = false
        }
    }

//    states: State {
//        name: "show"
//        PropertyChanges {
//            target: settingsPage
//            width: showWidth
//        }
//    }

//    transitions: Transition {
//        NumberAnimation {
//            target: settingsPage
//            properties: "width"
//            easing.type: Easing.OutExpo
//            duration: 500
//        }
//    }
}
