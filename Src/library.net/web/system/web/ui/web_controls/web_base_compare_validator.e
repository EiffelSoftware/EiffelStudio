indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.BaseCompareValidator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_BASE_COMPARE_VALIDATOR

inherit
	WEB_BASE_VALIDATOR
		redefine
			determine_render_uplevel,
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

feature -- Access

	frozen get_type_validation_data_type: WEB_VALIDATION_DATA_TYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ValidationDataType use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: WEB_VALIDATION_DATA_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ValidationDataType): System.Void use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"set_Type"
		end

feature -- Basic Operations

	frozen can_convert (text: SYSTEM_STRING; type: WEB_VALIDATION_DATA_TYPE): BOOLEAN is
		external
			"IL static signature (System.String, System.Web.UI.WebControls.ValidationDataType): System.Boolean use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"CanConvert"
		end

feature {NONE} -- Implementation

	determine_render_uplevel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"DetermineRenderUplevel"
		end

	frozen convert (text: SYSTEM_STRING; type: WEB_VALIDATION_DATA_TYPE; value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.String, System.Web.UI.WebControls.ValidationDataType, System.Object&): System.Boolean use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"Convert"
		end

	frozen compare (left_text: SYSTEM_STRING; right_text: SYSTEM_STRING; op: WEB_VALIDATION_COMPARE_OPERATOR; type: WEB_VALIDATION_DATA_TYPE): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.Web.UI.WebControls.ValidationCompareOperator, System.Web.UI.WebControls.ValidationDataType): System.Boolean use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"Compare"
		end

	frozen get_full_year (short_year: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"GetFullYear"
		end

	frozen get_date_element_order: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"GetDateElementOrder"
		end

	frozen get_cutoff_year: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"get_CutoffYear"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_BASE_COMPARE_VALIDATOR
