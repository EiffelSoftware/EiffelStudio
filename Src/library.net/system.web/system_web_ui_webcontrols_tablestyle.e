indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TableStyle"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLESTYLE

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
	make_tablestyle_1,
	make_tablestyle

feature {NONE} -- Initialization

	frozen make_tablestyle_1 (bag: SYSTEM_WEB_UI_STATEBAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.WebControls.TableStyle"
		end

	frozen make_tablestyle is
		external
			"IL creator use System.Web.UI.WebControls.TableStyle"
		end

feature -- Access

	get_grid_lines: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.TableStyle"
		alias
			"get_GridLines"
		end

	get_back_image_url: STRING is
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

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
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

	set_grid_lines (value: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES) is
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

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"set_HorizontalAlign"
		end

	set_back_image_url (value: STRING) is
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

	copy_from (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"CopyFrom"
		end

	merge_with (s: SYSTEM_WEB_UI_WEBCONTROLS_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"MergeWith"
		end

	add_attributes_to_render_html_text_writer_web_control (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER; owner: SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.TableStyle"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLESTYLE
