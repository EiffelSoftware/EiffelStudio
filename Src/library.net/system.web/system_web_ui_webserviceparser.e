indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebServiceParser"

external class
	SYSTEM_WEB_UI_WEBSERVICEPARSER

inherit
	SYSTEM_WEB_UI_SIMPLEWEBHANDLERPARSER

create {NONE}

feature -- Basic Operations

	frozen get_compiled_type (input_file: STRING; context: SYSTEM_WEB_HTTPCONTEXT): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Web.HttpContext): System.Type use System.Web.UI.WebServiceParser"
		alias
			"GetCompiledType"
		end

feature {NONE} -- Implementation

	get_default_directive_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebServiceParser"
		alias
			"get_DefaultDirectiveName"
		end

end -- class SYSTEM_WEB_UI_WEBSERVICEPARSER
