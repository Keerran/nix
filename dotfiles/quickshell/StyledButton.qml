import Quickshell
import QtQuick

Rectangle {
    id: root
    color: Colours.palette.secondary_container
    property var textColor: Colours.palette.on_secondary_container
    function onPressed() {}
    required property string symbol

    MouseArea {
        id: mouseArea
        readonly property var radius: parent.radius
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onPressed: () => root.onPressed()
        Rectangle {
            anchors.fill: parent
            color: Qt.alpha(Colours.palette.on_secondary, mouseArea.pressed ? 0.2 : mouseArea.containsMouse ? 0.08 : 0)
            radius: parent.radius

            Behavior on color {
                ColorAnimation {
                    duration: 100
                    easing.type: Easing.InOutCubic
                }
            }
        }
    }

    MaterialIcon {
        anchors.centerIn: parent
        color: parent.textColor
        font.pointSize: 45
        font.weight: 500
        text: parent.symbol
    }
}
