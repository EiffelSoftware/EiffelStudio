indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.GridTableStylesCollection"

external class
	SYSTEM_WINDOWS_FORMS_GRIDTABLESTYLESCOLLECTION

inherit
	SYSTEM_WINDOWS_FORMS_BASECOLLECTION
		rename
			get_count as system_collections_icollection_get_count
		redefine
			system_collections_icollection_get_count,
			get_list
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
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
	SYSTEM_COLLECTIONS_ILIST
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count,
			copy_to as system_collections_icollection_copy_to,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			prune_i_th as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			clear as system_collections_ilist_clear,
			extend as system_collections_ilist_add
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	frozen get_item (table_name: STRING): SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE is
		external
			"IL signature (System.String): System.Windows.Forms.DataGridTableStyle use System.Windows.Forms.GridTableStylesCollection"
		alias
			"get_Item"
		end

	frozen get_item_int32 (index: INTEGER): SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE is
		external
			"IL signature (System.Int32): System.Windows.Forms.DataGridTableStyle use System.Windows.Forms.GridTableStylesCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"RemoveAt"
		end

	frozen contains (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"Contains"
		end

	add (table: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE): INTEGER is
		external
			"IL signature (System.Windows.Forms.DataGridTableStyle): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"Add"
		end

	frozen contains_data_grid_table_style (table: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataGridTableStyle): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"Contains"
		end

	add_range (tables: ARRAY [SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE]) is
		external
			"IL signature (System.Windows.Forms.DataGridTableStyle[]): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"AddRange"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"Clear"
		end

	frozen remove (table: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE) is
		external
			"IL signature (System.Windows.Forms.DataGridTableStyle): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"Remove"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Remove"
		end

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Windows.Forms.GridTableStylesCollection"
		alias
			"get_List"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_collections_ilist_add (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ilist_contains (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"OnCollectionChanged"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class SYSTEM_WINDOWS_FORMS_GRIDTABLESTYLESCOLLECTION
