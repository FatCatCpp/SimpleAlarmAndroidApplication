import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

ApplicationWindow {
    id: mainWindow

    visible: true

    color: "#F0F0F0"

    signal stopWatchStartRestartSignal()
    signal stopWatchStopSignal()
    signal stopWatchPauseSignal()

    signal timerStart(int hour, int min, int sec)
    signal timerStop()

    TabView {
        id: mainTab

        width: parent.width
        height: parent.height

        frameVisible: false
        tabPosition: Qt.BottomEdge

        currentIndex: 0

        style: TabViewStyle {
            tab: Rectangle {
                function tabImage(index) {
                    switch (index) {
                        case 0: {
                            if (styleData.selected)
                                return "qrc:/images/alarmClockOn.png"
                            else
                                return "qrc:/images/alarmClock.png"
                        }
                        case 1: {
                            if (styleData.selected)
                                return "qrc:/images/timerOn.png"
                            else
                                return "qrc:/images/timer.png"
                        }
                        case 2: {
                            if (styleData.selected)
                                return "qrc:/images/stopwatchOn.png"
                            else
                                return "qrc:/images/stopwatch.png"
                        }
                    }
                }

                color: "transparent"
                implicitWidth: mainWindow.width / 3
                implicitHeight: tabText.height + 75

                Image {
                    id: picture
                    source: tabImage(styleData.index)
                    width: 40
                    height: 40

                    anchors.centerIn: parent
                }

                Text {
                    id: tabText

                    text: styleData.title
                    opacity: styleData.selected ? 1 : 0.45
                    color: "#2E9BFE"

                    anchors {
                        top: picture.bottom
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }

                    font {
                        pixelSize: 16
                        bold: false
                    }
                }
            }
        }

        Tab {
            title: qsTr("Будильник")

            AlarmPage {
                id: alarmPage

                anchors.fill: mainWindow
                onCall: {
                    settingsPage.state = "show"
                }
            }

            SettingsPage {
                id: settingsPage

                state: ""

                showWidth: mainWindow.width

                width: -1000
                height: parent.height

                onCall: {
                    settingsPage.state = ""
                    alarmPage.opacityValue = picOpacity
                }
            }
        }
        Tab {
            title: qsTr("Секундомер")

            StopwatchPage {
                id: stopwatchPage

                anchors.fill: parent

                onStopwatchStartRestartPush: stopWatchStartRestartSignal()
                onStopwatchStopPush: stopWatchStopSignal()
                onStopwatchPausePush: stopWatchPauseSignal()
            }
        }
        Tab {
            title: qsTr("Таймер")

            TimerPage {
                id: timerPage

                anchors.fill: parent

                onStartTimer: timerStart(hour, min, sec)
                onStopTimer: timerStop()
            }
        }
    }
}
