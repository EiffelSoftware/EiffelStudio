indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlImage"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLIMAGE

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

create
	make_htmlimage

feature {NONE} -- Initialization

	frozen make_htmlimage is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlImage"
		end

feature -- Access

	frozen get_border: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"get_Border"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"get_Height"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"get_Width"
		end

	frozen get_align: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"get_Align"
		end

	frozen get_alt: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"get_Alt"
		end

	frozen get_src: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"get_Src"
		end

feature -- Element Change

	frozen set_align (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"set_Align"
		end

	frozen set_src (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"set_Src"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"set_Width"
		end

	frozen set_border (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"set_Border"
		end

	frozen set_alt (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"set_Alt"
		end

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"set_Height"
		end

feature {NONE} -- Implementation

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlImage"
		alias
			"RenderAttributes"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLIMAGE
