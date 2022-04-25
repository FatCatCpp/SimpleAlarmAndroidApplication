import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

Rectangle {
    id: customSlider

    signal sliderValueChanged(int value)
    property int sliderDefaulrValue: 30

    Slider {
        id: opacitySlider

        background: Rectangle {
            x: opacitySlider.leftPadding
            y: opacitySlider.topPadding + opacitySlider.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 24/*12*/
            width: opacitySlider.availableWidth
            height: implicitHeight
            radius: 12/*2*/
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
                radius: 4/*4*/
            }
        }

        handle: Rectangle {
            x: opacitySlider.leftPadding + opacitySlider.visualPosition *
               (opacitySlider.availableWidth - width)
            y: opacitySlider.topPadding + opacitySlider.availableHeight / 2 - height / 2
            implicitWidth: 20/*26*/
            implicitHeight: 20/*26*/
            radius: 10/*13*/
            color: opacitySlider.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
        }

        from: 1
        value: sliderDefaulrValue
        to: 100

        onValueChanged: {
            sliderValueChanged(value)
        }
    }
}
