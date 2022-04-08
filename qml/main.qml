import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    color: "#F0F0F0"

    MainPage {
        id: mainForm

        anchors.fill: parent
        onCall: {
            newWindow.state = "show"
        }
    }

    SettingsPage {
        id: newWindow

        state: ""

        showWidth: mainWindow.width

        width: -1000
        height: parent.height

        onCall: {
            newWindow.state = ""
        }
    }
}
