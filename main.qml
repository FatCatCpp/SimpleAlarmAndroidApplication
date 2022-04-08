import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
//import QtQuick.VirtualKeyboard 2.4

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    color: "#F0F0F0"

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

//    MainPage {
//        id: mainPage

//        anchors.fill: parent

//        onSettingsOpen: {
//            settingsPage.state = "show"
//        }
//    }

//    SettingsPage {
//        id: settingsPage

//        state: ""

//        showWidth: parent.width
//        width: -100
//        height: parent.height

//        onVisibleFalse: {
//            mainPage.visible = true
//            settingsPage.visible = false
//        }
//    }

    MainForm {
        id: mainForm

        anchors.fill: parent
        onCall: {
            newWindow.state = "show"
        }
    }

    NewWindow {
        id: newWindow

        state: ""

        showWidth: mainWindow.width

        width: -1000
        height: parent.height

        onCall: {
            newWindow.state = ""
        }

//        anchors.fill: parent
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
