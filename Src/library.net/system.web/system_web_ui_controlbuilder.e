indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ControlBuilder"

external class
	SYSTEM_WEB_UI_CONTROLBUILDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.ControlBuilder"
		end

feature -- Access

	frozen get_tag_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.ControlBuilder"
		alias
			"get_TagName"
		end

	frozen get_naming_container_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.ControlBuilder"
		alias
			"get_NamingContainerType"
		end

	frozen get_control_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.ControlBuilder"
		alias
			"get_ControlType"
		end

	frozen get_id: STRING is
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

	frozen set_id (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ControlBuilder"
		alias
			"set_ID"
		end

feature -- Basic Operations

	frozen create_builder_from_type (parser: SYSTEM_WEB_UI_TEMPLATEPARSER; parent_builder: SYSTEM_WEB_UI_CONTROLBUILDER; type: SYSTEM_TYPE; tag_name: STRING; id: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY; line: INTEGER; source_file_name: STRING): SYSTEM_WEB_UI_CONTROLBUILDER is
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

	append_sub_builder (sub_builder: SYSTEM_WEB_UI_CONTROLBUILDER) is
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

	init (parser: SYSTEM_WEB_UI_TEMPLATEPARSER; parent_builder: SYSTEM_WEB_UI_CONTROLBUILDER; type: SYSTEM_TYPE; tag_name: STRING; id: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY) is
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

	set_tag_inner_text (text: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ControlBuilder"
		alias
			"SetTagInnerText"
		end

	get_child_control_type (tag_name: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Collections.IDictionary): System.Type use System.Web.UI.ControlBuilder"
		alias
			"GetChildControlType"
		end

	on_append_to_parent_builder (parent_builder: SYSTEM_WEB_UI_CONTROLBUILDER) is
		external
			"IL signature (System.Web.UI.ControlBuilder): System.Void use System.Web.UI.ControlBuilder"
		alias
			"OnAppendToParentBuilder"
		end

	append_literal_string (s: STRING) is
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

	frozen get_parser: SYSTEM_WEB_UI_TEMPLATEPARSER is
		external
			"IL signature (): System.Web.UI.TemplateParser use System.Web.UI.ControlBuilder"
		alias
			"get_Parser"
		end

end -- class SYSTEM_WEB_UI_CONTROLBUILDER
