indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlInputControl"

deferred external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTCONTROL

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
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTROL
		redefine
			render_attributes
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

feature -- Access

	frozen get_type_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputControl"
		alias
			"get_Type"
		end

	get_value: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputControl"
		alias
			"get_Value"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputControl"
		alias
			"get_Name"
		end

feature -- Element Change

	set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputControl"
		alias
			"set_Name"
		end

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputControl"
		alias
			"set_Value"
		end

feature {NONE} -- Implementation

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlInputControl"
		alias
			"RenderAttributes"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTCONTROL
