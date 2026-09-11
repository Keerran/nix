pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property Palette palette: Palette {}

    function load(text: string) {
        const { colors } = JSON.parse(text);
        for(const [key, color] of Object.entries(colors)) {
            palette[key] = color["default"];
        }
    }

    component Palette: QtObject {
        property color background: "#ffffff"
        property color error: "#ffffff"
        property color error_container: "#ffffff"
        property color inverse_on_surface: "#ffffff"
        property color inverse_primary: "#ffffff"
        property color inverse_surface: "#ffffff"
        property color on_background: "#ffffff"
        property color on_error: "#ffffff"
        property color on_error_container: "#ffffff"
        property color on_primary: "#ffffff"
        property color on_primary_container: "#ffffff"
        property color on_primary_fixed: "#ffffff"
        property color on_primary_fixed_variant: "#ffffff"
        property color on_secondary: "#ffffff"
        property color on_secondary_container: "#ffffff"
        property color on_secondary_fixed: "#ffffff"
        property color on_secondary_fixed_variant: "#ffffff"
        property color on_surface: "#ffffff"
        property color on_surface_variant: "#ffffff"
        property color on_tertiary: "#ffffff"
        property color on_tertiary_container: "#ffffff"
        property color on_tertiary_fixed: "#ffffff"
        property color on_tertiary_fixed_variant: "#ffffff"
        property color outline: "#ffffff"
        property color outline_variant: "#ffffff"
        property color primary: "#ffffff"
        property color primary_container: "#ffffff"
        property color primary_fixed: "#ffffff"
        property color primary_fixed_dim: "#ffffff"
        property color scrim: "#ffffff"
        property color secondary: "#ffffff"
        property color secondary_container: "#ffffff"
        property color secondary_fixed: "#ffffff"
        property color secondary_fixed_dim: "#ffffff"
        property color shadow: "#ffffff"
        property color source_color: "#ffffff"
        property color surface: "#ffffff"
        property color surface_bright: "#ffffff"
        property color surface_container: "#ffffff"
        property color surface_container_high: "#ffffff"
        property color surface_container_highest: "#ffffff"
        property color surface_container_low: "#ffffff"
        property color surface_container_lowest: "#ffffff"
        property color surface_dim: "#ffffff"
        property color surface_tint: "#ffffff"
        property color surface_variant: "#ffffff"
        property color tertiary: "#ffffff"
        property color tertiary_container: "#ffffff"
        property color tertiary_fixed: "#ffffff"
        property color tertiary_fixed_dim: "#ffffff"
    }

    Process {
        id: loadProc
        command: ["matugen", "image", "/mnt/shared/Wallpapers/nomai.jpeg", "--json", "hex", "--prefer", "saturation", "--old-json-output"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.load(text)
        }
    }
}
