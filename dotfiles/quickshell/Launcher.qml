pragma Singleton

import "fuzzysort.js" as Fuzzy
import Quickshell
import Quickshell.Io
import QtQuick
import Ugly

Singleton {
    Apps {
        id: apps
        path: Quickshell.shellPath("db.sqlite")
        entries: DesktopEntries.applications.values
    }

    function search(query = "") {
        const items = apps.items
        return Fuzzy.go(query, items, {
            keys: ["name", it => it.entry.keywords.join("\n")]
        }).map(res => ({
            text: res[0].highlight() || res.obj.name,
            item: res.obj.entry,
        })).slice(0, 10);
    }
}
