indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.GridColumnStylesCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_GRID_COLUMN_STYLES_COLLECTION

inherit
	WINFORMS_BASE_COLLECTION
		rename
			get_count as system_collections_icollection_get_count
		redefine
			system_collections_icollection_get_count,
			get_list
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count,
			copy_to as system_collections_icollection_copy_to
		select
			system_collections_ienumerable_get_enumerator,
			system_collections_icollection_get_sync_root,
			system_collections_icollection_get_is_synchronized,
			system_collections_icollection_copy_to
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ILIST
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count,
			copy_to as system_collections_icollection_copy_to,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			remove_at as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			clear as system_collections_ilist_clear,
			add as system_collections_ilist_add
		end

create {NONE}

feature -- Access

	frozen get_item (prop_desc: SYSTEM_DLL_PROPERTY_DESCRIPTOR): WINFORMS_DATA_GRID_COLUMN_STYLE is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (column_name: SYSTEM_STRING): WINFORMS_DATA_GRID_COLUMN_STYLE is
		external
			"IL signature (System.String): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"get_Item"
		end

	frozen get_item_int32 (index: INTEGER): WINFORMS_DATA_GRID_COLUMN_STYLE is
		external
			"IL signature (System.Int32): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	frozen reset_property_descriptors is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"ResetPropertyDescriptors"
		end

	frozen contains_data_grid_column_style (column: WINFORMS_DATA_GRID_COLUMN_STYLE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"Contains"
		end

	frozen index_of (element: WINFORMS_DATA_GRID_COLUMN_STYLE): INTEGER is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle): System.Int32 use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"IndexOf"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"Clear"
		end

	frozen contains (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"Contains"
		end

	frozen add_range (columns: NATIVE_ARRAY [WINFORMS_DATA_GRID_COLUMN_STYLE]) is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle[]): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"AddRange"
		end

	add (column: WINFORMS_DATA_GRID_COLUMN_STYLE): INTEGER is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle): System.Int32 use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"Add"
		end

	frozen contains_property_descriptor (prop_desc: SYSTEM_DLL_PROPERTY_DESCRIPTOR): BOOLEAN is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"Contains"
		end

	frozen remove (column: WINFORMS_DATA_GRID_COLUMN_STYLE) is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.Remove"
		end

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"get_List"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"OnCollectionChanged"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridColumnStylesCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class WINFORMS_GRID_COLUMN_STYLES_COLLECTION
