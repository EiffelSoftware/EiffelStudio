indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataList"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATALIST

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_BASEDATALIST
		redefine
			set_grid_lines,
			get_grid_lines,
			render_contents,
			create_control_style,
			track_view_state,
			on_bubble_event,
			save_view_state,
			load_view_state
		end
	SYSTEM_WEB_UI_WEBCONTROLS_IREPEATINFOUSER
		rename
			render_item as system_web_ui_web_controls_irepeat_info_user_render_item,
			get_item_style as system_web_ui_web_controls_irepeat_info_user_get_item_style,
			get_repeated_item_count as system_web_ui_web_controls_irepeat_info_user_get_repeated_item_count,
			get_has_separators as system_web_ui_web_controls_irepeat_info_user_get_has_separators,
			get_has_header as system_web_ui_web_controls_irepeat_info_user_get_has_header,
			get_has_footer as system_web_ui_web_controls_irepeat_info_user_get_has_footer
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_INAMINGCONTAINER
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end

create
	make_datalist

feature {NONE} -- Initialization

	frozen make_datalist is
		external
			"IL creator use System.Web.UI.WebControls.DataList"
		end

feature -- Access

	get_header_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_HeaderTemplate"
		end

	get_selected_item: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataListItem use System.Web.UI.WebControls.DataList"
		alias
			"get_SelectedItem"
		end

	get_item_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_ItemTemplate"
		end

	get_separator_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_SeparatorTemplate"
		end

	get_extract_template_rows: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"get_ExtractTemplateRows"
		end

	get_selected_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_SelectedItemStyle"
		end

	get_alternating_item_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_AlternatingItemTemplate"
		end

	get_alternating_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_AlternatingItemStyle"
		end

	get_items: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataListItemCollection use System.Web.UI.WebControls.DataList"
		alias
			"get_Items"
		end

	get_footer_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_FooterStyle"
		end

	get_edit_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_EditItemStyle"
		end

	get_repeat_layout: SYSTEM_WEB_UI_WEBCONTROLS_REPEATLAYOUT is
		external
			"IL signature (): System.Web.UI.WebControls.RepeatLayout use System.Web.UI.WebControls.DataList"
		alias
			"get_RepeatLayout"
		end

	get_edit_item_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataList"
		alias
			"get_EditItemIndex"
		end

	get_selected_item_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_SelectedItemTemplate"
		end

	get_show_header: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"get_ShowHeader"
		end

	get_repeat_direction: SYSTEM_WEB_UI_WEBCONTROLS_REPEATDIRECTION is
		external
			"IL signature (): System.Web.UI.WebControls.RepeatDirection use System.Web.UI.WebControls.DataList"
		alias
			"get_RepeatDirection"
		end

	get_grid_lines: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.DataList"
		alias
			"get_GridLines"
		end

	get_repeat_columns: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataList"
		alias
			"get_RepeatColumns"
		end

	get_show_footer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"get_ShowFooter"
		end

	get_header_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_HeaderStyle"
		end

	get_footer_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_FooterTemplate"
		end

	get_edit_item_template: SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.DataList"
		alias
			"get_EditItemTemplate"
		end

	get_separator_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_SeparatorStyle"
		end

	get_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataList"
		alias
			"get_ItemStyle"
		end

	get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataList"
		alias
			"get_SelectedIndex"
		end

feature -- Element Change

	set_alternating_item_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_AlternatingItemTemplate"
		end

	set_extract_template_rows (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_ExtractTemplateRows"
		end

	set_grid_lines (value: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES) is
		external
			"IL signature (System.Web.UI.WebControls.GridLines): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_GridLines"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_SelectedIndex"
		end

	set_show_footer (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_ShowFooter"
		end

	frozen add_delete_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_DeleteCommand"
		end

	set_repeat_layout (value: SYSTEM_WEB_UI_WEBCONTROLS_REPEATLAYOUT) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatLayout): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_RepeatLayout"
		end

	set_edit_item_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_EditItemIndex"
		end

	frozen remove_item_created (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItemEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_ItemCreated"
		end

	frozen remove_update_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_UpdateCommand"
		end

	frozen add_update_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_UpdateCommand"
		end

	frozen add_cancel_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_CancelCommand"
		end

	set_edit_item_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_EditItemTemplate"
		end

	set_repeat_direction (value: SYSTEM_WEB_UI_WEBCONTROLS_REPEATDIRECTION) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatDirection): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_RepeatDirection"
		end

	frozen add_item_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_ItemCommand"
		end

	set_footer_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_FooterTemplate"
		end

	set_show_header (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_ShowHeader"
		end

	set_selected_item_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_SelectedItemTemplate"
		end

	frozen add_item_created (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItemEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_ItemCreated"
		end

	frozen add_edit_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_EditCommand"
		end

	frozen add_item_data_bound (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItemEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"add_ItemDataBound"
		end

	frozen remove_delete_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_DeleteCommand"
		end

	frozen remove_cancel_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_CancelCommand"
		end

	set_separator_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_SeparatorTemplate"
		end

	set_header_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_HeaderTemplate"
		end

	set_repeat_columns (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_RepeatColumns"
		end

	frozen remove_item_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_ItemCommand"
		end

	frozen remove_edit_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_EditCommand"
		end

	frozen remove_item_data_bound (value: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItemEventHandler): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"remove_ItemDataBound"
		end

	set_item_template (value: SYSTEM_WEB_UI_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"set_ItemTemplate"
		end

feature {NONE} -- Implementation

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"RenderContents"
		end

	prepare_control_hierarchy is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"PrepareControlHierarchy"
		end

	on_update_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnUpdateCommand"
		end

	create_control_hierarchy (use_data_source: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"CreateControlHierarchy"
		end

	on_item_created (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItemEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnItemCreated"
		end

	create_item (item_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE): SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM is
		external
			"IL signature (System.Int32, System.Web.UI.WebControls.ListItemType): System.Web.UI.WebControls.DataListItem use System.Web.UI.WebControls.DataList"
		alias
			"CreateItem"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_render_item (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE; repeat_index: INTEGER; repeat_info: SYSTEM_WEB_UI_WEBCONTROLS_REPEATINFO; writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType, System.Int32, System.Web.UI.WebControls.RepeatInfo, System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.RenderItem"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"TrackViewState"
		end

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"LoadViewState"
		end

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.DataList"
		alias
			"CreateControlStyle"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_repeated_item_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_RepeatedItemCount"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataList"
		alias
			"SaveViewState"
		end

	on_edit_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnEditCommand"
		end

	on_item_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnItemCommand"
		end

	on_cancel_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnCancelCommand"
		end

	initialize_item (item: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItem): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"InitializeItem"
		end

	on_delete_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListCommandEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnDeleteCommand"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_has_header: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_HasHeader"
		end

	on_item_data_bound (e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataListItemEventArgs): System.Void use System.Web.UI.WebControls.DataList"
		alias
			"OnItemDataBound"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_has_separators: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_HasSeparators"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_has_footer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_HasFooter"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_item_style (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE; repeat_index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType, System.Int32): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.DataList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.GetItemStyle"
		end

	on_bubble_event (source: ANY; e: SYSTEM_EVENTARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.WebControls.DataList"
		alias
			"OnBubbleEvent"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATALIST
