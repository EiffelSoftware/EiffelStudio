indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebServiceParser"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_WEB_SERVICE_PARSER

inherit
	WEB_SIMPLE_WEB_HANDLER_PARSER

create {NONE}

feature -- Basic Operations

	frozen get_compiled_type (input_file: SYSTEM_STRING; context: WEB_HTTP_CONTEXT): TYPE is
		external
			"IL static signature (System.String, System.Web.HttpContext): System.Type use System.Web.UI.WebServiceParser"
		alias
			"GetCompiledType"
		end

feature {NONE} -- Implementation

	get_default_directive_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebServiceParser"
		alias
			"get_DefaultDirectiveName"
		end

end -- class WEB_WEB_SERVICE_PARSER
