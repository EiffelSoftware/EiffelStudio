indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.TemplateParser"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_TEMPLATE_PARSER

inherit
	WEB_BASE_PARSER

feature {NONE} -- Implementation

	compile_into_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Web.UI.TemplateParser"
		alias
			"CompileIntoType"
		end

end -- class WEB_TEMPLATE_PARSER
