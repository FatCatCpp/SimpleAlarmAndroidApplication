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

    Rectangle {
        x: 30

        anchors.fill: parent
        color: "#F0F0F0"

        Image {
            id: backgroundImage

            source: "qrc:/images/basic.png"

            width: parent.width
            height: parent.height

            anchors.fill: parent

            opacity: opacityValue
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
        }

//        Switch {
//            id: everyDaySwitch

//            checked: true

//            indicator: Rectangle {
//                implicitWidth: 48
//                implicitHeight: 26
//                x: everyDaySwitch.leftPadding
//                y: parent.height / 2 - height / 2
//                radius: 13
//                color: everyDaySwitch.checked ? "#05EDFE" : "#ffffff"
//                border.color: everyDaySwitch.checked ? "#cccccc" : "#cccccc"

//                Rectangle {
//                    x: everyDaySwitch.checked ? parent.width - width : 0
//                    width: 26
//                    height: 26
//                    radius: 13
//                    color: everyDaySwitch.down ? "#cccccc" : "#ffffff"
//                    border.color: everyDaySwitch.checked ? (everyDaySwitch.down ? "#999999" : "#999999") : "#999999"
//                }
//            }

//            contentItem: Text {
//                text: everyDaySwitch.text
//                font: everyDaySwitch.font
//                opacity: enabled ? 1.0 : 0.3
//                color: everyDaySwitch.down ? "#05EDFE" : "#21be2b"
//                verticalAlignment: Text.AlignVCenter
//                leftPadding: everyDaySwitch.indicator.width + everyDaySwitch.spacing
//            }

//            anchors {
//                top: parent.top
//                topMargin: 30

//                left: parent.left
//                leftMargin: 30
//            }

//            onCheckedChanged: {
//                alarmAudio.play()
//            }
//        }

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

            onCurrentIndexChanged: {
                sound.play()
            }
        }

        Tumbler {
            id: tumblerMinutes

            model: Controller.createMinutes()

            font.pixelSize: 30

            width: 30

            anchors.top: tumblerHours.top
            anchors.left: tumblerHours.right
            anchors.leftMargin: 20

            onCurrentIndexChanged: {
                sound.play()
            }
        }

        Button {
            id: settingsButton

            onClicked: {
                call()
//                fileDialog.open()
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

        Slider {
            id: opacitySlider

            visible: false

            width: parent.width / 2

            anchors.top: parent.top
            anchors.topMargin: 100

            anchors.left: parent.left
            anchors.leftMargin: 50

            background: Rectangle {
                x: opacitySlider.leftPadding
                y: opacitySlider.topPadding + opacitySlider.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 12
                width: opacitySlider.availableWidth
                height: implicitHeight
                radius: 2
                color: "#bdbebf"

                Rectangle {
                    width: opacitySlider.visualPosition * parent.width
                    height: parent.height
                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(0, 0)
                        end: Qt.point(300, 0)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#05EDFE" }
                            GradientStop { position: 1.0; color: "#2E9BFE" }
                        }
                    }
                    radius: 4
                }
            }

            handle: Rectangle {
                x: opacitySlider.leftPadding + opacitySlider.visualPosition *
                   (opacitySlider.availableWidth - width)
                y: opacitySlider.topPadding + opacitySlider.availableHeight / 2 - height / 2
                implicitWidth: 26
                implicitHeight: 26
                radius: 13
                color: opacitySlider.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }

            from: 1
            value: 30
            to: 100

            onValueChanged: {
                backgroundImage.opacity = value / 100
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
