indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.TemplateBuilder"

external class
	SYSTEM_WEB_UI_TEMPLATEBUILDER

inherit
	SYSTEM_WEB_UI_ITEMPLATE
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			set_tag_inner_text,
			needs_tag_inner_text,
			init
		end

create
	make_templatebuilder

feature {NONE} -- Initialization

	frozen make_templatebuilder is
		external
			"IL creator use System.Web.UI.TemplateBuilder"
		end

feature -- Access

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.TemplateBuilder"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"set_Text"
		end

feature -- Basic Operations

	init (parser: SYSTEM_WEB_UI_TEMPLATEPARSER; parent_builder: SYSTEM_WEB_UI_CONTROLBUILDER; type: SYSTEM_TYPE; tag_name: STRING; id: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY) is
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

	set_tag_inner_text (text: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"SetTagInnerText"
		end

	instantiate_in (container: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.TemplateBuilder"
		alias
			"InstantiateIn"
		end

end -- class SYSTEM_WEB_UI_TEMPLATEBUILDER
