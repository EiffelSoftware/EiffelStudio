indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ObjectTagBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_OBJECT_TAG_BUILDER

inherit
	WEB_CONTROL_BUILDER
		redefine
			append_literal_string,
			append_sub_builder,
			init
		end

create
	make_web_object_tag_builder

feature {NONE} -- Initialization

	frozen make_web_object_tag_builder is
		external
			"IL creator use System.Web.UI.ObjectTagBuilder"
		end

feature -- Basic Operations

	init (parser: WEB_TEMPLATE_PARSER; parent_builder: WEB_CONTROL_BUILDER; type: TYPE; tag_name: SYSTEM_STRING; id: SYSTEM_STRING; attribs: IDICTIONARY) is
		external
			"IL signature (System.Web.UI.TemplateParser, System.Web.UI.ControlBuilder, System.Type, System.String, System.String, System.Collections.IDictionary): System.Void use System.Web.UI.ObjectTagBuilder"
		alias
			"Init"
		end

	append_literal_string (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ObjectTagBuilder"
		alias
			"AppendLiteralString"
		end

	append_sub_builder (sub_builder: WEB_CONTROL_BUILDER) is
		external
			"IL signature (System.Web.UI.ControlBuilder): System.Void use System.Web.UI.ObjectTagBuilder"
		alias
			"AppendSubBuilder"
		end

end -- class WEB_OBJECT_TAG_BUILDER
