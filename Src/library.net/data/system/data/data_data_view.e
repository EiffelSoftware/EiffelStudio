indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataView"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_VIEW

inherit
	SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ISERVICE_PROVIDER
	SYSTEM_DLL_IBINDING_LIST
		rename
			remove_sort as system_component_model_ibinding_list_remove_sort,
			remove_index as system_component_model_ibinding_list_remove_index,
			find as system_component_model_ibinding_list_find,
			apply_sort as system_component_model_ibinding_list_apply_sort,
			add_index as system_component_model_ibinding_list_add_index,
			get_sort_direction as system_component_model_ibinding_list_get_sort_direction,
			get_sort_property as system_component_model_ibinding_list_get_sort_property,
			get_is_sorted as system_component_model_ibinding_list_get_is_sorted,
			get_supports_sorting as system_component_model_ibinding_list_get_supports_sorting,
			get_supports_searching as system_component_model_ibinding_list_get_supports_searching,
			get_supports_change_notification as system_component_model_ibinding_list_get_supports_change_notification,
			get_allow_remove as system_component_model_ibinding_list_get_allow_remove,
			get_allow_edit as system_component_model_ibinding_list_get_allow_edit,
			add_new as system_component_model_ibinding_list_add_new,
			get_allow_new as system_component_model_ibinding_list_get_allow_new,
			remove_at as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			clear as system_collections_ilist_clear,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	ILIST
		rename
			remove_at as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			clear as system_collections_ilist_clear,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	ICOLLECTION
		rename
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE
	SYSTEM_DLL_ITYPED_LIST
		rename
			get_item_properties as system_component_model_ityped_list_get_item_properties,
			get_list_name as system_component_model_ityped_list_get_list_name
		end
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_data_data_view,
	make_data_data_view_1,
	make_data_data_view_2

feature {NONE} -- Initialization

	frozen make_data_data_view is
		external
			"IL creator use System.Data.DataView"
		end

	frozen make_data_data_view_1 (table: DATA_DATA_TABLE) is
		external
			"IL creator signature (System.Data.DataTable) use System.Data.DataView"
		end

	frozen make_data_data_view_2 (table: DATA_DATA_TABLE; row_filter: SYSTEM_STRING; sort: SYSTEM_STRING; row_state: DATA_DATA_VIEW_ROW_STATE) is
		external
			"IL creator signature (System.Data.DataTable, System.String, System.String, System.Data.DataViewRowState) use System.Data.DataView"
		end

feature -- Access

	frozen get_row_state_filter: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL signature (): System.Data.DataViewRowState use System.Data.DataView"
		alias
			"get_RowStateFilter"
		end

	frozen get_item (record_index: INTEGER): DATA_DATA_ROW_VIEW is
		external
			"IL signature (System.Int32): System.Data.DataRowView use System.Data.DataView"
		alias
			"get_Item"
		end

	frozen get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataView"
		alias
			"get_Table"
		end

	frozen get_allow_new: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"get_AllowNew"
		end

	frozen get_data_view_manager: DATA_DATA_VIEW_MANAGER is
		external
			"IL signature (): System.Data.DataViewManager use System.Data.DataView"
		alias
			"get_DataViewManager"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataView"
		alias
			"get_Count"
		end

	frozen get_allow_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"get_AllowEdit"
		end

	get_row_filter: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataView"
		alias
			"get_RowFilter"
		end

	frozen get_apply_default_sort: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"get_ApplyDefaultSort"
		end

	frozen get_allow_delete: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"get_AllowDelete"
		end

	frozen get_sort: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataView"
		alias
			"get_Sort"
		end

