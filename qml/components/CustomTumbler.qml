import QtQuick 2.0
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.5

Item {
    property bool tumblerVisible
    property int indexCurrent
//    property alias tumblerModel

    signal tumblerValueChange(int newValue)

    Tumbler {
        id: tumblerHours

//        model: tumblerModel/*Controller.createHours()*/

        font.pixelSize: 30

        visible: tumblerVisible

        width: 30
        height: parent.height / 2

        spacing: 25

        currentIndex: indexCurrent

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: -1 * ((parent.width / 3) / 3 * 2)

            y: tumblerHours.height * 0.4
            width: parent.width * 0.8
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
            anchors.leftMargin: -1 * ((parent.width / 3) / 3 * 2)

            y: tumblerHours.height * 0.6
            width: parent.width * 0.8
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
            tumblerValueChange(currentIndex)
//            sound.play()
        }
    }
}
