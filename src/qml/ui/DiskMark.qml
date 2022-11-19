import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import Qt.labs.platform

Window {
    id: window
    height: 339; width: 632
    minimumHeight: 339; minimumWidth: 632
    maximumHeight: 339; maximumWidth: 632
    opacity: 1
    visible: true
    color: "#2E3440"
    title: qsTr("DiskMark")

    Rectangle {
        id: rProgram
        x: 5; y: 5
        width: 622; height: 329
        color: "#2E3440"

        MyButton {
            id: bTestAll
            x: 5; y: 5
            height: 60
            text: qsTr("All")
            font.pixelSize: 18
        }

        MyComboBox {
            id: cboxRepeatCount
            x: 101; y: 5
            width: 60; height: 25
            model: ListModel{
                id: model
                ListElement {text: "1"}
                ListElement {text: "2"}
                ListElement {text: "3"}
                ListElement {text: "4"}
                ListElement {text: "5"}
                ListElement {text: "6"}
                ListElement {text: "7"}
                ListElement {text: "8"}
                ListElement {text: "9"}
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
            currentIndex: 3
        }

        MyComboBox {
            id: cboxFileSize
            x: 167; y: 5
            width: 100; height: 25
        }

        MyComboBox {
            id: cboxStorages
            x: 273; y: 5
            width: 258; height: 25
        }

        MyComboBox {
            id: cboxMixRatio
            x: 537; y: 5
            width: 80; height: 25
        }

        Text {
            id: textRead
            x: 101
            y: 41
            width: 255
            height: 24
            color: "#ffffff"
            text: qsTr("Read [Mbps]")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            transformOrigin: Item.Center
        }

        Text {
            id: textWrite
            x: 364
            y: 41
            width: 255
            height: 24
            color: "#ffffff"
            text: qsTr("Write [Mbps]")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            transformOrigin: Item.Center
        }

        Rectangle {
            id: rProgram1
            x: 5; y: 71
            width: 615; height: 50
            visible: true
            color: parent.color.toString()

            MyButton {
                id: bTest1
                text: qsTr("SEQ1M\nQ8T1")
            }

            MyProgressBar {
                id: pbTest1Read
                x: 96
            }

            MyProgressBar {
                id: pbTest1Write
                x: 357
            }
        }

        Rectangle {
            id: rProgram2
            x: 5
            y: 127
            width: 615
            height: 50
            visible: true
            color: parent.color.toString()

            MyButton {
                id: bTest2
                text: qsTr("SEQ128K\nQ32T1")
            }

            MyProgressBar {
                id: pbTest2Read
                x: 96
            }

            MyProgressBar {
                id: pbTest2Write
                x: 357
            }
        }

        Rectangle {
            id: rProgram3
            x: 5
            y: 183
            width: 615
            height: 50
            visible: true
            color: parent.color.toString()

            MyButton {
                id: bTest3
                text: qsTr("RND4K\nQ32T16")
            }

            MyProgressBar {
                id: pbTest3Read
                x: 96
            }

            MyProgressBar {
                id: pbTest3Write
                x: 357
            }
        }

        Rectangle {
            id: rProgram4
            x: 5
            y: 239
            width: 615
            height: 50
            visible: true
            color: parent.color.toString()

            MyButton {
                id: bTest4
                text: qsTr("RND4K\nQ1T1")
            }

            MyProgressBar {
                id: pbTest4Read
                x: 96
            }

            MyProgressBar {
                id: pbTest4Write
                x: 357
            }
        }

        Rectangle {
            id: rTextDeviceModel
            x: 5
            y: 295
            width: 615
            height: 25
            color: parent.color.toString()
            border {
               color: "#4C566A"
            }
            radius: 5

            TextEdit {
                id: textDeviceModel
                x: 5
                y: 2
                width: 605
                height: 21
                color: "#ffffff"
                text: qsTr("textdasdasdas")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                cursorVisible: true
                readOnly: true
                selectionColor: "#4c566a"

            }
        }
    }
}
