indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Style"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_STYLE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			to_string
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_style_1,
	make_style

feature {NONE} -- Initialization

	frozen make_style_1 (bag: SYSTEM_WEB_UI_STATEBAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.WebControls.Style"
		end

	frozen make_style is
		external
			"IL creator use System.Web.UI.WebControls.Style"
		end

feature -- Access

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.Style"
		alias
			"get_BackColor"
		end

	frozen get_font: SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.Style"
		alias
			"get_Font"
		end

	frozen get_width: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Style"
		alias
			"get_Width"
		end

	frozen get_border_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.Style"
		alias
			"get_BorderColor"
		end

	frozen get_border_width: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Style"
		alias
			"get_BorderWidth"
		end

	frozen get_css_class: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Style"
		alias
			"get_CssClass"
		end

	frozen get_height: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Style"
		alias
			"get_Height"
		end

	frozen get_border_style: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.BorderStyle use System.Web.UI.WebControls.Style"
		alias
			"get_BorderStyle"
		end

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.Style"
		alias
			"get_ForeColor"
		end

feature -- Element Change

	frozen set_border_style (value: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE) is
		external
			"IL signature (System.Web.UI.WebControls.BorderStyle): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_BorderStyle"
		end

	frozen set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_BackColor"
		end

	frozen set_border_width (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_BorderWidth"
		end

	frozen set_border_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_BorderColor"
		end

	frozen set_width (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_Width"
		end

	frozen set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_ForeColor"
		end

	frozen set_height (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_Height"
		end

	frozen set_css_class (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Style"
		alias
			"set_CssClass"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Style"
		alias
			"ToString"
		end

	reset is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Style"
		alias
			"Reset"
		end

	copy_from (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.Style"
		alias
			"CopyFrom"
		end

	merge_with (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.Style"
		alias
			"MergeWith"
		end

	add_attributes_to_render_html_text_writer_web_control (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER; owner: SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.Style"
		alias
			"AddAttributesToRender"
		end

	frozen add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Style"
		alias
			"AddAttributesToRender"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_istate_manager_get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Style"
		alias
			"System.Web.UI.IStateManager.get_IsTrackingViewState"
		end

	frozen load_view_state (state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Style"
		alias
			"LoadViewState"
		end

	get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Style"
		alias
			"get_IsEmpty"
		end

	frozen system_web_ui_istate_manager_track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Style"
		alias
			"System.Web.UI.IStateManager.TrackViewState"
		end

	frozen system_web_ui_istate_manager_save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.Style"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	frozen system_web_ui_istate_manager_load_view_state (state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Style"
		alias
			"System.Web.UI.IStateManager.LoadViewState"
		end

	frozen get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Style"
		alias
			"get_IsTrackingViewState"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.Style"
		alias
			"SaveViewState"
		end

	frozen get_view_state: SYSTEM_WEB_UI_STATEBAG is
		external
			"IL signature (): System.Web.UI.StateBag use System.Web.UI.WebControls.Style"
		alias
			"get_ViewState"
		end

	set_bit (bit_: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.Style"
		alias
			"SetBit"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Style"
		alias
			"TrackViewState"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_STYLE
