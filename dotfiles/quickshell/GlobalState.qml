pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    property var screens: new Map()

    function init(screen: ShellScreen, val: PersistentProperties) {
        screens.set(Hyprland.monitorFor(screen), val);
    }

    function active(): PersistentProperties {
        return screens.get(Hyprland.focusedMonitor);
    }
}
