import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Item {
    id: settingsDelegate

    signal clickedRound()

    property string buttonText
    property bool additionalItem: true
    property string valueText
    property real opacityValue
    property bool isRotation: false

    height: 100

    Rectangle {
        id: area

        anchors.fill: parent

        color: "#FCFCFC"

        width: parent.width * 0.8

        radius: 30

        Text {
            id: titleText
            text: qsTr(buttonText)

            color: "#171717"
            font.pixelSize: 19

            anchors.centerIn: parent
        }

        Text {
            id: valueTextDescription
            text: qsTr(valueText)

            anchors.top: titleText.bottom
            anchors.topMargin: 5

            font.pixelSize: 15

            anchors.horizontalCenter: parent.horizontalCenter
        }

        RoundButton {
            id: buttonSelectSound

            width: 30
            height: 30

            anchors {
                right: parent.right
                rightMargin: 15
                top: parent.top
                topMargin: 35
            }

            background: Rectangle {
                color: "transparent"
            }

            Image {
                id: forward
                source: "qrc:/images/chevron_1.png"

                width: parent.width
                height: parent.height

                anchors.fill: parent
            }

            RotationAnimator {
                id: imageRotetion
                target: forward
                from: !isRotation ? 0 : 180
                to: !isRotation ? 180 : 0
                duration: 300
            }

            onClicked: {
                clickedRound()
                imageRotetion.running = true
                isRotation : !isRotation ? isRotation = true : isRotation = false
                opacityValue = opacitySlider.value / 100
            }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 6
            radius: 6
            color: "#A7A7A7"
            opacity: 0.8
        }
    }
}
