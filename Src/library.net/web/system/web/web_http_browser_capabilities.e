indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpBrowserCapabilities"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTTP_BROWSER_CAPABILITIES

inherit
	WEB_HTTP_CAPABILITIES_BASE

create
	make_web_http_browser_capabilities

feature {NONE} -- Initialization

	frozen make_web_http_browser_capabilities is
		external
			"IL creator use System.Web.HttpBrowserCapabilities"
		end

feature -- Access

	frozen get_java_applets: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_JavaApplets"
		end

	frozen get_clr_version: VERSION is
		external
			"IL signature (): System.Version use System.Web.HttpBrowserCapabilities"
		alias
			"get_ClrVersion"
		end

	frozen get_win16: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Win16"
		end

	frozen get_background_sounds: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_BackgroundSounds"
		end

	frozen get_w3_cdom_version: VERSION is
		external
			"IL signature (): System.Version use System.Web.HttpBrowserCapabilities"
		alias
			"get_W3CDomVersion"
		end

	frozen get_ecma_script_version: VERSION is
		external
			"IL signature (): System.Version use System.Web.HttpBrowserCapabilities"
		alias
			"get_EcmaScriptVersion"
		end

	frozen get_tag_writer: TYPE is
		external
			"IL signature (): System.Type use System.Web.HttpBrowserCapabilities"
		alias
			"get_TagWriter"
		end

	frozen get_type_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpBrowserCapabilities"
		alias
			"get_Type"
		end

	frozen get_platform: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpBrowserCapabilities"
		alias
			"get_Platform"
		end

	frozen get_vbscript: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_VBScript"
		end

	frozen get_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpBrowserCapabilities"
		alias
			"get_Version"
		end

	frozen get_crawler: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Crawler"
		end

	frozen get_msdom_version: VERSION is
		external
			"IL signature (): System.Version use System.Web.HttpBrowserCapabilities"
		alias
			"get_MSDomVersion"
		end

	frozen get_cdf: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_CDF"
		end

	frozen get_active_xcontrols: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_ActiveXControls"
		end

	frozen get_tables: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Tables"
		end

	frozen get_beta: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Beta"
		end

	frozen get_frames: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Frames"
		end

	frozen get_cookies: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Cookies"
		end

	frozen get_win32: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_Win32"
		end

	frozen get_aol: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_AOL"
		end

	frozen get_java_script: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpBrowserCapabilities"
		alias
			"get_JavaScript"
		end

	frozen get_minor_version: DOUBLE is
		external
			"IL signature (): System.Double use System.Web.HttpBrowserCapabilities"
		alias
			"get_MinorVersion"
		end

	frozen get_major_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpBrowserCapabilities"
		alias
			"get_MajorVersion"
		end

	frozen get_browser: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpBrowserCapabilities"
		alias
			"get_Browser"
		end

end -- class WEB_HTTP_BROWSER_CAPABILITIES
