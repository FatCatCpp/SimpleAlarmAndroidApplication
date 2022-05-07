import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
import QtQuick.Dialogs 1.3
import "components"

Item {
    id: mainWnd

    signal call()
    property int showWidth
    property real opacityValue: 0.3
    property bool alarmFullView: false
    property bool alarmSet: false

    property int alarmHours: 12
    property int alarmMinutes: 59

    property string her

    Rectangle {
        x: 30

        anchors.fill: parent
        color: "#F0F0F0"

        radius: 30

        Image {
            id: backgroundImage

            source: "qrc:/images/basic.png"

            width: parent.width
            height: parent.height

            anchors.fill: parent

            opacity: opacityValue
        }

        Audio {
            id: alarmAudio

            source: "qrc:/sounds/eye_of_the_tiger.wav"
        }

        SettingsDelegate {
            id: alarmDelegate

            width: parent.width * 0.9
            height: parent.height * 0.12

            buttonVisible: false

            Text {
                id: alarmText

                text: alarmHours.toString() + ":" + alarmMinutes.toString()
                font {
                    pixelSize: 25
                    family: "Helvetica"
                }

                opacity: 0.4

                anchors.centerIn: parent
            }

            anchors.centerIn: parent

            onStateChanged: {
                if (state === "shown") {
                    cornerRound = false

                    alarmText.visible = false
                    tumblerHours.visible = true
                    tumblerMinutes.visible = true

                    alarmSet = false
                } else {
                    cornerRound = true

                    alarmText.visible = true
                    tumblerHours.visible = false
                    tumblerMinutes.visible = false
                }
            }

            state: "hidden"
            states: [
                State {
                    name: "shown"
                    when: alarmFullView
                    PropertyChanges { target: alarmDelegate; height: parent.height }
                    PropertyChanges { target: alarmDelegate; width: parent.width }
                },
                State {
                    name: "hidden"
                    when: !alarmFullView
                    PropertyChanges { target: alarmDelegate; height: parent.height * 0.12 }
                    PropertyChanges { target: alarmDelegate; width: parent.width * 0.9 }
                }
            ]
            transitions: Transition {
                 PropertyAnimation { property: "height"; duration: 250; easing.type: Easing.InOutQuad }
            }

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (alarmFullView === false)
                        alarmFullView = true
                }
            }

            CustomRoundButton {
                id: cancelAlarmButton

                diameter: 30

                sourcePath: "qrc:/images/cancel.png"

                visible: alarmFullView

                anchors {
                    left: parent.left
                    leftMargin: 30

                    top: parent.top
                    topMargin: 30
                }

                onClick: {
                    alarmFullView = false
                }
            }

            CustomRoundButton {
                id: applyAlarmButton

                diameter: 30

                sourcePath: "qrc:/images/check.png"

                visible: alarmFullView

                anchors {
                    right: parent.right
                    rightMargin: 30

                    top: parent.top
                    topMargin: 30
                }

                onClick: {
                    alarmSet = true
                    alarmFullView = false

                    alarmHours = tumblerHours.currentIndex
                    alarmMinutes = tumblerMinutes.currentIndex

                    everyDaySwitch.on = true
                    everyDaySwitch.state = "on"
                }
            }
        }

        CustomSwitch {
            id: everyDaySwitch

            on: false

            visible: !alarmFullView

            switchWidth: 45
            switchHeight: 20

            anchors {
                verticalCenter: parent.verticalCenter

                left: parent.left
                leftMargin: 30
            }

            onSwitchCheckedChanged: {
                stateSwitch ? alarmText.opacity = 1 : alarmText.opacity = 0.4
                alarmSet = true
            }
        }

//        CustomTumbler {
//            id: tumblerHours

//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: parent.width / 3

//            tumblerVisible: alarmFullView

//            tumblerModel: Controller.createHours()
//        }

        Tumbler {
            id: tumblerHours

            model: Controller.createHours()

            font.pixelSize: 30

            visible: alarmFullView

            width: 30
            height: mainWnd.height / 2

            spacing: 25

            currentIndex: alarmHours

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: -1 * ((alarmDelegate.width / 3) / 3 * 2)

                y: tumblerHours.height * 0.4
                width: alarmDelegate.width * 0.8
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
                anchors.leftMargin: -1 * ((alarmDelegate.width / 3) / 3 * 2)

                y: tumblerHours.height * 0.6
                width: alarmDelegate.width * 0.8
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
            anchors.leftMargin: parent.width / 3

            onCurrentIndexChanged: {
                sound.play()
            }
        }

        Tumbler {
            id: tumblerMinutes

            model: Controller.createMinutes()

            font.pixelSize: 30

            visible: alarmFullView

            width: 30
            height: mainWnd.height / 2

            currentIndex: alarmMinutes

            anchors.top: tumblerHours.top
            anchors.left: tumblerHours.right
            anchors.leftMargin: parent.width / 5

            onCurrentIndexChanged: {
                sound.play()
            }
        }

        CustomRoundButton {
            id: settingsButton

            diameter: 30

            sourcePath: "qrc:/images/settings.png"

            visible: !alarmFullView

            anchors {
                right: parent.right
                rightMargin: 30

                top: parent.top
                topMargin: 30
            }

            onClick: {
                call()
//                fileDialog.open() // TODO: temp
            }
        }

        CustomPopup {
            id: popupMessage

//            width: parent.width / 3 * 2

            anchors.horizontalCenter: parent.horizontalCenter

            opacity: 0

            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.8
//            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 70

            textPopup: "Будильник установлен"


            OpacityAnimator {
                target: popupMessage
                from: 0;
                to: 1;
                duration: 300
                running: alarmSet === true

                onStopped: {
                    timer.start()
                }
            }
        }

        Timer {
            id: timer

            interval: 3000; running: true;

            onTriggered: {
                popupMessage.opacity = 0
            }
        }

        SoundEffect {
            id: sound
            source: "qrc:/sounds/slash-21834.wav"
//            volume:
        }

        FileDialog {
            id: fileDialog

            nameFilters: ["Text files (*.txt)", "All files (*)"]
            selectExisting: false

            title: "Пожалуйста, выберите папку для сохранения отчёта"

            folder: shortcuts.pictures
            onAccepted: {
                var filePath = fileDialog.fileUrl.toString().replace("file:///", "")
            }
            onRejected: {
                console.log("Canceled")
            }
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
}
