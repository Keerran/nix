import QtQuick
import QtQuick.Shapes

Item {
    enum Location {
        BottomLeft,
        BottomRight,
        TopLeft,
        TopRight
    }
    id: root
    property bool enabled: true
    required property int radius
    required property int location
    implicitWidth: radius
    implicitHeight: radius
    Shape {
        layer.enabled: true
        layer.smooth: true
        preferredRendererType: Shape.CurveRenderer
        x: (root.enabled ? 0 : root.radius) * ((root.location & 0b1) ? 1 : -1)
        y: (root.enabled ? 0 : root.radius) * ((root.location & 0b10) ? -1 : 1)

        ShapePath {
            id: path
            fillColor: Colours.palette.surface
            strokeWidth: 0
            startX: (root.location & 0b1) ? root.radius: 0
            startY: (root.location & 0b10) ? 0 : root.radius
            pathHints: ShapePath.PathSolid & ShapePath.PathNonIntersecting
            PathAngleArc {
                moveToStart: false
                centerX: root.radius - path.startX
                centerY: root.radius - path.startY
                radiusX: root.radius
                radiusY: root.radius
                startAngle: switch (root.location) {
                    case 0: return 90
                    case 1: return 0
                    case 2: return 180
                    case 3: return 270
                }
                sweepAngle: 90
            }
            PathLine {
                x: path.startX
                y: path.startY 
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutCubic
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutCubic
            }
        }
    }
}
