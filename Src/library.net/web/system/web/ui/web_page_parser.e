indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.PageParser"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PAGE_PARSER

inherit
	WEB_TEMPLATE_CONTROL_PARSER

create
	make_web_page_parser

feature {NONE} -- Initialization

	frozen make_web_page_parser is
		external
			"IL creator use System.Web.UI.PageParser"
		end

feature -- Basic Operations

	frozen get_compiled_page_instance (virtual_path: SYSTEM_STRING; input_file: SYSTEM_STRING; context: WEB_HTTP_CONTEXT): WEB_IHTTP_HANDLER is
		external
			"IL static signature (System.String, System.String, System.Web.HttpContext): System.Web.IHttpHandler use System.Web.UI.PageParser"
		alias
			"GetCompiledPageInstance"
		end

feature {NONE} -- Implementation

	compile_into_type: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.PageParser"
		alias
			"CompileIntoType"
		end

end -- class WEB_PAGE_PARSER
