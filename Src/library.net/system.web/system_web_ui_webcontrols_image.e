indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Image"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_IMAGE

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			render_contents,
			add_attributes_to_render,
			get_font,
			set_enabled,
			get_enabled
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
	make_image

feature {NONE} -- Initialization

	frozen make_image is
		external
			"IL creator use System.Web.UI.WebControls.Image"
		end

feature -- Access

	get_alternate_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Image"
		alias
			"get_AlternateText"
		end

	get_image_url: STRING is
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

	get_font: SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.Image"
		alias
			"get_Font"
		end

	get_image_align: SYSTEM_WEB_UI_WEBCONTROLS_IMAGEALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.ImageAlign use System.Web.UI.WebControls.Image"
		alias
			"get_ImageAlign"
		end

feature -- Element Change

	set_image_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Image"
		alias
			"set_ImageUrl"
		end

	set_image_align (value: SYSTEM_WEB_UI_WEBCONTROLS_IMAGEALIGN) is
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

	set_alternate_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Image"
		alias
			"set_AlternateText"
		end

feature {NONE} -- Implementation

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Image"
		alias
			"RenderContents"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Image"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_IMAGE
