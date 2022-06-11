import QtQuick 2.9

Item {
    id: root

    property int radius: 125
    property int lineWidth: 3
    property real value: 0

    property color foregroundColor: "#2E9BFE"
    property color backgroundColor: "#05EDFE"

    property int animationDuration: 100

    property string textProgress: ""
    property bool rotationOK: false

    width: radius
    height: radius

    onValueChanged: {
        canvas.degree = value * 360;
    }

    Text {
        id: txt
        text: textProgress

        anchors {
            top: parent.bottom
            left: parent.left

            leftMargin: 5
        }

        font.pointSize: 8

        color: "black"
    }

    Canvas {
        id: canvas

        property real degree: 0

        anchors.fill: parent
        antialiasing: true

        onDegreeChanged: {
            requestPaint();
        }

        onPaint: {
            var ctx = getContext("2d");

            var x = root.width/2;
            var y = root.height/2;

            var radius = root.radius/2 - root.lineWidth
            var startAngle = (Math.PI/180) * 270;
            var fullAngle = (Math.PI/180) * (270 + 360);
            var progressAngle = (Math.PI/180) * (270 + degree);

            ctx.reset()

            ctx.lineCap = 'round';
            ctx.lineWidth = root.lineWidth;

            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, fullAngle);
            ctx.strokeStyle = root.backgroundColor;
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, progressAngle);
            ctx.strokeStyle = root.foregroundColor;
            ctx.stroke();
        }
    }
}
