pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick
import "power" as Power

Item {
    id: root

    required property bool open
    required property Rectangle bar
    required property Popouts popouts

    anchors.fill: parent

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        blurMax: 15
        shadowColor: Colours.palette.shadow
    }

    Rectangle {
        anchors.fill: parent
        color: Colours.palette.surface
        layer.enabled: true
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: maskEl
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: maskEl
        anchors.fill: parent
        layer.enabled: true
        visible: false
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            anchors.leftMargin: bar.width
            radius: root.open ? 25 : 0

            Behavior on radius {
                Anim {}
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: bar.width
        Shape {
            anchors.right: parent.right
            anchors.verticalCenter : parent.verticalCenter
            Background { 
                content: root.popouts.power
                location: Background.Location.Right
            }
        }

        Shape {
            anchors.top: parent.top
            anchors.right: parent.right
            Background {
                content: root.popouts.notifs
                location: Background.Location.TopRight
            }
        }

        Shape {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            Background {
                content: root.popouts.dash
                location: Background.Location.Top
            }
        }

        Shape {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Background {
                content: root.popouts.control
                location: Background.Location.Bottom
            }
        }
    }
}
