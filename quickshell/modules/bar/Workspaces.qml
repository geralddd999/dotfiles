import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick

RowLayout{

    Repeater{
                model: Hyprland.workspaces
                anchors.centerIn: parent

                Rectangle{
                    implicitHeight: 20
                    width: 20
                    radius: 180

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
}