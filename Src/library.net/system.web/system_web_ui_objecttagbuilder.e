indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ObjectTagBuilder"

frozen external class
	SYSTEM_WEB_UI_OBJECTTAGBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			append_literal_string,
			append_sub_builder,
			init
		end

create
	make_objecttagbuilder

feature {NONE} -- Initialization

	frozen make_objecttagbuilder is
		external
			"IL creator use System.Web.UI.ObjectTagBuilder"
		end

feature -- Basic Operations

	init (parser: SYSTEM_WEB_UI_TEMPLATEPARSER; parent_builder: SYSTEM_WEB_UI_CONTROLBUILDER; type: SYSTEM_TYPE; tag_name: STRING; id: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL signature (System.Web.UI.TemplateParser, System.Web.UI.ControlBuilder, System.Type, System.String, System.String, System.Collections.IDictionary): System.Void use System.Web.UI.ObjectTagBuilder"
		alias
			"Init"
		end

	append_literal_string (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ObjectTagBuilder"
		alias
			"AppendLiteralString"
		end

	append_sub_builder (sub_builder: SYSTEM_WEB_UI_CONTROLBUILDER) is
		external
			"IL signature (System.Web.UI.ControlBuilder): System.Void use System.Web.UI.ObjectTagBuilder"
		alias
			"AppendSubBuilder"
		end

end -- class SYSTEM_WEB_UI_OBJECTTAGBUILDER
