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

    property bool isRotation: false

    height: 100

    Rectangle {
        id: area

        anchors.fill: parent

        color: "#FCFCFC"

        width: parent.width * 0.8
//        height: 100

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
//            visible: textDelegate

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
            }
        }

        Slider {
            id: opacitySlider

            width: parent.width / 2

            visible: additionalItem === true

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 130

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

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 6
            radius: 6
            color: "#171717"
            opacity: 0.8
        }
    }
}
