indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.BaseValidator"

deferred external class
	SYSTEM_WEB_UI_WEBCONTROLS_BASEVALIDATOR

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_LABEL
		redefine
			add_attributes_to_render,
			set_fore_color,
			get_fore_color,
			set_enabled,
			get_enabled,
			on_unload,
			render,
			on_pre_render,
			on_init
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IVALIDATOR
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

feature -- Access

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_IsValid"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_ForeColor"
		end

	frozen get_display: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATORDISPLAY is
		external
			"IL signature (): System.Web.UI.WebControls.ValidatorDisplay use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_Display"
		end

	get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_Enabled"
		end

	frozen get_enable_client_script: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_EnableClientScript"
		end

	frozen get_error_message: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_ErrorMessage"
		end

	frozen get_control_to_validate: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_ControlToValidate"
		end

feature -- Element Change

	frozen set_enable_client_script (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_EnableClientScript"
		end

	frozen set_display (value: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATORDISPLAY) is
		external
			"IL signature (System.Web.UI.WebControls.ValidatorDisplay): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_Display"
		end

	frozen set_is_valid (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_IsValid"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_ForeColor"
		end

	set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_Enabled"
		end

	frozen set_error_message (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_ErrorMessage"
		end

	frozen set_control_to_validate (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_ControlToValidate"
		end

feature -- Basic Operations

	frozen validate is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"Validate"
		end

	frozen get_validation_property (component: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL static signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Web.UI.WebControls.BaseValidator"
		alias
			"GetValidationProperty"
		end

feature {NONE} -- Implementation

	frozen check_control_validation_property (name: STRING; property_name: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"CheckControlValidationProperty"
		end

	frozen get_control_render_id (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.WebControls.BaseValidator"
		alias
			"GetControlRenderID"
		end

	on_unload (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"OnUnload"
		end

	frozen get_render_uplevel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_RenderUplevel"
		end

	determine_render_uplevel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"DetermineRenderUplevel"
		end

	frozen register_validator_common_script is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"RegisterValidatorCommonScript"
		end

	frozen get_control_validation_value (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.WebControls.BaseValidator"
		alias
			"GetControlValidationValue"
		end

	frozen get_properties_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_PropertiesValid"
		end

	control_properties_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"ControlPropertiesValid"
		end

	register_validator_declaration is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"RegisterValidatorDeclaration"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"Render"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"OnPreRender"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"AddAttributesToRender"
		end

	on_init (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"OnInit"
		end

	evaluate_is_valid: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"EvaluateIsValid"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_BASEVALIDATOR
