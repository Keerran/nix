import Quickshell
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    required property PersistentProperties state
    anchors.fill: parent
    spacing: 10
    anchors.bottomMargin: 10
    Item {
        Layout.fillHeight: true
    }
    Clock {
        Layout.alignment: Qt.AlignBottom
        Layout.fillWidth: true
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.margins: 10
        radius: width / 2
        implicitHeight: inner.implicitHeight
        color: Colours.palette.secondary

        Column {
            id: inner
            anchors.fill: parent
            padding: 5
            Icon {
                symbol: "headset_mic"
                workspace: "comms"
            }
            Icon {
                symbol: "music_note"
                workspace: "music"
            }

            component Icon : MaterialIcon {
                required property string symbol
                required property string workspace
                anchors.horizontalCenter: parent.horizontalCenter
                color: Colours.palette.surface_container
                font.pointSize: 18
                font.weight: 600
                text: symbol

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent

                    onPressed: () => {
                        Quickshell.execDetached(["hyprctl", "dispatch", "togglespecialworkspace", workspace])
                    }
                }
            }
        }
    }
    Column {
        Layout.alignment: Qt.AlignBottom
        Layout.fillWidth: true
        MaterialIcon {
            id: text
            color: Colours.palette.error
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 18
            font.weight: 600
            text: "power_settings_new"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onPressed: () => {
                    root.state.session = !root.state.session 
                }
            }
        }
    }
}
