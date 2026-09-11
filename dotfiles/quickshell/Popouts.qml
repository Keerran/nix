import Quickshell
import Quickshell.Hyprland
import QtQuick
import "power" as Power
import "notifications" as Notifs
import "dash" as Dash
import "control" as Control

Item {
    id: root
    anchors.fill: parent
    required property PersistentProperties state
    readonly property alias power: power
    readonly property alias notifs: notifs
    readonly property alias dash: dash
    readonly property alias control: control
    Power.Content {
        id: power
        state: root.state
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Notifs.Tray {
        id: notifs
        anchors.top: parent.top
        anchors.right: parent.right
    }

    MouseArea {
        id: dashHandle
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: dash.width
        implicitHeight: dash.height + 1
        hoverEnabled: true
        Dash.Content {
            id: dash
            state: root.state
            open: false
        }
    }

    Control.Content {
        id: control
        state: root.state
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    HyprlandFocusGrab {
        id: focusGrab

        active: state.dash || state.session || state.control
        windows: [QsWindow.window]
        onCleared: {
        }
    }
}
