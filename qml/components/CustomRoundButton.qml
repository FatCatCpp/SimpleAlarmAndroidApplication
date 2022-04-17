import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: layout

    property int diameter: 30
    property string sourcePath

    width: diameter
    height: diameter

    signal click()

    RoundButton {
        id: roundButton

        width: diameter
        height: diameter

        background: Rectangle {
            color: "transparent"
        }

        Image {
            id: forward
            source: sourcePath

            width: parent.width
            height: parent.height

            anchors.fill: parent
        }

        onClicked: {
            click()
        }
    }
}
