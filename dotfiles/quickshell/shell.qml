//@ pragma Env QS_NO_RELOAD_POPUP=1
pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

ShellRoot {
    id: root
    readonly property var width: 60
    Variants {
        model: Quickshell.screens
        Scope {
            id: scope
            required property ShellScreen modelData

            PersistentProperties {
                id: stateEl

                property bool bar: false
                property bool session: false
                property bool dash: false
                property bool control: false

                Component.onCompleted: GlobalState.init(modelData, this)
            }

            PanelWindow {
                screen: modelData
                anchors {
                    left: true
                }
                implicitWidth: 1
                implicitHeight: 1
                exclusiveZone: bar.width
                mask: Region {}
            }

            PanelWindow {
                id: win
                screen: modelData
                exclusionMode: ExclusionMode.Ignore
                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                color: "transparent"

                mask: Region {
                    x: bar.implicitWidth + bar.x
                    y: 0
                    width: win.width - x
                    height: win.height
                    intersection: Intersection.Subtract

                    regions: regions.instances
                }

                Variants {
                    id: regions

                    model: popouts.children

                    Region {
                        required property Item modelData

                        x: modelData.x + bar.width
                        y: modelData.y
                        width: modelData.width
                        height: modelData.height
                        intersection: Intersection.Subtract
                    }
                }

                Borders {
                    open: stateEl.bar
                    bar: bar
                    popouts: popouts
                }

                Rectangle {
                    id: bar
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    color: Colours.palette.surface
                    implicitWidth: stateEl.bar ? root.width : 0
                    Item {
                        anchors {
                            top: parent.top
                            bottom: parent.bottom
                            right: parent.right
                        }

                        implicitWidth: root.width
                        Bar { state: stateEl }
                    }
                    Behavior on implicitWidth {
                        Anim {}
                    }
                }
                Popouts {
                    id: popouts
                    anchors.fill: parent
                    anchors.leftMargin: bar.width
                    state: stateEl
                }
            }
        }
    }

    IpcHandler {
        target: "root"

        function app(val: string) {
            Launcher.search(val);
        }

        function toggle() {
            const state = GlobalState.active()
            state.bar = !state.bar;
            const windowGap = state.bar ? "10" : "0";
            const singleWindowRounding = state.bar ? "20" : "0";
            Quickshell.execDetached([Quickshell.shellPath(`toggle.sh`), windowGap, singleWindowRounding]);
        }

        function launcher() {
            const state = GlobalState.active()
            state.control = !state.control;
        }
    }
}
