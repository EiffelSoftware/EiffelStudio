indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.SimpleWebHandlerParser"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_SIMPLE_WEB_HANDLER_PARSER

inherit
	SYSTEM_OBJECT

feature {NONE} -- Implementation

	get_default_directive_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Web.UI.SimpleWebHandlerParser"
		alias
			"get_DefaultDirectiveName"
		end

	frozen get_compiled_type_from_cache: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.SimpleWebHandlerParser"
		alias
			"GetCompiledTypeFromCache"
		end

end -- class WEB_SIMPLE_WEB_HANDLER_PARSER
