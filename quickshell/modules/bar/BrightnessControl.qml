// modules/bar/BrightnessControl.qml
import QtQuick
import QtQuick.Controls

Item {
    id: brightnessControl
    
    // Brightness properties
    property real brightness: 1.0
    
    // Mouse wheel handler
    WheelHandler {
        onWheel: {
            brightness = Math.max(0, Math.min(1, brightness + (event.angleDelta.y > 0 ? 0.05 : -0.05)))
            brightnessService.setBrightness(brightness)
        }
    }
}