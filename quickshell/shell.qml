import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ShellRoot{
	id: root

	//Init components
	Component.onCompleted: {
	  MaterialThemeLoader.reapplyTheme()
	  ConfigLoader.loadConfig()
	  PersistentStateManager.loadStates()
  	}

	ColumnLayout {
	  anchors.fill: parent

	  Bar {
		Layout.fillWidth : true
		Layout.preferredHeight : barHeight
	  }

	}

}
