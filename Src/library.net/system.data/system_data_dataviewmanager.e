indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataViewManager"

external class
	SYSTEM_DATA_DATAVIEWMANAGER

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			clear as ilist_clear,
			extend as ilist_extend,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			copy_to as icollection_copy_to,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			get_count as icollection_get_count,
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COMPONENTMODEL_MARSHALBYVALUECOMPONENT
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			get_count as icollection_get_count,
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COMPONENTMODEL_IBINDINGLIST
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
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			clear as ilist_clear,
			extend as ilist_extend,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			copy_to as icollection_copy_to,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			get_count as icollection_get_count,
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_ISERVICEPROVIDER
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ITYPEDLIST
		rename
			get_item_properties as system_component_model_ityped_list_get_item_properties,
			get_list_name as system_component_model_ityped_list_get_list_name
		end

create
	make_dataviewmanager_1,
	make_dataviewmanager

feature {NONE} -- Initialization

	frozen make_dataviewmanager_1 (data_set: SYSTEM_DATA_DATASET) is
		external
			"IL creator signature (System.Data.DataSet) use System.Data.DataViewManager"
		end

	frozen make_dataviewmanager is
		external
			"IL creator use System.Data.DataViewManager"
		end

feature -- Access

	frozen get_data_view_setting_collection_string: STRING is
		external
			"IL signature (): System.String use System.Data.DataViewManager"
		alias
			"get_DataViewSettingCollectionString"
		end

	frozen get_data_view_settings: SYSTEM_DATA_DATAVIEWSETTINGCOLLECTION is
		external
			"IL signature (): System.Data.DataViewSettingCollection use System.Data.DataViewManager"
		alias
			"get_DataViewSettings"
		end

	frozen get_data_set: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataViewManager"
		alias
			"get_DataSet"
		end

feature -- Element Change

	frozen set_data_set (value: SYSTEM_DATA_DATASET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Data.DataViewManager"
		alias
			"set_DataSet"
		end

	frozen add_list_changed (value: SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.Data.DataViewManager"
		alias
			"add_ListChanged"
		end

	frozen set_data_view_setting_collection_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataViewManager"
		alias
			"set_DataViewSettingCollectionString"
		end

	frozen remove_list_changed (value: SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.Data.DataViewManager"
		alias
			"remove_ListChanged"
		end

feature -- Basic Operations

	frozen create_data_view (table: SYSTEM_DATA_DATATABLE): SYSTEM_DATA_DATAVIEW is
		external
			"IL signature (System.Data.DataTable): System.Data.DataView use System.Data.DataViewManager"
		alias
			"CreateDataView"
		end

feature {NONE} -- Implementation

	frozen system_component_model_ityped_list_get_list_name (list_accessors: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]): STRING is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.String use System.Data.DataViewManager"
		alias
			"System.ComponentModel.ITypedList.GetListName"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Contains"
		end

	relation_collection_changed (sender: ANY; e: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataViewManager"
		alias
			"RelationCollectionChanged"
		end

	on_list_changed (e: SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTARGS) is
		external
			"IL signature (System.ComponentModel.ListChangedEventArgs): System.Void use System.Data.DataViewManager"
		alias
			"OnListChanged"
		end

	frozen system_component_model_ibinding_list_apply_sort (property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; direction: SYSTEM_COMPONENTMODEL_LISTSORTDIRECTION) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.ComponentModel.ListSortDirection): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.ApplySort"
		end

	frozen system_component_model_ibinding_list_get_sort_property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SortProperty"
		end

	frozen system_component_model_ibinding_list_get_sort_direction: SYSTEM_COMPONENTMODEL_LISTSORTDIRECTION is
		external
			"IL signature (): System.ComponentModel.ListSortDirection use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.get_SortDirection"
		end

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_component_model_ibinding_list_add_new: ANY is
		external
			"IL signature (): System.Object use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.AddNew"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.DataViewManager"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_component_model_ibinding_list_add_index (property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.AddIndex"
		end

	frozen icollection_get_count: INTEGER is
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

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_component_model_ityped_list_get_item_properties (list_accessors: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.Data.DataViewManager"
		alias
			"System.ComponentModel.ITypedList.GetItemProperties"
		end

	frozen ilist_prune_i_th (index: INTEGER) is
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

	frozen ilist_insert (index: INTEGER; value: ANY) is
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

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
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

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	table_collection_changed (sender: ANY; e: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataViewManager"
		alias
			"TableCollectionChanged"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewManager"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen ilist_clear is
		external
			"IL signature (): System.Void use System.Data.DataViewManager"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_component_model_ibinding_list_remove_index (property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.RemoveIndex"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.DataViewManager"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
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

	frozen system_component_model_ibinding_list_find (property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; key: ANY): INTEGER is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.Object): System.Int32 use System.Data.DataViewManager"
		alias
			"System.ComponentModel.IBindingList.Find"
		end

end -- class SYSTEM_DATA_DATAVIEWMANAGER
