import QtQuick
import QtQuick.Controls 6.3

ProgressBar {
    id: pbMy
    y: 0
    width: 255; height: 50
    value: 0.5
    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.width
        color: parent.parent.color
        radius: 7
    }
    contentItem: Item {
        implicitWidth: 255
        implicitHeight: 50
        Rectangle {
            width: parent.parent.value * parent.width
            height: 50
            radius: 5
            color: "#5E81AC"
        }
    }
}
