indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.BoundColumn"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_BOUNDCOLUMN

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN
		redefine
			initialize_cell,
			initialize
		end
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_boundcolumn

feature {NONE} -- Initialization

	frozen make_boundcolumn is
		external
			"IL creator use System.Web.UI.WebControls.BoundColumn"
		end

feature -- Access

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BoundColumn"
		alias
			"get_ReadOnly"
		end

	get_data_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"get_DataField"
		end

	get_data_format_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"get_DataFormatString"
		end

	frozen this_expr: STRING is
		external
			"IL static_field signature :System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"thisExpr"
		end

feature -- Element Change

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"set_ReadOnly"
		end

	set_data_format_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"set_DataFormatString"
		end

	set_data_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"set_DataField"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"Initialize"
		end

	initialize_cell (cell: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL; column_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"InitializeCell"
		end

feature {NONE} -- Implementation

	format_data_value (data_value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"FormatDataValue"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_BOUNDCOLUMN
