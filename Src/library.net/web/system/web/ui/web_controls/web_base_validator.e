indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.BaseValidator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_BASE_VALIDATOR

inherit
	WEB_LABEL
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

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_IsValid"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_ForeColor"
		end

	frozen get_display: WEB_VALIDATOR_DISPLAY is
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

	frozen get_error_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseValidator"
		alias
			"get_ErrorMessage"
		end

	frozen get_control_to_validate: SYSTEM_STRING is
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

	frozen set_display (value: WEB_VALIDATOR_DISPLAY) is
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

	set_fore_color (value: DRAWING_COLOR) is
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

	frozen set_error_message (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"set_ErrorMessage"
		end

	frozen set_control_to_validate (value: SYSTEM_STRING) is
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

	frozen get_validation_property (component: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL static signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Web.UI.WebControls.BaseValidator"
		alias
			"GetValidationProperty"
		end

feature {NONE} -- Implementation

	frozen check_control_validation_property (name: SYSTEM_STRING; property_name: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"CheckControlValidationProperty"
		end

	frozen get_control_render_id (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.WebControls.BaseValidator"
		alias
			"GetControlRenderID"
		end

	on_unload (e: EVENT_ARGS) is
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

	frozen get_control_validation_value (name: SYSTEM_STRING): SYSTEM_STRING is
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

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"Render"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"OnPreRender"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseValidator"
		alias
			"AddAttributesToRender"
		end

	on_init (e: EVENT_ARGS) is
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

end -- class WEB_BASE_VALIDATOR
