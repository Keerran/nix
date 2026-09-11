import Quickshell
import QtQuick
import ".."

Item {
    required property PersistentProperties state
    implicitWidth: state.session ? content.width : 0
    implicitHeight: content.height
    Column {
        id: content
        padding: 20
        spacing: 20
        StyledButton {
            implicitWidth: 100
            implicitHeight: 100
            radius: 25
            symbol: "power_settings_new"
            function onPressed() {
                Quickshell.execDetached(["systemctl", "poweroff"])
            }
        }

        StyledButton {
            implicitWidth: 100
            implicitHeight: 100
            radius: 25
            symbol: "replay"
            function onPressed() {
                Quickshell.execDetached(["systemctl", "reboot"])
            }
        }

    }
    Behavior on implicitWidth {
        Anim { }
    }
}
