import Quickshell
import QtQuick
import QtQuick.Controls
import ".."

Item {
    id: root

    required property PersistentProperties state
    readonly property int padding: 10

    implicitWidth: 500
    implicitHeight: 0
    clip: true

    Item {
        id: container
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        implicitHeight: searchBar.height + list.implicitHeight + root.padding * 2 

        ListView {
            id: list
            model: Launcher.search(search.text)
            spacing: root.padding
            anchors {
                margins: root.padding
                top: parent.top
                bottom: searchBar.top
                left: parent.left
                right: parent.right
            }
            implicitHeight: count * (30 + root.padding)

            highlight: Rectangle {
                radius: 25
                color: Colours.palette.on_surface
                opacity: 0.08

                y: list.currentItem?.y ?? 0
                implicitWidth: list.width
                implicitHeight: list.currentItem?.implicitHeight ?? 0

                Behavior on y {
                    Anim { }
                }
            }

            delegate: Item {
                required property var modelData
                implicitHeight: 30
                anchors {
                    left: parent?.left
                    right: parent?.right
                }
                Item {
                    anchors.fill: parent
                    Text {
                        color: Colours.palette.tertiary
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pointSize: 16
                        font.family: "CaskaydiaMono NFM"
                        font.weight: 300
                        text: modelData.text
                    }
                }
            }

            Behavior on implicitHeight {
                Anim { }
            }
        }

        Rectangle {
            id: searchBar
            color: Colours.palette.surface_container
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: root.padding
            }
            height: search.height 
            radius: 50

            MaterialIcon {
                id: icon
                text: "search"
                font.pointSize: 18
                color: Colours.palette.on_surface_variant

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    margins: (searchBar.height - width) / 2
                }
            }

            TextField {
                id: search
                color: Colours.palette.on_surface
                placeholderTextColor: Colours.palette.outline
                background: null
                placeholderText: "Search"
                anchors {
                    left: icon.right
                    leftMargin: root.padding
                    right: parent.right
                }

                font.pointSize: 15

                topPadding: 15
                bottomPadding: 15

                onAccepted: {
                    const item = list.currentItem;
                    if(item) {
                        item.modelData.item.execute()
                        root.state.control = false;
                    }
                }

                Keys.onEscapePressed: root.state.control = false
            }
        }
    }

    SequentialAnimation {
        id: show

        Anim {
            target: root
            property: "implicitHeight"
            to: container.height
        }

        ScriptAction {
            script: root.implicitHeight = Qt.binding(() => container.height)
        }
    }

    SequentialAnimation {
        id: hide

        Anim {
            target: root
            property: "implicitHeight"
            to: 0
        }

        ScriptAction {
            script: root.implicitHeight = 0
        }
    }

    Connections {
        target: state

        function onControlChanged() {
            if(state.control) {
                show.start();
                search.forceActiveFocus();
            }
            else {
                hide.start();
                search.text = ""
            }
        }
    }
}
