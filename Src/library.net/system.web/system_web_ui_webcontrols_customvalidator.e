indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.CustomValidator"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_CUSTOMVALIDATOR

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
			control_properties_valid,
			add_attributes_to_render
		end

create
	make_customvalidator

feature {NONE} -- Initialization

	frozen make_customvalidator is
		external
			"IL creator use System.Web.UI.WebControls.CustomValidator"
		end

feature -- Access

	frozen get_client_validation_function: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CustomValidator"
		alias
			"get_ClientValidationFunction"
		end

feature -- Element Change

	frozen set_client_validation_function (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"set_ClientValidationFunction"
		end

	frozen add_server_validate (value: SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.ServerValidateEventHandler): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"add_ServerValidate"
		end

	frozen remove_server_validate (value: SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.ServerValidateEventHandler): System.Void use System.Web.UI.WebControls.CustomValidator"
		alias
			"remove_ServerValidate"
		end

feature {NONE} -- Implementation

	on_server_validate (value: STRING): BOOLEAN is
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

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_CUSTOMVALIDATOR
