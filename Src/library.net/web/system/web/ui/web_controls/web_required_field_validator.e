indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RequiredFieldValidator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_REQUIRED_FIELD_VALIDATOR

inherit
	WEB_BASE_VALIDATOR
		redefine
			add_attributes_to_render
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	WEB_IVALIDATOR

create
	make_web_required_field_validator

feature {NONE} -- Initialization

	frozen make_web_required_field_validator is
		external
			"IL creator use System.Web.UI.WebControls.RequiredFieldValidator"
		end

feature -- Access

	frozen get_initial_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RequiredFieldValidator"
		alias
			"get_InitialValue"
		end

feature -- Element Change

	frozen set_initial_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.RequiredFieldValidator"
		alias
			"set_InitialValue"
		end

feature {NONE} -- Implementation

	evaluate_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RequiredFieldValidator"
		alias
			"EvaluateIsValid"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.RequiredFieldValidator"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_REQUIRED_FIELD_VALIDATOR
