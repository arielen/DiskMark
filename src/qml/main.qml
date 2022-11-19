import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import Qt.labs.platform

import "ui" as Ui

Window {
    id: window
    height: 339; width: 632
    minimumHeight: 339; minimumWidth: 632
    maximumHeight: 339; maximumWidth: 632
    opacity: 1
    visible: true
    color: "#2E3440"
    title: qsTr("DiskMark")

    MenuBar {
        id: menuBar

        Menu {
            id: fileMenu
            title: qsTr("&File")

            MenuItem {
                text: qsTr("&Save")
                onTriggered: console.debug("Save menu item clicked")
            }
            MenuItem {
                text: qsTr("&Copy")
                onTriggered: console.debug("Copy menu item clicked")
            }
            MenuSeparator {}
            MenuItem {
                text: qsTr("&Quit")
                onTriggered: console.debug("Close menu item clicked")
            }
        }
        Menu {
            id: settingsMenu
            title: qsTr("&Settings")
            Menu {
                title: "TestData"

                MenuItemGroup {
                    id: groupTestMenu
                }

                MenuItem {
                    id: testDataFillRandomMenu
                    text: qsTr("Random")
                    checked: true
                    group: groupTestMenu
                }
                MenuItem {
                    id: testDataFillZerosMenu
                    text: qsTr("Center")
                    checkable: true
                    group: groupTestMenu
                }
            }
            MenuSeparator {}
            MenuItemGroup {
                id: groupPresetMenu
            }
            MenuItem {
                id: standartpresetMenu
                text: qsTr("Standart Preset")
                checked: true
                group: groupPresetMenu
            }
            MenuItem {
                id: nvmepresetMenu
                text: qsTr("NVMe SSD")
                checkable: true
                group: groupPresetMenu
            }
            MenuSeparator {}
            MenuItem {
                id: odirectMenu
                text: qsTr("Use ODIRECT")
                checkable: true
                checked: true
            }
            MenuItem {
                id: flushpagecacheMenu
                text: qsTr("Flush Pagecache")
                checkable: true
                checked: true
            }
        }
        Menu {
            id: profileMenu
            title: qsTr("&Profile")

            MenuItemGroup {
                id: groupProfileMenu
            }
            MenuItem {
                text: qsTr("&Default")
                checked: true
                group: groupProfileMenu
            }
            MenuItem {
                text: qsTr("Peak Performance")
                checkable: true
                group: groupProfileMenu
            }
            MenuItem {
                text: qsTr("Real World Performance")
                checkable: true
                group: groupProfileMenu
            }
            MenuItem {
                text: qsTr("Demo")
                checkable: true
                group: groupProfileMenu
            }
            MenuItem {
                text: qsTr("Default [+Mix]")
                checkable: true
                group: groupProfileMenu
            }
            MenuItem {
                text: qsTr("Real World Prformance [+Mix]")
                checkable: true
                group: groupProfileMenu
            }
            MenuSeparator {}
            MenuItemGroup {
                id: groupProfileWRMenu
            }
            MenuItem {
                text: qsTr("Read and Write [+Mix]")
                checked: true
                group: groupProfileWRMenu
            }
            MenuItem {
                text: qsTr("&Read [+Mix]")
                checkable: true
                group: groupProfileWRMenu
            }
            MenuItem {
                text: qsTr("&Write [+Mix]")
                checkable: true
                group: groupProfileWRMenu
            }
        }
        Menu {
            id: helpMenu
            title: qsTr("&Help")

            MenuItem {
                text: qsTr("&About DiskMark")
            }
        }

    }

    Rectangle {
        id: rProgram
        x: 5; y: 5
        width: 622; height: 329
        color: "#2E3440"

        Ui.MyButton {
            id: bTestAll
            x: 5; y: 5
            height: 60
            text: qsTr("All")
            font.pixelSize: 18
        }

        Ui.MyComboBox {
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

        Ui.MyComboBox {
            id: cboxFileSize
            x: 167; y: 5
            width: 100; height: 25
        }

        Ui.MyComboBox {
            id: cboxStorages
            x: 273; y: 5
            width: 258; height: 25
        }

        Ui.MyComboBox {
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

            Ui.MyButton {
                id: bTest1
                text: qsTr("SEQ1M\nQ8T1")
            }

            Ui.MyProgressBar {
                id: pbTest1Read
                x: 96
            }

            Ui.MyProgressBar {
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

            Ui.MyButton {
                id: bTest2
                text: qsTr("SEQ128K\nQ32T1")
            }

            Ui.MyProgressBar {
                id: pbTest2Read
                x: 96
            }

            Ui.MyProgressBar {
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

            Ui.MyButton {
                id: bTest3
                text: qsTr("RND4K\nQ32T16")
            }

            Ui.MyProgressBar {
                id: pbTest3Read
                x: 96
            }

            Ui.MyProgressBar {
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

            Ui.MyButton {
                id: bTest4
                text: qsTr("RND4K\nQ1T1")
            }

            Ui.MyProgressBar {
                id: pbTest4Read
                x: 96
            }

            Ui.MyProgressBar {
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
