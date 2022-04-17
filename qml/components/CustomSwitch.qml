import QtQuick 2.0

Item {
    id: customSwitch
    width: background.width; height: background.height

    property bool on: false

    property int switchWidth
    property int switchHeight

    function toggle() {
        if (customSwitch.state == "on")
            customSwitch.state = "off"
        else
            customSwitch.state = "on"
    }

    function releaseSwitch() {
        if (knob.x == 0) {
            if (customSwitch.state == "off")
                return
        }
        if (knob.x == background.width - knob.width) {
            if (customSwitch.state == "on")
                return
        }

        toggle();
    }

    Image {
        id: background
        source: "qrc:/images/backgroundSwitch.png"

        width: switchWidth
        height: switchHeight

        opacity: customSwitch.state == "on" ? 1 : 0.2

        MouseArea {
            anchors.fill: parent
            onClicked: toggle()
        }
    }

    Image {
        id: knob

        x: switchHeight * 0.1
        y: switchHeight * 0.1

        source: "qrc:/images/knob.png"

        width: switchHeight * 0.8
        height: switchHeight * 0.8

        MouseArea {
            anchors.fill: parent

            drag.target: knob
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: background.width - knob.width

            onClicked: toggle()
            onReleased: releaseSwitch()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: background.width - knob.width * 1.1 }
            PropertyChanges { target: customSwitch; on: true }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: knob.width * 0.1 }
            PropertyChanges { target: customSwitch; on: false }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }
}