feature -- Element Change

	frozen set_apply_default_sort (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataView"
		alias
			"set_ApplyDefaultSort"
		end

	frozen set_allow_new (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataView"
		alias
			"set_AllowNew"
		end

	frozen set_sort (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataView"
		alias
			"set_Sort"
		end

	frozen set_row_state_filter (value: DATA_DATA_VIEW_ROW_STATE) is
		external
			"IL signature (System.Data.DataViewRowState): System.Void use System.Data.DataView"
		alias
			"set_RowStateFilter"
		end

	frozen add_list_changed (value: SYSTEM_DLL_LIST_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.Data.DataView"
		alias
			"add_ListChanged"
		end

	frozen set_table (value: DATA_DATA_TABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataView"
		alias
			"set_Table"
		end

	set_row_filter (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataView"
		alias
			"set_RowFilter"
		end

	frozen remove_list_changed (value: SYSTEM_DLL_LIST_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.Data.DataView"
		alias
			"remove_ListChanged"
		end

	frozen set_allow_delete (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataView"
		alias
			"set_AllowDelete"
		end

	frozen set_allow_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataView"
		alias
			"set_AllowEdit"
		end

feature -- Basic Operations

	frozen find_rows_array_object (key: NATIVE_ARRAY [SYSTEM_OBJECT]): NATIVE_ARRAY [DATA_DATA_ROW_VIEW] is
		external
			"IL signature (System.Object[]): System.Data.DataRowView[] use System.Data.DataView"
		alias
			"FindRows"
		end

	frozen find_array_object (key: NATIVE_ARRAY [SYSTEM_OBJECT]): INTEGER is
		external
			"IL signature (System.Object[]): System.Int32 use System.Data.DataView"
		alias
			"Find"
		end

	add_new: DATA_DATA_ROW_VIEW is
		external
			"IL signature (): System.Data.DataRowView use System.Data.DataView"
		alias
			"AddNew"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"EndInit"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"BeginInit"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.DataView"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.DataView"
		alias
			"GetEnumerator"
		end

	frozen find (key: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataView"
		alias
			"Find"
		end

	frozen find_rows (key: SYSTEM_OBJECT): NATIVE_ARRAY [DATA_DATA_ROW_VIEW] is
		external
			"IL signature (System.Object): System.Data.DataRowView[] use System.Data.DataView"
		alias
			"FindRows"
		end

	frozen delete (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataView"
		alias
			"Delete"
		end

feature {NONE} -- Implementation

	frozen system_component_model_ityped_list_get_list_name (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_STRING is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.String use System.Data.DataView"
		alias
			"System.ComponentModel.ITypedList.GetListName"
		end

	frozen system_collections_ilist_set_item (record_index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataView"
		alias
			"System.Collections.IList.set_Item"
		end

	on_list_changed (e: SYSTEM_DLL_LIST_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.ListChangedEventArgs): System.Void use System.Data.DataView"
		alias
			"OnListChanged"
		end

	frozen system_component_model_ibinding_list_apply_sort (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR; direction: SYSTEM_DLL_LIST_SORT_DIRECTION) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.ComponentModel.ListSortDirection): System.Void use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.ApplySort"
		end

	frozen system_component_model_ibinding_list_get_sort_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_SortProperty"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"Reset"
		end

	frozen system_component_model_ibinding_list_get_sort_direction: SYSTEM_DLL_LIST_SORT_DIRECTION is
		external
			"IL signature (): System.ComponentModel.ListSortDirection use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_SortDirection"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataView"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_component_model_ibinding_list_get_supports_change_notification: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_SupportsChangeNotification"
		end

	frozen system_component_model_ibinding_list_get_supports_sorting: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_SupportsSorting"
		end

	frozen get_is_open: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"get_IsOpen"
		end

	frozen system_collections_ilist_get_item (record_index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.DataView"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_component_model_ibinding_list_add_index (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.AddIndex"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"System.Collections.IList.Clear"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataView"
		alias
			"Dispose"
		end

	frozen open is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"Open"
		end

	frozen system_component_model_ibinding_list_get_is_sorted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_IsSorted"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.DataView"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"Close"
		end

	frozen system_component_model_ityped_list_get_item_properties (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.Data.DataView"
		alias
			"System.ComponentModel.ITypedList.GetItemProperties"
		end

	frozen system_component_model_ibinding_list_get_allow_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_AllowEdit"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataView"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_component_model_ibinding_list_remove_sort is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.RemoveSort"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataView"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.DataView"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_component_model_ibinding_list_add_new: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.AddNew"
		end

	frozen system_component_model_ibinding_list_get_supports_searching: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_SupportsSearching"
		end

	frozen system_component_model_ibinding_list_get_allow_new: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_AllowNew"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen update_index is
		external
			"IL signature (): System.Void use System.Data.DataView"
		alias
			"UpdateIndex"
		end

	column_collection_changed (sender: SYSTEM_OBJECT; e: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataView"
		alias
			"ColumnCollectionChanged"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataView"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen system_component_model_ibinding_list_remove_index (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.RemoveIndex"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataView"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_component_model_ibinding_list_get_allow_remove: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.get_AllowRemove"
		end

	frozen system_component_model_ibinding_list_find (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR; key: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.Object): System.Int32 use System.Data.DataView"
		alias
			"System.ComponentModel.IBindingList.Find"
		end

	update_index_boolean (force: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataView"
		alias
			"UpdateIndex"
		end

	index_list_changed (sender: SYSTEM_OBJECT; e: SYSTEM_DLL_LIST_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.ListChangedEventArgs): System.Void use System.Data.DataView"
		alias
			"IndexListChanged"
		end

end -- class DATA_DATA_VIEW
