indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.BaseCompareValidator"

deferred external class
	SYSTEM_WEB_UI_WEBCONTROLS_BASECOMPAREVALIDATOR

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IVALIDATOR
	SYSTEM_WEB_UI_WEBCONTROLS_BASEVALIDATOR
		redefine
			determine_render_uplevel,
			add_attributes_to_render
		end

feature -- Access

	frozen get_type_validation_data_type: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONDATATYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ValidationDataType use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONDATATYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ValidationDataType): System.Void use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"set_Type"
		end

feature -- Basic Operations

	frozen can_convert (text: STRING; type: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONDATATYPE): BOOLEAN is
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

	frozen convert (text: STRING; type: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONDATATYPE; value: ANY): BOOLEAN is
		external
			"IL static signature (System.String, System.Web.UI.WebControls.ValidationDataType, System.Object&): System.Boolean use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"Convert"
		end

	frozen compare (left_text: STRING; right_text: STRING; op: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONCOMPAREOPERATOR; type: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONDATATYPE): BOOLEAN is
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

	frozen get_date_element_order: STRING is
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

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseCompareValidator"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_BASECOMPAREVALIDATOR
