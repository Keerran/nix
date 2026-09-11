pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import QtQuick
import ".."

Rectangle {
    id: root
    required property Notifications.Notif notif
    readonly property int size: 60
    implicitWidth: 450
    implicitHeight: size
    color: Colours.palette.surface_container
    radius: 20

    Component.onCompleted: {
        console.log(JSON.stringify(notif))
    }

    Behavior on x {
        Anim {}
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        drag.target: parent
        drag.axis: Drag.XAxis
        anchors {
            fill: parent
            margins: 10
        }
        Item {
            id: image
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            implicitWidth: root.size - 20
            implicitHeight: root.size - 20
            Loader {
                id: icon
                anchors.fill: parent
                active: root.notif.image

                sourceComponent: ClippingRectangle {
                    anchors.fill: parent
                    radius: 12
                    Image {
                        anchors.fill: parent
                        source: Qt.resolvedUrl(root.notif.image)
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }
            Loader {
                anchors.fill: parent
                active: !root.notif.image && root.notif.appIcon

                sourceComponent: ClippingRectangle {
                    color: "transparent"
                    implicitWidth: root.size
                    implicitHeight: root.size
                    radius: 5
                    Image {
                        anchors.fill: parent
                        source: Quickshell.iconPath(root.notif.appIcon)
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }

            Loader {
                anchors.fill: parent
                active: !root.notif.image && !root.notif.appIcon

                sourceComponent: Item {
                    implicitWidth: root.size
                    implicitHeight: root.size

                    MaterialIcon {
                        anchors.centerIn: parent
                        text: "info"
                        font.pointSize: 25
                        color: Colours.palette.on_surface_variant
                    }
                }
            }
        }

        Text {
            id: summary
            anchors {
                top: parent.top
                left: image.right
                leftMargin: 5
            }
            text: root.notif.summary
            font.pointSize: 12
            font.weight: 600
            color: Colours.palette.on_surface
        }

        Text {
            id: body
            anchors {
                bottom: parent.bottom
                left: image.right
                right: parent.right
                leftMargin: 5
                rightMargin: 10
            }
            text: bodyMetrics.elidedText
            font.pointSize: 12
            font.weight: 500
            color: Colours.palette.on_surface
        }
        TextMetrics {
            id: bodyMetrics
            text: root.notif.body
            font.family: body.font.family
            font.pointSize: body.font.pointSize
            font.weight: body.font.weight
            elideWidth: body.width
            elide: Text.ElideRight
        }
        onReleased: evt => {
            if (root.x < root.implicitWidth * 0.5)
                root.x = 0;
            else {
                root.notif.dismiss();
                Notifications.notifs = Notifications.notifs.filter(x => x != notif);
            }
        }
    }
}
