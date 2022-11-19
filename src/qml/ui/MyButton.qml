import QtQuick
import QtQuick.Controls 6.3

Button {
    id: bMy
    x: 0; y: 0
    height: 50; width: 90
    text: qsTr("Button")
    antialiasing: true
    font {
        bold: true
        pixelSize: 16
    }
    layer {
        smooth: true
    }
    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: bMy.down ? "#81A1C1" : "#5E81AC"
        radius: 5
    }
    Connections {
        target: bMy
        onClicked: console.log("clicked")
    }
}
