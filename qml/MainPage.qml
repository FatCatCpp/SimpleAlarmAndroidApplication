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
    property bool switchState: false

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
            height: 150

            buttonVisible: false

            Text {
                id: alarmText

                text: "12:34"
                font {
                    pixelSize: 35
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
                } else {
                    cornerRound = true

                    alarmText.visible = true
                    tumblerHours.visible = false
                    tumblerMinutes.visible = false
                }
            }

            CustomSwitch {
                id: everyDaySwitch

                on: false

                switchWidth: 60
                switchHeight: 30

                anchors {
                    top: parent.top
                    topMargin: 30

                    left: parent.left
                    leftMargin: 30
                }

                onSwitchCheckedChanged: {
                    switchState = stateSwitch
                }
            }

            state: "hidden"
            states: [
                State {
                    name: "shown"
                    when: switchState
                    PropertyChanges { target: alarmDelegate; height: parent.height }
                    PropertyChanges { target: alarmDelegate; width: parent.width }
                },
                State {
                    name: "hidden"
                    when: !switchState
                    PropertyChanges { target: alarmDelegate; height: 150 }
                    PropertyChanges { target: alarmDelegate; width: parent.width * 0.9 }
                }
            ]
            transitions: Transition {
                 PropertyAnimation { property: "height"; duration: 250; easing.type: Easing.InOutQuad }
            }
        }

        Tumbler {
            id: tumblerHours

            model: Controller.createHours()

            font.pixelSize: 30

            visible: switchState

            width: 30
            height: mainWnd.height / 2

            spacing: 25

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

            visible: switchState

            width: 30
            height: mainWnd.height / 2

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
//                TokenManager.writeReport(filePath)
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
