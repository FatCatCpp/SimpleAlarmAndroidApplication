import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
import QtQuick.Dialogs 1.3
import "components"

Item {
//    Rectangle {
    signal stopwatchStartPush()
    signal stopwatchStopPush()

    property bool startPauseStatus: true
    property bool stopStatus: false
        Rectangle {
            id: area

            anchors.centerIn: parent

            color: "#FCFCFC"

            width: parent.width * 0.9
            height: 100

            radius: 30

            Text {
                id: timeText

                text: qsTr("00:00.000")
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
            id: startPauseButton

            sourcePath: "qrc:/images/play.png"
            diameter: 50

            anchors {
                bottom: parent.bottom
                bottomMargin: 70

                left: parent.left
                leftMargin: 70
            }

            onClick: {
                stopwatchStartPush()
                sound.play()
                if (startPauseStatus) {
                    startPauseStatus = false
                    sourcePath: "qrc:/images/play.png"

                    stopButton.opacity = 0.4
                    stopButton.enabled = false
                } else {
                    startPauseStatus = true
                    sourcePath: "qrc:/images/pause.png"

                    stopButton.opacity = 1
                    stopButton.enabled = true
                }
            }
        }
        CustomRoundButton {
            id: stopButton

            sourcePath: "qrc:/images/stop.png"
            diameter: 50

            opacity: 0.4
            enabled: false

            anchors {
                bottom: parent.bottom
                bottomMargin: 70

                right: parent.right
                rightMargin: 70
            }

            onClick: {
                stopwatchStopPush()
                sound.stop()
                if (stopStatus) {
                    opacity = 0.4
                    enabled = false
                    stopStatus = true
                } else {
                    opacity = 1
                    enabled = true
                    stopStatus = false
                }
            }
        }

        Connections {
            target: Controller

            onGoStopwatch: {
                timeText.text = timeString
            }
        }

        SoundEffect {
            id: sound
            source: "qrc:/sounds/stopwatchEffect.wav"
        }

//    }
}
