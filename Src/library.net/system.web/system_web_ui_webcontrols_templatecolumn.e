indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TemplateColumn"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TEMPLATECOLUMN

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN
		redefine
			initialize_cell
		end
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_templatecolumn

feature {NONE} -- Initialization

	frozen make_templatecolumn is
		external
			"IL creator use System.Web.UI.WebControls.TemplateColumn"
		end

feature -- Access

	get_edit_item_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_EditItemTemplate"
		end

	get_header_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_HeaderTemplate"
		end

	get_footer_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_FooterTemplate"
		end

	get_item_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.TemplateColumn"
		alias
			"get_ItemTemplate"
		end

feature -- Element Change

	set_edit_item_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_EditItemTemplate"
		end

	set_header_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_HeaderTemplate"
		end

	set_footer_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_FooterTemplate"
		end

	set_item_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"set_ItemTemplate"
		end

feature -- Basic Operations

	initialize_cell (cell: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL; column_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.TemplateColumn"
		alias
			"InitializeCell"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TEMPLATECOLUMN
