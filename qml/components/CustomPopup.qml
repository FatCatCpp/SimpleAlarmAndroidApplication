import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

Item {
    property string textPopup

    Rectangle {
        id: popup

        width: parent.width / 3 * 2
        height: 40

        radius: 20

        color: "#646568"

        Text {
            id: name
            text: textPopup

            anchors.centerIn: parent

            font {
                family: "Helvetica"
                pixelSize: 14
            }

            color: "white"
        }
    }
}
