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

        property int tripleWidth: width * 3

        background: Rectangle {
            color: "transparent"

            clip: true

            Rectangle {
                id: ripple
                property int diameter: 0
                property int pressX: 0
                property int pressY: 0

                x: pressX - radius
                y: pressY - radius

                color: "#E5E5E5"
                radius: diameter / 2
                width: diameter
                height: diameter


                opacity: 1 - diameter / roundButton.tripleWidth

                function animate(x, y, size) {
                    pressX = x
                    pressY = y
                    diameter = size
                }

                Behavior on diameter {
                    PropertyAnimation {
                        duration: 200
                        onRunningChanged: {
                            if(!running) {
                                duration = 0;
                                ripple.diameter = 0;
                                duration = 200;
                            }
                        }
                    }
                }
            }
        }

        Image {
            id: forward
            source: sourcePath

            width: (diameter / 3) * 2/*parent.width*/
            height: (diameter / 3) * 2/*parent.height*/

            anchors.centerIn: parent

            opacity: parent.down ? 0.5 : (parent.hovered ? 0.7 : 1)
        }

        onClicked: {
            click()
            ripple.animate(pressX, pressY, roundButton.tripleWidth)
        }

        MouseArea {
            id: buttonArea

            anchors.fill: parent

            onPressed: mouse.accepted = false
        }
    }
}
