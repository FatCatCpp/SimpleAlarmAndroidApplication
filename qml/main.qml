import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

ApplicationWindow {
    id: mainWindow

    visible: true

    color: "#F0F0F0"

    MainPage {
        id: mainPage

        anchors.fill: parent
        onCall: {
            settingsPage.state = "show"
        }
    }

    SettingsPage {
        id: settingsPage

        state: ""

        showWidth: mainWindow.width

        width: -1000
        height: parent.height

        onCall: {
            settingsPage.state = ""
            mainPage.opacityValue = picOpacity
        }
    }
}
