indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Configuration.HttpCapabilitiesBase"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTTP_CAPABILITIES_BASE

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Configuration.HttpCapabilitiesBase"
		end

feature -- Access

	get_item (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.Configuration.HttpCapabilitiesBase"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen get_config_capabilities (config_key: SYSTEM_STRING; request: WEB_HTTP_REQUEST): WEB_HTTP_CAPABILITIES_BASE is
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

end -- class WEB_HTTP_CAPABILITIES_BASE
