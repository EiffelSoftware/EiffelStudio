indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ControlBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CONTROL_BUILDER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.ControlBuilder"
		end

feature -- Access

	frozen get_tag_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.ControlBuilder"
		alias
			"get_TagName"
		end

	frozen get_naming_container_type: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.ControlBuilder"
		alias
			"get_NamingContainerType"
		end

	frozen get_control_type: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.ControlBuilder"
		alias
			"get_ControlType"
		end

	frozen get_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.ControlBuilder"
		alias
			"get_ID"
		end

	frozen get_has_asp_code: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"get_HasAspCode"
		end

feature -- Element Change

	frozen set_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ControlBuilder"
		alias
			"set_ID"
		end

feature -- Basic Operations

	frozen create_builder_from_type (parser: WEB_TEMPLATE_PARSER; parent_builder: WEB_CONTROL_BUILDER; type: TYPE; tag_name: SYSTEM_STRING; id: SYSTEM_STRING; attribs: IDICTIONARY; line: INTEGER; source_file_name: SYSTEM_STRING): WEB_CONTROL_BUILDER is
		external
			"IL static signature (System.Web.UI.TemplateParser, System.Web.UI.ControlBuilder, System.Type, System.String, System.String, System.Collections.IDictionary, System.Int32, System.String): System.Web.UI.ControlBuilder use System.Web.UI.ControlBuilder"
		alias
			"CreateBuilderFromType"
		end

	close_control is
		external
			"IL signature (): System.Void use System.Web.UI.ControlBuilder"
		alias
			"CloseControl"
		end

	html_decode_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"HtmlDecodeLiterals"
		end

	append_sub_builder (sub_builder: WEB_CONTROL_BUILDER) is
		external
			"IL signature (System.Web.UI.ControlBuilder): System.Void use System.Web.UI.ControlBuilder"
		alias
			"AppendSubBuilder"
		end

	has_body: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"HasBody"
		end

	init (parser: WEB_TEMPLATE_PARSER; parent_builder: WEB_CONTROL_BUILDER; type: TYPE; tag_name: SYSTEM_STRING; id: SYSTEM_STRING; attribs: IDICTIONARY) is
		external
			"IL signature (System.Web.UI.TemplateParser, System.Web.UI.ControlBuilder, System.Type, System.String, System.String, System.Collections.IDictionary): System.Void use System.Web.UI.ControlBuilder"
		alias
			"Init"
		end

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

	set_tag_inner_text (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ControlBuilder"
		alias
			"SetTagInnerText"
		end

	get_child_control_type (tag_name: SYSTEM_STRING; attribs: IDICTIONARY): TYPE is
		external
			"IL signature (System.String, System.Collections.IDictionary): System.Type use System.Web.UI.ControlBuilder"
		alias
			"GetChildControlType"
		end

	on_append_to_parent_builder (parent_builder: WEB_CONTROL_BUILDER) is
		external
			"IL signature (System.Web.UI.ControlBuilder): System.Void use System.Web.UI.ControlBuilder"
		alias
			"OnAppendToParentBuilder"
		end

	append_literal_string (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ControlBuilder"
		alias
			"AppendLiteralString"
		end

	needs_tag_inner_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"NeedsTagInnerText"
		end

feature {NONE} -- Implementation

	frozen get_fis_non_parser_accessor: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"get_FIsNonParserAccessor"
		end

	frozen get_in_designer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"get_InDesigner"
		end

	frozen get_fchildren_as_properties: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilder"
		alias
			"get_FChildrenAsProperties"
		end

	frozen get_parser: WEB_TEMPLATE_PARSER is
		external
			"IL signature (): System.Web.UI.TemplateParser use System.Web.UI.ControlBuilder"
		alias
			"get_Parser"
		end

end -- class WEB_CONTROL_BUILDER
