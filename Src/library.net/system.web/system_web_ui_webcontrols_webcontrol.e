indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.WebControl"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL

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
	SYSTEM_WEB_UI_CONTROL
		redefine
			track_view_state,
			render,
			save_view_state,
			load_view_state
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_webcontrol

feature {NONE} -- Initialization

	frozen make_webcontrol (tag: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG) is
		external
			"IL creator signature (System.Web.UI.HtmlTextWriterTag) use System.Web.UI.WebControls.WebControl"
		end

feature -- Access

	frozen get_attributes: SYSTEM_WEB_UI_ATTRIBUTECOLLECTION is
		external
			"IL signature (): System.Web.UI.AttributeCollection use System.Web.UI.WebControls.WebControl"
		alias
			"get_Attributes"
		end

	get_border_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.WebControl"
		alias
			"get_BorderColor"
		end

	get_border_style: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.BorderStyle use System.Web.UI.WebControls.WebControl"
		alias
			"get_BorderStyle"
		end

	get_tool_tip: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_ToolTip"
		end

	get_access_key: STRING is
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

	frozen get_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
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

	get_height: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.WebControl"
		alias
			"get_Height"
		end

	get_border_width: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.WebControl"
		alias
			"get_BorderWidth"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.WebControl"
		alias
			"get_BackColor"
		end

	frozen get_style: SYSTEM_WEB_UI_CSSSTYLECOLLECTION is
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

	get_font: SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.WebControl"
		alias
			"get_Font"
		end

	get_css_class: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_CssClass"
		end

	get_width: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.WebControl"
		alias
			"get_Width"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.WebControl"
		alias
			"get_ForeColor"
		end

feature -- Element Change

	set_border_style (value: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE) is
		external
			"IL signature (System.Web.UI.WebControls.BorderStyle): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BorderStyle"
		end

	set_css_class (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_CssClass"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BackColor"
		end

	set_border_width (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
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

	set_tool_tip (value: STRING) is
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

	set_border_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_BorderColor"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_ForeColor"
		end

	set_height (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_Height"
		end

	set_width (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_Width"
		end

	set_access_key (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"set_AccessKey"
		end

feature -- Basic Operations

	frozen apply_style (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"ApplyStyle"
		end

	render_end_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"RenderEndTag"
		end

	frozen merge_style (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"MergeStyle"
		end

	frozen copy_base_attributes (control_src: SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL) is
		external
			"IL signature (System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"CopyBaseAttributes"
		end

	render_begin_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"RenderBeginTag"
		end

feature {NONE} -- Implementation

	get_tag_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"get_TagName"
		end

	frozen system_web_ui_iattribute_accessor_get_attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.WebControls.WebControl"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.WebControl"
		alias
			"CreateControlStyle"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"Render"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.WebControl"
		alias
			"SaveViewState"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"RenderContents"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.WebControl"
		alias
			"AddAttributesToRender"
		end

	get_tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.WebControls.WebControl"
		alias
			"get_TagKey"
		end

	load_view_state (saved_state: ANY) is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
