// services/SystemMonitor.qml
QtObject {
    id: systemMonitor
    
    // System properties
    property real cpuUsage: 0
    property real memoryUsage: 0
    property real diskUsage: 0
    
    // Update system info
    function update() {
        cpuUsage = getCpuUsage()
        memoryUsage = getMemoryUsage()
        diskUsage = getDiskUsage()
    }
}