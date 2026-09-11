import Quickshell
import QtQuick

Scope {
    id: root
    property var enabled: true
    readonly property var radius: 25
    component CornerWindow: PanelWindow {
        id: root
        color: "transparent"

        property bool enabled: true
        required property int location
        required property int radius

        anchors {
            top: (root.location & 0b10)
            bottom: !(root.location & 0b10)
            right: (root.location & 0b1)
            left: !(root.location & 0b1)
        }
        implicitWidth: radius
        implicitHeight: radius
        
        RoundCorner {
            enabled: root.enabled
            anchors.fill: parent
            radius: root.radius
            location: root.location
        }
    }

    CornerWindow {
        enabled: root.enabled
        radius: root.radius
        location: RoundCorner.Location.BottomLeft
    }

    CornerWindow {
        enabled: root.enabled
        radius: root.radius
        location: RoundCorner.Location.TopLeft
    }
}
