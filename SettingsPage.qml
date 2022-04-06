import QtQuick 2.0

Item {
    property int showWidth

    states: State {
            name: "show"
            PropertyChanges {
                target: settings
                width: showWidth
            }
        }

        transitions: Transition {
            NumberAnimation {
                target: settings
                properties: "width"
                easing.type: Easing.OutExpo
                duration: 500
            }
        }
}
