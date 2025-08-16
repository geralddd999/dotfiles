// modules/bar/SystemInfo.qml
import QtQuick
import QtQuick.Controls

Row {
    spacing: 10
    
    // CPU usage
    Label {
        text: "CPU: " + systemInfo.cpuUsage + "%"
    }
    
    // Memory usage
    Label {
        text: "RAM: " + systemInfo.memoryUsage + "%"
    }
    
    // Disk usage
    Label {
        text: "Disk: " + systemInfo.diskUsage + "%"
    }
}