import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
import QtQuick.Dialogs 1.3
import "components"

Item {
    signal stopwatchStartRestartPush()
    signal stopwatchStopPush()
    signal stopwatchPausePush()

    property bool startPauseStatus: true
    property bool stopStatus: false
    property bool volumeStatus: false

    Rectangle {
        id: area

        anchors.centerIn: parent

        color: "#FCFCFC"

        width: parent.width * 0.9
        height: 100

        radius: 30

        Text {
            id: timeText

            text: qsTr("00:00:00.00")
            anchors.centerIn: parent
            font.pixelSize: 30
        }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 6
            radius: 6
            color: "#A7A7A7"
            opacity: 0.8
        }
    }

    CustomRoundButton {
        id: volumeOnOff

        sourcePath: "qrc:/images/muteOn.png"
        diameter: 45

        anchors {
            top: parent.top
            topMargin: 30

            right: parent.right
            rightMargin: 30
        }

        onClick: {
            if (volumeStatus) {
                sound.muted = true
                volumeOnOff.sourcePath = "qrc:/images/muteOn.png"
                volumeStatus = false
            } else {
                sound.muted = false
                volumeStatus = true
                volumeOnOff.sourcePath = "qrc:/images/muteOff.png"
            }
        }
    }

    CustomRoundButton {
        id: startPauseButton

        sourcePath: "qrc:/images/play.png"
        diameter: 75

        z: 2

        state: ""
        x: parent.width / 2 - width / 2
        y: 7 * (parent.height / 8) - height / 2

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.OutExpo; duration: 700 }
        }

        states: State {
            name: "playButton"

            PropertyChanges {
                target: startPauseButton
                x: parent.width / 4 - width / 2
            }
        }

        onClick: {
            startPauseButton.state = "playButton"
            stopButton.state = "stopButton"

            sourcePath = startPauseStatus ? "qrc:/images/pause.png" : "qrc:/images/play.png"
            stopButton.opacity = startPauseStatus ? 0.4 : 1
            stopButton.enabled = startPauseStatus ? false : true

            stopwatchStartRestartPush()

            if (startPauseStatus) {
                sound.play()
            } else {
                sound.stop()
            }

            startPauseStatus = startPauseStatus ? false : true
        }
    }

    CustomRoundButton {
        id: stopButton

        sourcePath: "qrc:/images/stop.png"
        diameter: 75

        opacity: 0.4
        enabled: false

        state: ""
        x: parent.width / 2 - width / 2
        y: 7 * (parent.height / 8) - height / 2

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.OutExpo; duration: 700 }
        }

        states: State {
            name: "stopButton"

            PropertyChanges {
                target: stopButton
                x: 3 * (parent.width / 4) - width / 2
            }
        }

        onClick: {
            stopwatchStopPush()
            sound.stop()

            startPauseButton.state = ""
            stopButton.state = ""

            opacity = stopStatus ? 0.4 : 1
            enabled = stopStatus ? false : true
            stopStatus = stopStatus ? true : false
            startPauseStatus = stopStatus ? false : true
        }
    }

    Connections {
        target: Controller

        onGoStopwatch: {
            timeText.text = timeString
        }
    }

    Connections {
        target: Controller

        onStopwatchPause: {
//                timerStop
        }
    }

    SoundEffect {
        id: sound
        source: "qrc:/sounds/stopwatchEffect.wav"
        loops: 3000
        muted: true
    }
}
