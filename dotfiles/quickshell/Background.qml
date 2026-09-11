pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Shapes

ShapePath {
    id: root

    enum CornerType {
        Inside,
        X,
        Y
    }

    enum Location {
        Top = 0b1,
        Right = 0b10,
        TopRight = 0b11,
        Bottom = 0b100,
        BottomRight = 0b110,
        Left = 0b1000,
        TopLeft = 0b1001,
        BottomLeft = 0b1100
    }

    required property int location
    readonly property var corners: getCorners(location)

    required property Item content
    readonly property var rounding: 25
    readonly property var flattenX: content.width < rounding * 2
    readonly property var flattenY: content.height < rounding * 2
    readonly property var roundingX: flattenX ? content.width / 2 : rounding
    readonly property var roundingY: flattenY ? content.height / 2 : rounding

    strokeWidth: -1
    fillColor: Colours.palette.surface

    PathMove {
        // TODO: ????????????????
        x: root.content.width + roundingX
        y: (root.location & Background.Location.Top) ? root.roundingY : 0
    }
    PathArc {
        relativeX: root.roundingX * (!root.isX(root.corners[0]) ? -1 : 1)
        relativeY: root.roundingY * (!root.isY(root.corners[0]) ? -1 : 1)
        radiusX: Math.min(root.rounding, root.content.width)
        radiusY: Math.min(root.rounding, root.content.height) 
        direction: root.isInside(root.corners[0]) ? PathArc.Counterclockwise : PathArc.Clockwise
    }
    PathLine {
        relativeX: -root.content.width + root.xExtension(root.corners[0]) + root.xExtension(root.corners[1])
        relativeY: 0
    }
    PathArc {
        relativeX: root.roundingX * (!root.isX(root.corners[1]) ? -1 : 1)
        relativeY: root.roundingY * (!root.isY(root.corners[1]) ? 1 : -1)
        radiusX: Math.min(root.rounding, root.content.width)
        radiusY: Math.min(root.rounding, root.content.height)
        direction: root.isInside(root.corners[1]) ? PathArc.Counterclockwise : PathArc.Clockwise
    }
    PathLine {
        relativeX: 0
        relativeY: root.content.height - root.yExtension(root.corners[1]) - root.yExtension(root.corners[2])
    }
    PathArc {
        relativeX: root.roundingX * (!root.isX(root.corners[2]) ? 1 : -1)
        relativeY: root.roundingY * (!root.isY(root.corners[2]) ? 1 : -1)
        radiusX: Math.min(root.rounding, root.content.width)
        radiusY: Math.min(root.rounding, root.content.height)
        direction: root.isInside(root.corners[2]) ? PathArc.Counterclockwise : PathArc.Clockwise
    }
    PathLine {
        relativeX: root.content.width - root.xExtension(root.corners[2]) - root.xExtension(root.corners[3])
        relativeY: 0
    }
    PathArc {
        relativeX: root.roundingX * (!root.isX(root.corners[3]) ? 1 : -1)
        relativeY: root.roundingY * (!root.isY(root.corners[3]) ? -1 : 1)
        radiusX: Math.min(root.rounding, root.content.width)
        radiusY: Math.min(root.rounding, root.content.height)
        direction: root.isInside(root.corners[3]) ? PathArc.Counterclockwise : PathArc.Clockwise
    }

    function isInside(type: int): bool {
        return type == Background.CornerType.Inside
    }

    function isX(type: int): bool {
        return type == Background.CornerType.X
    }

    function isY(type: int): bool {
        return type == Background.CornerType.Y
    }

    function xExtension(type: int): int {
        return root.roundingX * (root.isX(type) ? -1 : 1)
    }

    function yExtension(type: int): int {
        return root.roundingY * (root.isY(type) ? -1 : 1)
    }

    function getCorners(loc: int): list<int> {
        const base = [
            (loc & Background.Location.Top) ? Background.CornerType.X : (loc & Background.Location.Right) ? Background.CornerType.Y : Background.CornerType.Inside,
            (loc & Background.Location.Top) ? Background.CornerType.X : (loc & Background.Location.Left) ? Background.CornerType.Y : Background.CornerType.Inside,
            (loc & Background.Location.Bottom) ? Background.CornerType.X : (loc & Background.Location.Left) ? Background.CornerType.Y : Background.CornerType.Inside,
            (loc & Background.Location.Bottom) ? Background.CornerType.X : (loc & Background.Location.Right) ? Background.CornerType.Y : Background.CornerType.Inside
        ];
        if(loc == Background.Location.TopRight) {
            base[0] = Background.CornerType.Inside;
        } else if (loc == Background.Location.TopLeft) {
            base[1] = Background.CornerType.Inside;
        } else if (loc == Background.Location.BottomLeft) {
            base[2] = Background.CornerType.Inside;
        } else if (loc == Background.Location.BottomRight) {
            base[3] = Background.CornerType.Inside;
        }
        return base;
    }
}
