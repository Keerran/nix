import Quickshell
import QtQuick
import ".."

Item {
    required property PersistentProperties state
    property bool open: false
    implicitWidth: 100
    implicitHeight: open ? 100 : 0

    Behavior on implicitHeight {
        Anim {}
    }
}
