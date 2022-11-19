import QtQuick
import QtQuick.Controls

ComboBox {
    id: control
    model: ["First", "Second", "Third"]
    width: 60; height: 25
    wheelEnabled: true

    font {
        bold: true
        family: "Fira Sans"
    }

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: control.pressed ? "#81A1C1" : "#5E81AC"
        radius: 5
    }

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: control.textRole
                ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole])
                : modelData
            color: "#000000"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
        background: Rectangle {
            implicitWidth: control.width
            implicitHeight: control.height
            border.color: "#4C566A"
            color: parent.pressed ? "#5E81AC" : "#81A1C1"
//            radius: 10
        }
        highlighted: control.highlightedIndex === index
    }

    contentItem: Text {
        leftPadding: 5
        rightPadding: control.indicator.width + control.spacing
        text: control.displayText
        font: control.font
        color: control.pressed ? "#2E3440": "#000"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "#4C566A"
            color: "#2E3440"
//            radius: 5
        }
    }
}
