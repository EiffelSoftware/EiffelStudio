indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Panel"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_PANEL

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			add_attributes_to_render
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_panel

feature {NONE} -- Initialization

	frozen make_panel is
		external
			"IL creator use System.Web.UI.WebControls.Panel"
		end

feature -- Access

	get_back_image_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Panel"
		alias
			"get_BackImageUrl"
		end

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.Panel"
		alias
			"get_HorizontalAlign"
		end

	get_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Panel"
		alias
			"get_Wrap"
		end

feature -- Element Change

	set_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"set_Wrap"
		end

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"set_HorizontalAlign"
		end

	set_back_image_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"set_BackImageUrl"
		end

feature {NONE} -- Implementation

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_PANEL
