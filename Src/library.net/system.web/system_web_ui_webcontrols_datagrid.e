indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGrid"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRID

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_WEB_UI_WEBCONTROLS_BASEDATALIST
		redefine
			create_control_style,
			track_view_state,
			on_bubble_event,
			save_view_state,
			load_view_state
		end
	SYSTEM_WEB_UI_INAMINGCONTAINER
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_datagrid

feature {NONE} -- Initialization

	frozen make_datagrid is
		external
			"IL creator use System.Web.UI.WebControls.DataGrid"
		end

feature -- Access

	get_back_image_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGrid"
		alias
			"get_BackImageUrl"
		end

	get_pager_style: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGERSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridPagerStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_PagerStyle"
		end

	get_selected_item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM is
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

	get_columns: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMNCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridColumnCollection use System.Web.UI.WebControls.DataGrid"
		alias
			"get_Columns"
		end

	get_auto_generate_columns: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AutoGenerateColumns"
		end

	get_alternating_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_AlternatingItemStyle"
		end

	get_items: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridItemCollection use System.Web.UI.WebControls.DataGrid"
		alias
			"get_Items"
		end

	get_footer_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_FooterStyle"
		end

	get_edit_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGrid"
		alias
			"get_EditItemStyle"
		end

	get_selected_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
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

	get_header_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
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

	get_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
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

	frozen remove_update_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_UpdateCommand"
		end

	frozen remove_sort_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridSortCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_SortCommand"
		end

	frozen add_delete_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_DeleteCommand"
		end

	frozen add_item_data_bound (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTHANDLER) is
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

	frozen remove_item_created (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTHANDLER) is
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

	frozen add_update_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
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

	set_back_image_url (value: STRING) is
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

	frozen remove_item_data_bound (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTHANDLER) is
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

	frozen add_item_created (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_ItemCreated"
		end

	frozen add_edit_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
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

	frozen remove_delete_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_DeleteCommand"
		end

	frozen remove_cancel_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_CancelCommand"
		end

	frozen remove_page_index_changed (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridPageChangedEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_PageIndexChanged"
		end

	frozen add_cancel_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_CancelCommand"
		end

	frozen remove_item_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_ItemCommand"
		end

	frozen remove_edit_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"remove_EditCommand"
		end

	frozen add_sort_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTHANDLER) is
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

	frozen add_page_index_changed (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridPageChangedEventHandler): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"add_PageIndexChanged"
		end

	frozen add_item_command (value: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTHANDLER) is
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

	on_update_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS) is
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

	on_item_created (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnItemCreated"
		end

	create_item (item_index: INTEGER; data_source_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE): SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM is
		external
			"IL signature (System.Int32, System.Int32, System.Web.UI.WebControls.ListItemType): System.Web.UI.WebControls.DataGridItem use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateItem"
		end

	on_bubble_event (source: ANY; e: SYSTEM_EVENTARGS): BOOLEAN is
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

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateControlStyle"
		end

	on_item_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnItemCommand"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGrid"
		alias
			"SaveViewState"
		end

	on_edit_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnEditCommand"
		end

	initialize_pager (item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM; column_span: INTEGER; paged_data_source: SYSTEM_WEB_UI_WEBCONTROLS_PAGEDDATASOURCE) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItem, System.Int32, System.Web.UI.WebControls.PagedDataSource): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"InitializePager"
		end

	on_cancel_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnCancelCommand"
		end

	initialize_item (item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM; columns: ARRAY [SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN]) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItem, System.Web.UI.WebControls.DataGridColumn[]): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"InitializeItem"
		end

	on_delete_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnDeleteCommand"
		end

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"LoadViewState"
		end

	on_item_data_bound (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridItemEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnItemDataBound"
		end

	create_column_set (data_source: SYSTEM_WEB_UI_WEBCONTROLS_PAGEDDATASOURCE; use_data_source: BOOLEAN): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (System.Web.UI.WebControls.PagedDataSource, System.Boolean): System.Collections.ArrayList use System.Web.UI.WebControls.DataGrid"
		alias
			"CreateColumnSet"
		end

	on_sort_command (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridSortCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnSortCommand"
		end

	on_page_index_changed (e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridPageChangedEventArgs): System.Void use System.Web.UI.WebControls.DataGrid"
		alias
			"OnPageIndexChanged"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRID
