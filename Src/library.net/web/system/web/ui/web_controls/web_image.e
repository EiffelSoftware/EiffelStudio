indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Image"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_IMAGE

inherit
	WEB_WEB_CONTROL
		redefine
			render_contents,
			add_attributes_to_render,
			get_font,
			set_enabled,
			get_enabled
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
	make_web_image

feature {NONE} -- Initialization

	frozen make_web_image is
		external
			"IL creator use System.Web.UI.WebControls.Image"
		end

feature -- Access

	get_alternate_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Image"
		alias
			"get_AlternateText"
		end

	get_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Image"
		alias
			"get_ImageUrl"
		end

	get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Image"
		alias
			"get_Enabled"
		end

	get_font: WEB_FONT_INFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.Image"
		alias
			"get_Font"
		end

	get_image_align: WEB_IMAGE_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.ImageAlign use System.Web.UI.WebControls.Image"
		alias
			"get_ImageAlign"
		end

feature -- Element Change

	set_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Image"
		alias
			"set_ImageUrl"
		end

	set_image_align (value: WEB_IMAGE_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.ImageAlign): System.Void use System.Web.UI.WebControls.Image"
		alias
			"set_ImageAlign"
		end

	set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Image"
		alias
			"set_Enabled"
		end

	set_alternate_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Image"
		alias
			"set_AlternateText"
		end

feature {NONE} -- Implementation

	render_contents (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Image"
		alias
			"RenderContents"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Image"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_IMAGE
