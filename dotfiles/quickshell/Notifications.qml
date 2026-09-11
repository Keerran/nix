pragma ComponentBehavior: Bound
pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root
    property list<Notif> notifs: []
    NotificationServer {
        keepOnReload: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: notif => {
            notif.tracked = true;
            const obj = blankNotif.createObject(root, {
                notif
            })
            root.notifs = [obj, ...root.notifs]
        }
    }

    component Notif: QtObject {
        id: self
        property Notification notif;

        property var body;
        property var summary;
        property var image;
        property var appIcon;

        Component.onCompleted: {
            if(!notif) return;
            self.body = notif.body;
            self.summary = notif.summary;
            self.image = notif.image;
            self.appIcon = notif.appIcon;
        }

        property Timer timer: Timer {
            interval: 2000
            repeat: false
            running: true

            onTriggered: {
                self.dismiss();
            }
        }

        function dismiss() {
            notif.dismiss()
        }

        readonly property Connections conn: Connections {
            target: self.notif

            function onBodyChanged() {
                self.body = self.notif.body
            }

            function onSummaryChanged() {
                self.summary = self.notif.summary
            }

            function onImageChanged() {
                self.image = self.notif.image
            }

            function onAppIconChanged() {
                self.appIcon = self.notif.appIcon
            }

            function onClosed() {
                self.close()
            }
        }

        function close() {
            if(root.notifs.includes(this)) {
                root.notifs = root.notifs.filter(n => n != this);
                notif?.dismiss();
                destroy();
            }
        }
    }

    Component {
        id: blankNotif
        Notif { }
    }
}
