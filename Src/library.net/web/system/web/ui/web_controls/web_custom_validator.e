indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.CustomValidator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CUSTOM_VALIDATOR

inherit
	WEB_BASE_VALIDATOR
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
	make_web_custom_validator

feature {NONE} -- Initialization

	frozen make_web_custom_validator is
		external
			"IL creator use System.Web.UI.WebControls.CustomValidator"
		end

feature -- Access

	frozen get_client_validation_function: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CustomValidator"
		alias
			"get_ClientValidationFunction"
		end

feature -- Element Change

	frozen set_client_validation_function (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"set_ClientValidationFunction"
		end

	frozen add_server_validate (value: WEB_SERVER_VALIDATE_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.ServerValidateEventHandler): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"add_ServerValidate"
		end

	frozen remove_server_validate (value: WEB_SERVER_VALIDATE_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.ServerValidateEventHandler): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"remove_ServerValidate"
		end

feature {NONE} -- Implementation

	on_server_validate (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.UI.WebControls.CustomValidator"
		alias
			"OnServerValidate"
		end

	evaluate_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CustomValidator"
		alias
			"EvaluateIsValid"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"AddAttributesToRender"
		end

	control_properties_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CustomValidator"
		alias
			"ControlPropertiesValid"
		end

end -- class WEB_CUSTOM_VALIDATOR
