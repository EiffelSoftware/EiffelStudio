indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataGrid"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_DATA_GRID

inherit
	WEB_BASE_DATA_LIST
		redefine
			create_control_style,
			track_view_state,
			on_bubble_event,
			save_view_state,
			load_view_state
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	WEB_INAMING_CONTAINER

create
	make_web_data_grid

feature {NONE} -- Initialization

	frozen make_web_data_grid is
		external
			"IL creator use System.Web.UI.WebControls.DataGrid"
		end

feature -- Access

	get_back_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGrid"
		alias
			"get_BackImageUrl"
		end

	get_pager_style: WEB_DATA_GRID_PAGER_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridPagerStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_PagerStyle"
		end

--	frozen sort_command_name: SYSTEM_STRING is "Sort"

--	frozen select_command_name: SYSTEM_STRING is "Select"

--	frozen edit_command_name: SYSTEM_STRING is "Edit"

	get_selected_item: WEB_DATA_GRID_ITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridItem use System.Web.UI.WebControls.DataGrid"
		alias
			"get_SelectedItem"
		end

	frozen get_current_page_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGrid"
		alias
			"get_CurrentPageIndex"
		end

	get_allow_sorting: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AllowSorting"
		end

	get_allow_paging: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AllowPaging"
		end

	get_page_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGrid"
		alias
			"get_PageSize"
		end

	get_columns: WEB_DATA_GRID_COLUMN_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridColumnCollection use System.Web.UI.WebControls.DataGrid"
		alias
			"get_Columns"
		end

--	frozen page_command_name: SYSTEM_STRING is "Page"

--	frozen update_command_name: SYSTEM_STRING is "Update"

	get_auto_generate_columns: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AutoGenerateColumns"
		end

	get_alternating_item_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AlternatingItemStyle"
		end

	get_items: WEB_DATA_GRID_ITEM_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridItemCollection use System.Web.UI.WebControls.DataGrid"
		alias
			"get_Items"
		end

	get_footer_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_FooterStyle"
		end

--	frozen delete_command_name: SYSTEM_STRING is "Delete"

	get_edit_item_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_EditItemStyle"
		end

	get_selected_item_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_SelectedItemStyle"
		end

	get_edit_item_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGrid"
		alias
			"get_EditItemIndex"
		end

	get_show_header: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_ShowHeader"
		end

	frozen get_page_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGrid"
		alias
			"get_PageCount"
		end

--	frozen cancel_command_name: SYSTEM_STRING is "Cancel"

	get_allow_custom_paging: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AllowCustomPaging"
		end

	get_show_footer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_ShowFooter"
		end

	get_header_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_HeaderStyle"
		end

	get_virtual_item_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGrid"
		alias
			"get_VirtualItemCount"
		end

--	frozen next_page_command_argument: SYSTEM_STRING is "Next"

--	frozen prev_page_command_argument: SYSTEM_STRING is "Prev"

	get_item_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_ItemStyle"
		end

	get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGrid"
		alias
			"get_SelectedIndex"
		end

feature -- Element Change

	frozen remove_update_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_UpdateCommand"
		end

	frozen remove_sort_command (value: WEB_DATA_GRID_SORT_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridSortCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_SortCommand"
		end

	frozen add_delete_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_DeleteCommand"
		end

	frozen add_item_data_bound (value: WEB_DATA_GRID_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_ItemDataBound"
		end

	set_show_footer (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_ShowFooter"
		end

	frozen remove_item_created (value: WEB_DATA_GRID_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_ItemCreated"
		end

	frozen set_current_page_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_CurrentPageIndex"
		end

	set_auto_generate_columns (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_AutoGenerateColumns"
		end

	frozen add_update_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_UpdateCommand"
		end

	set_allow_sorting (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_AllowSorting"
		end

	set_back_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_BackImageUrl"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_SelectedIndex"
		end

	set_show_header (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_ShowHeader"
		end

	set_allow_paging (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_AllowPaging"
		end

	frozen remove_item_data_bound (value: WEB_DATA_GRID_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_ItemDataBound"
		end

	set_page_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_PageSize"
		end

	frozen add_item_created (value: WEB_DATA_GRID_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_ItemCreated"
		end

	frozen add_edit_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_EditCommand"
		end

	set_allow_custom_paging (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_AllowCustomPaging"
		end

	set_virtual_item_count (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_VirtualItemCount"
		end

	frozen remove_delete_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_DeleteCommand"
		end

	frozen remove_cancel_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_CancelCommand"
		end

	frozen remove_page_index_changed (value: WEB_DATA_GRID_PAGE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridPageChangedEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_PageIndexChanged"
		end

	frozen add_cancel_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_CancelCommand"
		end

	frozen remove_item_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_ItemCommand"
		end

	frozen remove_edit_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_EditCommand"
		end

	frozen add_sort_command (value: WEB_DATA_GRID_SORT_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridSortCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_SortCommand"
		end

	set_edit_item_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"set_EditItemIndex"
		end

	frozen add_page_index_changed (value: WEB_DATA_GRID_PAGE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridPageChangedEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_PageIndexChanged"
		end

	frozen add_item_command (value: WEB_DATA_GRID_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_ItemCommand"
		end

feature {NONE} -- Implementation

	prepare_control_hierarchy is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"PrepareControlHierarchy"
		end

	on_update_command (e: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnUpdateCommand"
		end

	create_control_hierarchy (use_data_source: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateControlHierarchy"
		end

	on_item_created (e: WEB_DATA_GRID_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnItemCreated"
		end

	create_item (item_index: INTEGER; data_source_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE): WEB_DATA_GRID_ITEM is
		external
			"IL signature (System.Int32, System.Int32, System.Web.UI.WebControls.ListItemType): System.Web.UI.WebControls.DataGridItem use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateItem"
		end

	on_bubble_event (source: SYSTEM_OBJECT; e: EVENT_ARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"OnBubbleEvent"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"TrackViewState"
		end

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateControlStyle"
		end

	on_item_command (e: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnItemCommand"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGrid"
		alias
			"SaveViewState"
		end

	on_edit_command (e: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnEditCommand"
		end

	initialize_pager (item: WEB_DATA_GRID_ITEM; column_span: INTEGER; paged_data_source: WEB_PAGED_DATA_SOURCE) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItem, System.Int32, System.Web.UI.WebControls.PagedDataSource): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"InitializePager"
		end

	on_cancel_command (e: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnCancelCommand"
		end

	initialize_item (item: WEB_DATA_GRID_ITEM; columns: NATIVE_ARRAY [WEB_DATA_GRID_COLUMN]) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItem, System.Web.UI.WebControls.DataGridColumn[]): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"InitializeItem"
		end

	on_delete_command (e: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnDeleteCommand"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"LoadViewState"
		end

	on_item_data_bound (e: WEB_DATA_GRID_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnItemDataBound"
		end

	create_column_set (data_source: WEB_PAGED_DATA_SOURCE; use_data_source: BOOLEAN): ARRAY_LIST is
		external
			"IL signature (System.Web.UI.WebControls.PagedDataSource, System.Boolean): System.Collections.ArrayList use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateColumnSet"
		end

	on_sort_command (e: WEB_DATA_GRID_SORT_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridSortCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnSortCommand"
		end

	on_page_index_changed (e: WEB_DATA_GRID_PAGE_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridPageChangedEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnPageIndexChanged"
		end

end -- class WEB_DATA_GRID
