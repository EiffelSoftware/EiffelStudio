indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Configuration.HttpCapabilitiesBase"

external class
	SYSTEM_WEB_CONFIGURATION_HTTPCAPABILITIESBASE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Configuration.HttpCapabilitiesBase"
		end

feature -- Access

	get_item (key: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.Configuration.HttpCapabilitiesBase"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen get_config_capabilities (config_key: STRING; request: SYSTEM_WEB_HTTPREQUEST): SYSTEM_WEB_CONFIGURATION_HTTPCAPABILITIESBASE is
		external
			"IL static signature (System.String, System.Web.HttpRequest): System.Web.Configuration.HttpCapabilitiesBase use System.Web.Configuration.HttpCapabilitiesBase"
		alias
			"GetConfigCapabilities"
		end

feature {NONE} -- Implementation

	init is
		external
			"IL signature (): System.Void use System.Web.Configuration.HttpCapabilitiesBase"
		alias
			"Init"
		end

end -- class SYSTEM_WEB_CONFIGURATION_HTTPCAPABILITIESBASE
