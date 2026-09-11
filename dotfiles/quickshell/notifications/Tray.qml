pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import ".."

Item {
    id: root
    implicitWidth: childrenRect.width
    implicitHeight: {
        if(list.count == 0)
            return 0;
        let value = Math.max(list.count - 1, 0) * 5 + 20;
        for(let i = 0; i < list.count; i++) {
            value += list.itemAtIndex(i)?.height ?? 0;
        }
        return value;
    }

    Behavior on implicitHeight {
        Anim {}
    }

    Column {
        padding: 10
        ListView {
            id: list
            spacing: 5
            clip: true
            implicitWidth: 450
            implicitHeight: root.implicitHeight
            model: Notifications.notifs

            delegate: Item {
                required property Notifications.Notif modelData
                implicitHeight: inner.implicitHeight
                anchors.left: parent.left
                anchors.right: parent.right
                Notif {
                    id: inner
                    notif: parent.modelData
                }
            }
        }
    }
}
