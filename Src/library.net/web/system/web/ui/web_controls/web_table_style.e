indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.TableStyle"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TABLE_STYLE

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
	make_web_table_style_1,
	make_web_table_style

feature {NONE} -- Initialization

	frozen make_web_table_style_1 (bag: WEB_STATE_BAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.WebControls.TableStyle"
		end

	frozen make_web_table_style is
		external
			"IL creator use System.Web.UI.WebControls.TableStyle"
		end

feature -- Access

	get_grid_lines: WEB_GRID_LINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.TableStyle"
		alias
			"get_GridLines"
		end

	get_back_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.TableStyle"
		alias
			"get_BackImageUrl"
		end

	get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TableStyle"
		alias
			"get_CellSpacing"
		end

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.TableStyle"
		alias
			"get_HorizontalAlign"
		end

	get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TableStyle"
		alias
			"get_CellPadding"
		end

feature -- Element Change

	set_grid_lines (value: WEB_GRID_LINES) is
		external
			"IL signature (System.Web.UI.WebControls.GridLines): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"set_GridLines"
		end

	set_cell_spacing (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"set_CellSpacing"
		end

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"set_HorizontalAlign"
		end

	set_back_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"set_BackImageUrl"
		end

	set_cell_padding (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"set_CellPadding"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"Reset"
		end

	copy_from (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"CopyFrom"
		end

	merge_with (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"MergeWith"
		end

	add_attributes_to_render_html_text_writer_web_control (writer: WEB_HTML_TEXT_WRITER; owner: WEB_WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_TABLE_STYLE
