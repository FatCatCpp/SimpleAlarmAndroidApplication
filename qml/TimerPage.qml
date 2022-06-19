import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
import QtQuick.Dialogs 1.3
import "components"

Item {
    property bool tumblersVisible: true

    property int timerHours: 0
    property int timerMinutes: 0
    property int timerSeconds: 0

    property int rotationCounter: 0
    property int timerSecondsDuration: 0

    property bool volumeStatus: false
    property bool timerStatus: false

    signal startTimer(int hour, int min, int sec)
    signal stopTimer()

    Rectangle {
        id: area

        anchors.centerIn: parent

        color: "#FCFCFC"

        width: parent.width * 0.9
        height: 100

        radius: 30

        visible: !tumblersVisible

        Text {
            id: timeText

            text: qsTr("00:00:23")
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

        opacity: checkTimeZero() ? 0.3 : 1
        enabled: !checkTimeZero()

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
            if (checkTimeZero()) {
                return
            }

            startPauseButton.state = "playButton"
            stopButton.state = "stopButton"

            if (!timerStatus) {
                timerStatus = true

                startTimer(tumblerHours.currentIndex, tumblerMinutes.currentIndex, tumblerSeconds.currentIndex)

                timeText.text = setTimerText(tumblerHours.currentIndex, tumblerMinutes.currentIndex, tumblerSeconds.currentIndex)
                timerSecondsDuration = createtimerDuration()

                tumblersVisible = false
                signalTimer.running = true
                progress.visible = true

                soundTimer.play()
                soundTimer.muted = true

                startPauseButton.sourcePath = "qrc:/images/pause.png"
            } else {
                timerStatus = false
                startPauseButton.sourcePath = "qrc:/images/play.png"
            }
        }
    }

    CustomRoundButton {
        id: stopButton

        sourcePath: "qrc:/images/stop.png"
        diameter: 50

        opacity: checkTimeZero() ? 0 : 1
        enabled: !checkTimeZero()

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
            startPauseButton.state = ""
            stopButton.state = ""
            audio.stop()

            tumblerHours.currentIndex = tumblerMinutes.currentIndex = tumblerSeconds.currentIndex = 0

            progress.value = 0
            progress.visible = false
            tumblersVisible = true

            startPauseButton.sourcePath = "qrc:/images/play.png"

            stopTimer()
        }
    }

    Tumbler {
        id: tumblerHours

        model: Controller.createHours()

        font.pixelSize: 30

        visible: tumblersVisible

        width: 30
        height: parent.height / 2

        spacing: 25

        currentIndex: timerHours

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: -60

            y: tumblerHours.height * 0.4
            width: area.width
            height: 1

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(300, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#05EDFE" }
                    GradientStop { position: 1.0; color: "#2E9BFE" }
                }
            }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: -60

            y: tumblerHours.height * 0.6
            width: area.width
            height: 1

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(300, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#05EDFE" }
                    GradientStop { position: 1.0; color: "#2E9BFE" }
                }
            }
        }

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 5

        onCurrentIndexChanged: {
            sound.play()
        }
    }

    Tumbler {
        id: tumblerMinutes

        model: Controller.createMinutes()

        font.pixelSize: 30

        visible: tumblersVisible

        width: 30
        height: parent.height / 2

        currentIndex: timerMinutes

        anchors.top: tumblerHours.top
        anchors.left: tumblerHours.right
        anchors.leftMargin: parent.width / 5

        onCurrentIndexChanged: {
            sound.play()
        }
    }

    Tumbler {
        id: tumblerSeconds

        model: Controller.createMinutes()

        font.pixelSize: 30

        visible: tumblersVisible

        width: 30
        height: parent.height / 2

        currentIndex: timerSeconds

        anchors.top: tumblerMinutes.top
        anchors.left: tumblerMinutes.right
        anchors.leftMargin: parent.width / 5

        onCurrentIndexChanged: {
            sound.play()
        }
    }

    CustomProgressBar {
        id: progress

        visible: false

        radius: parent.width
        lineWidth: 7
        rotationOK: true
        value: 0
        textProgress: ""

        anchors.centerIn: parent
    }

    CustomRoundButton {
        id: volumeOnOff

        sourcePath: "qrc:/images/muteOn.png"
        diameter: 30

        anchors {
            top: parent.top
            topMargin: 30

            right: parent.right
            rightMargin: 30
        }

        onClick: {
            if (volumeStatus) {
                volumeStatus = false
                soundTimer.muted = true
                volumeOnOff.sourcePath = "qrc:/images/muteOn.png"
            } else {
                volumeStatus = true
                soundTimer.muted = false
                volumeOnOff.sourcePath = "qrc:/images/muteOff.png"
            }
        }
    }

    Timer {
        id: signalTimer

        interval: 50
        repeat: true
        running: false

        onTriggered: {
            rotationCounter = rotationCounter + 1
            progress.value = rotationCounter / (1. * timerSecondsDuration)

            if (rotationCounter === timerSecondsDuration) {
                rotationCounter = 0

                area.border.color = "red"
                area.border.width = 7

                repeat = false
                running = false

                progress.visible = false

                soundTimer.stop()
                startPauseButton.sourcePath = "qrc:/images/play.png"
            }
        }
    }

    function calcTimerStep(hms) {
        var listValues = hms.split(':')
        return parseInt(listValues[0] * 3600) + parseInt(listValues[1] * 60) + parseInt(listValues[2])
    }

    function setTimerText(h, m, s) {
        var colonString = ":"
        var zeroString = "0"

        var hourString = tumblerHours.currentIndex.toString()
        var minutesString = tumblerMinutes.currentIndex.toString()
        var secondsString = tumblerSeconds.currentIndex.toString()

        if (tumblerHours.currentIndex < 10) {
            hourString = zeroString + hourString
        }
        if (tumblerMinutes.currentIndex < 10) {
            minutesString = zeroString + minutesString
        }
        if (tumblerSeconds.currentIndex < 10) {
            secondsString = zeroString + secondsString
        }

        return hourString + colonString + minutesString + colonString + secondsString
    }

    function checkTimeZero() {
        return tumblerHours.currentIndex === 0 &&
               tumblerMinutes.currentIndex === 0 &&
               tumblerSeconds.currentIndex === 0
    }

    function createtimerDuration() {
        return timerSecondsDuration = 20 * calcTimerStep(timeText.text)
    }

    SoundEffect {
        id: sound
        source: "qrc:/sounds/tumblerEffect.wav"
    }

    SoundEffect {
        id: soundTimer
        source: "qrc:/sounds/stopwatchEffect.wav"
        loops: 3000
    }

    Audio {
        id: audio
        source: "qrc:/sounds/timerAlarm.wav"
    }

    Connections {
        target: Controller

        onGoTimer: {
            timeText.text = timeString
        }
    }

    Connections {
        target: Controller

        onTimerFinished: {
            audio.play()
        }
    }
}
