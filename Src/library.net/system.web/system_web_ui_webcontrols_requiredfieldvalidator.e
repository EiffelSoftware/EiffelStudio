indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RequiredFieldValidator"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_REQUIREDFIELDVALIDATOR

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
			add_attributes_to_render
		end

create
	make_requiredfieldvalidator

feature {NONE} -- Initialization

	frozen make_requiredfieldvalidator is
		external
			"IL creator use System.Web.UI.WebControls.RequiredFieldValidator"
		end

feature -- Access

	frozen get_initial_value: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RequiredFieldValidator"
		alias
			"get_InitialValue"
		end

feature -- Element Change

	frozen set_initial_value (value: STRING) is
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

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.RequiredFieldValidator"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REQUIREDFIELDVALIDATOR
