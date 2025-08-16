// modules/bar/AudioControl.qml
import QtQuick
import QtQuick.Controls

Row {
    spacing: 5
    
    // Volume slider
    Slider {
        value: audioService.volume
        onValueChanged: audioService.setVolume(value)
    }
    
    // Mute button
    Button {
        icon.name: audioService.muted ? "audio-volume-muted" : "audio-volume-high"
        onClicked: audioService.toggleMute()
    }
}