indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.WebControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_WEB_CONTROL

inherit
	WEB_CONTROL
		redefine
			track_view_state,
			render,
			save_view_state,
			load_view_state
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
	make_web_web_control

feature {NONE} -- Initialization

	frozen make_web_web_control (tag: WEB_HTML_TEXT_WRITER_TAG) is
		external
			"IL creator signature (System.Web.UI.HtmlTextWriterTag) use System.Web.UI.WebControls.WebControl"
		end

feature -- Access

	frozen get_attributes: WEB_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.Web.UI.AttributeCollection use System.Web.UI.WebControls.WebControl"
		alias
			"get_Attributes"
		end

	get_border_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.WebControl"
		alias
			"get_BorderColor"
		end

	get_border_style: WEB_BORDER_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.BorderStyle use System.Web.UI.WebControls.WebControl"
		alias
			"get_BorderStyle"
		end

	get_tool_tip: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_ToolTip"
		end

	get_access_key: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_AccessKey"
		end

	get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.WebControl"
		alias
			"get_Enabled"
		end

	frozen get_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.WebControl"
		alias
			"get_ControlStyle"
		end

	frozen get_control_style_created: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.WebControl"
		alias
			"get_ControlStyleCreated"
		end

	get_height: WEB_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.WebControl"
		alias
			"get_Height"
		end

	get_border_width: WEB_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.WebControl"
		alias
			"get_BorderWidth"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.WebControl"
		alias
			"get_BackColor"
		end

	frozen get_style: WEB_CSS_STYLE_COLLECTION is
		external
			"IL signature (): System.Web.UI.CssStyleCollection use System.Web.UI.WebControls.WebControl"
		alias
			"get_Style"
		end

	get_tab_index: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Web.UI.WebControls.WebControl"
		alias
			"get_TabIndex"
		end

	get_font: WEB_FONT_INFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.WebControl"
		alias
			"get_Font"
		end

	get_css_class: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_CssClass"
		end

	get_width: WEB_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.WebControl"
		alias
			"get_Width"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.WebControl"
		alias
			"get_ForeColor"
		end

feature -- Element Change

	set_border_style (value: WEB_BORDER_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.BorderStyle): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BorderStyle"
		end

	set_css_class (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_CssClass"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BackColor"
		end

	set_border_width (value: WEB_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BorderWidth"
		end

	set_tab_index (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_TabIndex"
		end

	set_tool_tip (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_ToolTip"
		end

	set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_Enabled"
		end

	set_border_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BorderColor"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_ForeColor"
		end

	set_height (value: WEB_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_Height"
		end

	set_width (value: WEB_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_Width"
		end

	set_access_key (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_AccessKey"
		end

feature -- Basic Operations

	frozen apply_style (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"ApplyStyle"
		end

	render_end_tag (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"RenderEndTag"
		end

	frozen merge_style (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"MergeStyle"
		end

	frozen copy_base_attributes (control_src: WEB_WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"CopyBaseAttributes"
		end

	render_begin_tag (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"RenderBeginTag"
		end

feature {NONE} -- Implementation

	get_tag_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_TagName"
		end

	frozen system_web_ui_iattribute_accessor_get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.WebControl"
		alias
			"CreateControlStyle"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"Render"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.WebControl"
		alias
			"SaveViewState"
		end

	render_contents (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"RenderContents"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"AddAttributesToRender"
		end

	get_tag_key: WEB_HTML_TEXT_WRITER_TAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.WebControls.WebControl"
		alias
			"get_TagKey"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"LoadViewState"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"TrackViewState"
		end

end -- class WEB_WEB_CONTROL
