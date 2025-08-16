QtObject {
	id: configLoader

	function loadConfig(){
		//load config from JSON
		const config = JSON.parse(File.read("config.json"))

		applyConfig(config)
	}

	function applyConfig(){
		//Apply config settings
	}

}
