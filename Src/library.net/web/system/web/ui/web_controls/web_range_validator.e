indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RangeValidator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_RANGE_VALIDATOR

inherit
	WEB_BASE_COMPARE_VALIDATOR
		redefine
			control_properties_valid,
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
	make_web_range_validator

feature {NONE} -- Initialization

	frozen make_web_range_validator is
		external
			"IL creator use System.Web.UI.WebControls.RangeValidator"
		end

feature -- Access

	frozen get_minimum_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RangeValidator"
		alias
			"get_MinimumValue"
		end

	frozen get_maximum_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RangeValidator"
		alias
			"get_MaximumValue"
		end

feature -- Element Change

	frozen set_minimum_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.RangeValidator"
		alias
			"set_MinimumValue"
		end

	frozen set_maximum_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.RangeValidator"
		alias
			"set_MaximumValue"
		end

feature {NONE} -- Implementation

	evaluate_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RangeValidator"
		alias
			"EvaluateIsValid"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.RangeValidator"
		alias
			"AddAttributesToRender"
		end

	control_properties_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RangeValidator"
		alias
			"ControlPropertiesValid"
		end

end -- class WEB_RANGE_VALIDATOR
