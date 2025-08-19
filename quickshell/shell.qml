import "./modules/bar/"

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ShellRoot{
	id: root

	//Init components
	Component.onCompleted: {
	  //MaterialThemeLoader.reapplyTheme()
	  ConfigLoader.loadConfig()
	  //PersistentStateManager.loadStates()
  	}

	ColumnLayout {
	  Loader{
		active: true
		sourceComponent: Bar{}
	  }

	}

}
