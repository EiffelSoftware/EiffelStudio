indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.PageParser"

frozen external class
	SYSTEM_WEB_UI_PAGEPARSER

inherit
	SYSTEM_WEB_UI_TEMPLATECONTROLPARSER

create
	make_pageparser

feature {NONE} -- Initialization

	frozen make_pageparser is
		external
			"IL creator use System.Web.UI.PageParser"
		end

feature -- Basic Operations

	frozen get_compiled_page_instance (virtual_path: STRING; input_file: STRING; context: SYSTEM_WEB_HTTPCONTEXT): SYSTEM_WEB_IHTTPHANDLER is
		external
			"IL static signature (System.String, System.String, System.Web.HttpContext): System.Web.IHttpHandler use System.Web.UI.PageParser"
		alias
			"GetCompiledPageInstance"
		end

feature {NONE} -- Implementation

	compile_into_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.PageParser"
		alias
			"CompileIntoType"
		end

end -- class SYSTEM_WEB_UI_PAGEPARSER
