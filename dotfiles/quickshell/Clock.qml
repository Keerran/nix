import QtQuick

Column {
    MaterialIcon {
        color: Colours.palette.tertiary
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 16
        text: "schedule"

    }
    Text {
        color: Colours.palette.tertiary
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 16
        font.family: "CaskaydiaMono NFM"
        font.weight: 300
        text: Time.format("hh\nmm")
    }
}
