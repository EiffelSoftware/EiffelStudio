indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.RootBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_ROOT_BUILDER

inherit
	WEB_TEMPLATE_BUILDER
		redefine
			get_child_control_type
		end
	WEB_ITEMPLATE

create
	make_web_root_builder

feature {NONE} -- Initialization

	frozen make_web_root_builder (parser: WEB_TEMPLATE_PARSER) is
		external
			"IL creator signature (System.Web.UI.TemplateParser) use System.Web.UI.RootBuilder"
		end

feature -- Basic Operations

	get_child_control_type (tag_name: SYSTEM_STRING; attribs: IDICTIONARY): TYPE is
		external
			"IL signature (System.String, System.Collections.IDictionary): System.Type use System.Web.UI.RootBuilder"
		alias
			"GetChildControlType"
		end

end -- class WEB_ROOT_BUILDER
