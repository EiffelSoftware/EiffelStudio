indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.TemplateColumn"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TEMPLATE_COLUMN

inherit
	WEB_DATA_GRID_COLUMN
		redefine
			initialize_cell
		end
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_web_template_column

feature {NONE} -- Initialization

	frozen make_web_template_column is
		external
			"IL creator use System.Web.UI.WebControls.TemplateColumn"
		end

feature -- Access

	get_edit_item_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_EditItemTemplate"
		end

	get_header_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_HeaderTemplate"
		end

	get_footer_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_FooterTemplate"
		end

	get_item_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_ItemTemplate"
		end

feature -- Element Change

	set_edit_item_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_EditItemTemplate"
		end

	set_header_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_HeaderTemplate"
		end

	set_footer_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_FooterTemplate"
		end

	set_item_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_ItemTemplate"
		end

feature -- Basic Operations

	initialize_cell (cell: WEB_TABLE_CELL; column_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"InitializeCell"
		end

end -- class WEB_TEMPLATE_COLUMN
