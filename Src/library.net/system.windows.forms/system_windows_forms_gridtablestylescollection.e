indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.GridTableStylesCollection"

external class
	SYSTEM_WINDOWS_FORMS_GRIDTABLESTYLESCOLLECTION

inherit
	SYSTEM_WINDOWS_FORMS_BASECOLLECTION
		rename
			get_count as icollection_get_count
		redefine
			icollection_get_count,
			get_list
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count,
			copy_to as icollection_copy_to
		select
			ienumerable_get_enumerator,
			icollection_get_sync_root,
			icollection_get_is_synchronized,
			icollection_copy_to
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count,
			copy_to as icollection_copy_to,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_is_read_only as ilist_get_is_read_only,
			get_is_fixed_size as ilist_get_is_fixed_size,
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			clear as ilist_clear,
			extend as ilist_extend
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
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

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"RemoveAt"
		end

	frozen has (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"Contains"
		end

	extend (table: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE): INTEGER is
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

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen ilist_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (value: ANY) is
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

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
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

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridTableStylesCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class SYSTEM_WINDOWS_FORMS_GRIDTABLESTYLESCOLLECTION
