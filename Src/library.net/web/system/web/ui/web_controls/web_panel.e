indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Panel"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PANEL

inherit
	WEB_WEB_CONTROL
		redefine
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

create
	make_web_panel

feature {NONE} -- Initialization

	frozen make_web_panel is
		external
			"IL creator use System.Web.UI.WebControls.Panel"
		end

feature -- Access

	get_back_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Panel"
		alias
			"get_BackImageUrl"
		end

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
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

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"set_HorizontalAlign"
		end

	set_back_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"set_BackImageUrl"
		end

feature {NONE} -- Implementation

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Panel"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_PANEL
