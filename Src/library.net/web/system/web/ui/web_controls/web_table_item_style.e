indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.TableItemStyle"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TABLE_ITEM_STYLE

inherit
	WEB_STYLE
		redefine
			reset,
			merge_with,
			copy_from,
			add_attributes_to_render_html_text_writer_web_control
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_web_table_item_style,
	make_web_table_item_style_1

feature {NONE} -- Initialization

	frozen make_web_table_item_style is
		external
			"IL creator use System.Web.UI.WebControls.TableItemStyle"
		end

	frozen make_web_table_item_style_1 (bag: WEB_STATE_BAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.WebControls.TableItemStyle"
		end

feature -- Access

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.TableItemStyle"
		alias
			"get_HorizontalAlign"
		end

	get_vertical_align: WEB_VERTICAL_ALIGN is
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

	set_vertical_align (value: WEB_VERTICAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.VerticalAlign): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"set_VerticalAlign"
		end

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
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

	copy_from (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"CopyFrom"
		end

	merge_with (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"MergeWith"
		end

	add_attributes_to_render_html_text_writer_web_control (writer: WEB_HTML_TEXT_WRITER; owner: WEB_WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.TableItemStyle"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_TABLE_ITEM_STYLE
