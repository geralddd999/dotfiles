// services/HyprlandService.qml
QtObject {
    id: hyprlandService
    
    // Hyprland commands
    function dispatch(command) {
        // Execute Hyprland command
    }
    
    // Window management
    function focusWindow(address) {
        dispatch(`dispatch focuswindow address:${address}`)
    }
}