indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.TemplateBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TEMPLATE_BUILDER

inherit
	WEB_CONTROL_BUILDER
		redefine
			set_tag_inner_text,
			needs_tag_inner_text,
			init
		end
	WEB_ITEMPLATE

create
	make_web_template_builder

feature {NONE} -- Initialization

	frozen make_web_template_builder is
		external
			"IL creator use System.Web.UI.TemplateBuilder"
		end

feature -- Access

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.TemplateBuilder"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"set_Text"
		end

feature -- Basic Operations

	init (parser: WEB_TEMPLATE_PARSER; parent_builder: WEB_CONTROL_BUILDER; type: TYPE; tag_name: SYSTEM_STRING; id: SYSTEM_STRING; attribs: IDICTIONARY) is
		external
			"IL signature (System.Web.UI.TemplateParser, System.Web.UI.ControlBuilder, System.Type, System.String, System.String, System.Collections.IDictionary): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"Init"
		end

	needs_tag_inner_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.TemplateBuilder"
		alias
			"NeedsTagInnerText"
		end

	set_tag_inner_text (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"SetTagInnerText"
		end

	instantiate_in (container: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"InstantiateIn"
		end

end -- class WEB_TEMPLATE_BUILDER
