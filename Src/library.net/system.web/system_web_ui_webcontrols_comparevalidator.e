indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.CompareValidator"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_COMPAREVALIDATOR

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_WEBCONTROLS_BASECOMPAREVALIDATOR
		redefine
			control_properties_valid,
			add_attributes_to_render
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IVALIDATOR
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_comparevalidator

feature {NONE} -- Initialization

	frozen make_comparevalidator is
		external
			"IL creator use System.Web.UI.WebControls.CompareValidator"
		end

feature -- Access

	frozen get_operator: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONCOMPAREOPERATOR is
		external
			"IL signature (): System.Web.UI.WebControls.ValidationCompareOperator use System.Web.UI.WebControls.CompareValidator"
		alias
			"get_Operator"
		end

	frozen get_value_to_compare: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CompareValidator"
		alias
			"get_ValueToCompare"
		end

	frozen get_control_to_compare: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CompareValidator"
		alias
			"get_ControlToCompare"
		end

feature -- Element Change

	frozen set_operator (value: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONCOMPAREOPERATOR) is
		external
			"IL signature (System.Web.UI.WebControls.ValidationCompareOperator): System.Void use System.Web.UI.WebControls.CompareValidator"
		alias
			"set_Operator"
		end

	frozen set_control_to_compare (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.CompareValidator"
		alias
			"set_ControlToCompare"
		end

	frozen set_value_to_compare (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.CompareValidator"
		alias
			"set_ValueToCompare"
		end

feature {NONE} -- Implementation

	evaluate_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CompareValidator"
		alias
			"EvaluateIsValid"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.CompareValidator"
		alias
			"AddAttributesToRender"
		end

	control_properties_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CompareValidator"
		alias
			"ControlPropertiesValid"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_COMPAREVALIDATOR
