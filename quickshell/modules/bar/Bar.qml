// modules/bar/Bar.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
    id: barRoot
    
    // Bar properties
    property int barHeight: 22
    
    // Bar layout
    RowLayout {
        anchors.fill: parent
        spacing: 5
        
        // Left section
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            
            // System info
            SystemInfo {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        // Right section
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            
            // Weather widget
            WeatherWidget {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}