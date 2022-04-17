import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQml 2.2

Item {
    id: customButton

    width: 120
    height: 48

    property string color
    property string borderColor
    property alias text: buttonText.text
    property string textColor
    property alias iconSource: iconButton.source
    property string iconPlace: "none"
    property alias textFont: buttonText.font
    property bool active: true
    property bool orangeColor: false

    signal click()

    Button {
        id: button
        anchors.fill: parent
        onClicked: {
            if (active) {
                click()
            }
        }

        MouseArea {
            id: buttonArea
            anchors.fill: parent

            cursorShape: Qt.PointingHandCursor

            onPressed: mouse.accepted = false
        }

        background: Rectangle {
            id: background

            radius: 6

            border.color: active ? customButton.borderColor : "#23232323"
//            color: orangeColor ? (parent.down ? "#c93813" : (parent.hovered ? "#E03F16" : "#E74117")) :
//                                 (parent.down ? "#dedede" : (parent.hovered ? "#eaeaea" : "#f7f7f7"))
            color: "#32A852"
        }
    }

    Text {
        id: buttonText
        color: active ? customButton.textColor : "#23232323"

        font {
            pixelSize: 14
            bold: true
        }

        anchors {
            verticalCenter: iconPlace == "none" ? undefined : parent.verticalCenter
            left: (iconPlace == "left" || iconPlace == "none") ? undefined : parent.left
            right: (iconPlace == "right" || iconPlace == "none") ? undefined : parent.right

            leftMargin: (iconPlace == "left" || iconPlace == "none") ? undefined : 24
            rightMargin: (iconPlace == "right" || iconPlace == "none") ? undefined : 24

            centerIn: iconPlace == "none" ? parent : undefined
        }
    }

    Image {
        id: iconButton
        visible: iconPlace != "none"

        anchors {
            verticalCenter: iconPlace == "none" ? undefined : parent.verticalCenter
            right: (iconPlace == "left" || iconPlace == "none") ? undefined : parent.right
            left: (iconPlace == "right" || iconPlace == "none") ? undefined : parent.left

            rightMargin: (iconPlace == "left" || iconPlace == "none") ? undefined : 20
            leftMargin: (iconPlace == "right" || iconPlace == "none") ? undefined : 20
        }

        ColorOverlay {
            anchors.fill: iconButton
            source: iconButton
            color: "#23232323"
            visible: !active
        }
    }
}
