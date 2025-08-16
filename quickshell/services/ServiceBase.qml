// services/ServiceBase.qml
QtObject {
    id: serviceBase
    
    // Service properties
    property bool isRunning: false
    
    // Start service
    function start() {
        isRunning = true
    }
    
    // Stop service
    function stop() {
        isRunning = false
    }
}