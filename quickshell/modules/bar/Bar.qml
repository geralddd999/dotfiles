// modules/bar/Bar.qml
import "SystemInfo.qml"

import qs

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: barRoot
    
    // Bar properties
    property int barHeight: 32
    property int iconSize: 16
    property int spacing: 4

    // Appearence
    width: parent.width
    implicitHeight: barHeight

    anchors {
        top:true
        left: true
        right: true
    }

    margins {
        top:10
        left:10
        right:10

    }
    Rectangle{
        id: bar
        anchors.fill: parent
        color : "#2D2D2D"
        border.color: "#c6bbbb"
        radius: 20

        RowLayout{
            anchors.fill: parent
            anchors.margins: 5
            spacing: 0

            //Blur effect
            layer.enabled: true
            //layer.effect: Blur{ radius: 10}

            // Center section
            ClockWidget {
                anchors.centerIn: parent
            }
            Tray{
                anchors.centerIn: parent
            }

            Repeater{
                model: Hyprland.workspaces
                //anchors.centerIn: parent

                Rectangle{
                    implicitHeight: 12
                    width: 12
                    radius: 96

                    color: modelData.active ? "#4a93ff" : "#33333333"

                    border.color: "#555555"
                    border.width: 2 

                    MouseArea{
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspaces" + modelData.id) 
                    }

                    Text{
                        text: modelData.id
                        anchors.centerIn: parent
                        color: modelData.active ? "#ffffff" : "#cccccc"
                        font.pixelSize: 14
                        font.family: "Inter, sans-serif"
                    }
                }
            }

            Text {}
        }
    }  
}