indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataViewManager"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_VIEW_MANAGER

inherit
	SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT
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
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_count as system_collections_icollection_get_count,
			get_enumerator as system_collections_ienumerable_get_enumerator
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
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_count as system_collections_icollection_get_count,
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_count as system_collections_icollection_get_count,
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_DLL_ITYPED_LIST
		rename
			get_item_properties as system_component_model_ityped_list_get_item_properties,
			get_list_name as system_component_model_ityped_list_get_list_name
		end

create
	make_data_data_view_manager,
	make_data_data_view_manager_1

feature {NONE} -- Initialization

	frozen make_data_data_view_manager is
		external
			"IL creator use System.Data.DataViewManager"
		end

	frozen make_data_data_view_manager_1 (data_set: DATA_DATA_SET) is
		external
			"IL creator signature (System.Data.DataSet) use System.Data.DataViewManager"
		end

feature -- Access

	frozen get_data_view_setting_collection_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataViewManager"
		alias
			"get_DataViewSettingCollectionString"
		end

	frozen get_data_view_settings: DATA_DATA_VIEW_SETTING_COLLECTION is
		external
			"IL signature (): System.Data.DataViewSettingCollection use System.Data.DataViewManager"
		alias
			"get_DataViewSettings"
		end

	frozen get_data_set: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataViewManager"
		alias
			"get_DataSet"
		end

feature -- Element Change

	frozen set_data_set (value: DATA_DATA_SET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Data.DataViewManager"
		alias
			"set_DataSet"
		end

	frozen add_list_changed (value: SYSTEM_DLL_LIST_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.Data.DataViewManager"
		alias
			"add_ListChanged"
		end

	frozen set_data_view_setting_collection_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataViewManager"
		alias
			"set_DataViewSettingCollectionString"
		end

	frozen remove_list_changed (value: SYSTEM_DLL_LIST_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.Data.DataViewManager"
		alias
			"remove_ListChanged"
		end

feature -- Basic Operations

	frozen create_data_view (table: DATA_DATA_TABLE): DATA_DATA_VIEW is
		external
			"IL signature (System.Data.DataTable): System.Data.DataView use System.Data.DataViewManager"
		alias
			"CreateDataView"
		end

feature {NONE} -- Implementation

	frozen system_component_model_ityped_list_get_list_name (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_STRING is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.String use System.Data.DataViewManager"
		alias
			"System.ComponentModel.ITypedList.GetListName"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Contains"
		end

	relation_collection_changed (sender: SYSTEM_OBJECT; e: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataViewManager"
		alias
			"RelationCollectionChanged"
		end

	on_list_changed (e: SYSTEM_DLL_LIST_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.ListChangedEventArgs): System.Void use System.Data.DataViewManager"
		alias
			"OnListChanged"
		end

	frozen system_component_model_ibinding_list_apply_sort (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR; direction: SYSTEM_DLL_LIST_SORT_DIRECTION) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.ComponentModel.ListSortDirection): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.ApplySort"
		end

	frozen system_component_model_ibinding_list_get_sort_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SortProperty"
		end

	frozen system_component_model_ibinding_list_get_sort_direction: SYSTEM_DLL_LIST_SORT_DIRECTION is
		external
			"IL signature (): System.ComponentModel.ListSortDirection use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SortDirection"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.DataViewManager"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_component_model_ibinding_list_get_supports_change_notification: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SupportsChangeNotification"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_component_model_ibinding_list_add_new: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.AddNew"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.DataViewManager"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_component_model_ibinding_list_add_index (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.AddIndex"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_component_model_ibinding_list_get_is_sorted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_IsSorted"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_component_model_ityped_list_get_item_properties (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.Data.DataViewManager"
		alias
			"System.ComponentModel.ITypedList.GetItemProperties"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen system_component_model_ibinding_list_get_allow_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_AllowEdit"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_component_model_ibinding_list_remove_sort is
		external
			"IL signature (): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.RemoveSort"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_component_model_ibinding_list_get_supports_searching: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SupportsSearching"
		end

	frozen system_component_model_ibinding_list_get_supports_sorting: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SupportsSorting"
		end

	frozen system_component_model_ibinding_list_get_allow_new: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_AllowNew"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	table_collection_changed (sender: SYSTEM_OBJECT; e: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataViewManager"
		alias
			"TableCollectionChanged"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_component_model_ibinding_list_remove_index (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.RemoveIndex"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataViewManager"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_component_model_ibinding_list_get_allow_remove: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_AllowRemove"
		end

	frozen system_component_model_ibinding_list_find (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR; key: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.Object): System.Int32 use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.Find"
		end

end -- class DATA_DATA_VIEW_MANAGER
