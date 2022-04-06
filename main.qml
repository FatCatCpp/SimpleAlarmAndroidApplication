import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
//import QtQuick.VirtualKeyboard 2.4

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    color: "#F0F0F0"


//    Text {
//        id: text
//        text: qsTr("Мелкая и Каська - \nкоты-засранцы!!!")
//        anchors.top: parent.top
//        anchors.topMargin: 20
//        font.pixelSize: 32
//    }

    Image {
        id: backgroundImage

        source: "qrc:/images/test.png"

        width: parent.width
        height: parent.height

        anchors.fill: parent

        opacity: 0.3
    }

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
            leftPadding: everyDaySwitch.indicator.width + everyDaySwitch.spacing
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

    /*---------------Image {
        id: settingsButton

        source: "qrc:/images/settings.png"

        width: 30
        height: 30

        anchors {
            right: parent.right
            rightMargin: 30

            top: parent.top
            topMargin: 30
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                settingsButton.opacity = 0.5
                settingsPage.visible = true
            }
            onReleased:  {
                settingsButton.opacity = 1
            }
        }
    } ------------------*/

    Button {
        id: settingsButton

        onClicked: {
            settingsScreen.state = "show"
        }
            /*settings()*/

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

//    Component {
//        id: delegateComponent

//        Label {
//            text: formatText(Tumbler.tumbler.count, modelData)
//            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            font.pixelSize: fontMetrics.font.pixelSize * 1.25
//        }
//    }

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

    SettingsPage {
        id: settingsPage

        showWidth: parent.width - 240
        width: 0

        state: ""

//        x: -2000

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.OutExpo; duration: 300 }
        }

        states: State {
            name: "settingsPage"

            PropertyChanges {
                target: settingsPage
                x: settingsPage.width
            }
        }
    }



//    /*Custom*/Button {
//        id: button

//        width: parent.width / 3 * 2
////        height: 50

//        anchors.top: tumbler.bottom
//        anchors.left: tumbler.left
//        anchors.topMargin: 40
//        anchors.leftMargin: (parent.width - width) / 2

//        text: "Создать уведомление"

//        onClicked: NotificationClient.notification = "User is happy!"
//    }






//    Rectangle {
//        width: parent.width
//        height: parent.height
//        color: "green"

//        Column {
//            anchors.fill: parent
//            spacing: (height - happyButton.height - sadButton.height - title.height) / 3

//            Text {
//                id: title
//                color: "black"
//                font.pixelSize: parent.width / 20
//                text: "How are you feeling?"
//                width: parent.width
//                horizontalAlignment: Text.AlignHCenter
//            }

//            Image {
//                id: happyButton
//                height: parent.height / 5
//                fillMode: Image.PreserveAspectFit
//                source: "./images/happy.png"
//                anchors.horizontalCenter: parent.horizontalCenter
//                smooth: true

//                Behavior on scale {
//                    PropertyAnimation {
//                        duration: 100
//                    }
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: notificationClient.notification = "User is happy!"
//                    onPressed: happyButton.scale = 0.9
//                    onReleased: happyButton.scale = 1.0
//                }
//            }

//            Image {
//                id: sadButton
//                height: parent.height / 5
//                fillMode: Image.PreserveAspectFit
//                source: "./images/sad.png"
//                anchors.horizontalCenter: parent.horizontalCenter
//                smooth: true

//                Behavior on scale {
//                    PropertyAnimation {
//                        duration: 100
//                    }
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: notificationClient.notification = "User is sad :("
//                    onPressed: sadButton.scale = 0.9
//                    onReleased: sadButton.scale = 1.0
//                }
//            }
//        }
//    }

//    InputPanel {
//        id: inputPanel
//        z: 99
//        x: 0
//        y: window.height
//        width: window.width

//        states: State {
//            name: "visible"
//            when: inputPanel.active
//            PropertyChanges {
//                target: inputPanel
//                y: window.height - inputPanel.height
//            }
//        }
//        transitions: Transition {
//            from: ""
//            to: "visible"
//            reversible: true
//            ParallelAnimation {
//                NumberAnimation {
//                    properties: "y"
//                    duration: 250
//                    easing.type: Easing.InOutQuad
//                }
//            }
//        }
//    }

//    Rectangle {
//        id: mainRect

//        color: red
//    }
}
