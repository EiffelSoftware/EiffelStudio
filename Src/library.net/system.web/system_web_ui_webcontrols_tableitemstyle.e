indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TableItemStyle"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_WEBCONTROLS_STYLE
		redefine
			reset,
			merge_with,
			copy_from,
			add_attributes_to_render_html_text_writer_web_control
		end
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_tableitemstyle_1,
	make_tableitemstyle

feature {NONE} -- Initialization

	frozen make_tableitemstyle_1 (bag: SYSTEM_WEB_UI_STATEBAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.WebControls.TableItemStyle"
		end

	frozen make_tableitemstyle is
		external
			"IL creator use System.Web.UI.WebControls.TableItemStyle"
		end

feature -- Access

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.TableItemStyle"
		alias
			"get_HorizontalAlign"
		end

	get_vertical_align: SYSTEM_WEB_UI_WEBCONTROLS_VERTICALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.VerticalAlign use System.Web.UI.WebControls.TableItemStyle"
		alias
			"get_VerticalAlign"
		end

	get_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TableItemStyle"
		alias
			"get_Wrap"
		end

feature -- Element Change

	set_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"set_Wrap"
		end

	set_vertical_align (value: SYSTEM_WEB_UI_WEBCONTROLS_VERTICALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.VerticalAlign): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"set_VerticalAlign"
		end

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"set_HorizontalAlign"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"Reset"
		end

	copy_from (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"CopyFrom"
		end

	merge_with (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"MergeWith"
		end

	add_attributes_to_render_html_text_writer_web_control (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER; owner: SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE
