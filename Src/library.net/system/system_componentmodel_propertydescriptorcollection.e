indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.PropertyDescriptorCollection"

external class
	SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count,
			remove as system_collections_idictionary_remove,
			get_values as system_collections_idictionary_get_values,
			get_keys as system_collections_idictionary_get_keys,
			set_item as system_collections_idictionary_set_item,
			get_item as system_collections_idictionary_get_item,
			get_is_read_only as system_collections_idictionary_get_is_read_only,
			get_is_fixed_size as system_collections_idictionary_get_is_fixed_size,
			contains as system_collections_idictionary_contains,
			clear as system_collections_idictionary_clear,
			add as system_collections_idictionary_add
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_count as system_collections_icollection_get_count,
			remove_at as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			clear as system_collections_ilist_clear,
			add as system_collections_ilist_add,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count
		end

create
	make

feature {NONE} -- Initialization

	frozen make (properties: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor[]) use System.ComponentModel.PropertyDescriptorCollection"
		end

feature -- Access

	frozen empty: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static_field signature :System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Empty"
		end

	get_item (index: INTEGER): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (System.Int32): System.ComponentModel.PropertyDescriptor use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"get_Count"
		end

	get_item_string (name: STRING): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (System.String): System.ComponentModel.PropertyDescriptor use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	sort_array_string_icomparer (names: ARRAY [STRING]; comparer: SYSTEM_COLLECTIONS_ICOMPARER): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.String[], System.Collections.IComparer): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Sort"
		end

	frozen add (value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): INTEGER is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Add"
		end

	frozen remove (value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Remove"
		end

	sort_array_string (names: ARRAY [STRING]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.String[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Sort"
		end

	frozen insert (index: INTEGER; value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR) is
		external
			"IL signature (System.Int32, System.ComponentModel.PropertyDescriptor): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Insert"
		end

	frozen index_of (value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): INTEGER is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"IndexOf"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Equals"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"GetHashCode"
		end

	find (name: STRING; ignore_case: BOOLEAN): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (System.String, System.Boolean): System.ComponentModel.PropertyDescriptor use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Find"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"CopyTo"
		end

	sort: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Sort"
		end

	frozen contains (value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): BOOLEAN is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Contains"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"ToString"
		end

	sort_icomparer (comparer: SYSTEM_COLLECTIONS_ICOMPARER): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Collections.IComparer): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Sort"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen system_collections_idictionary_clear is
		external
			"IL signature (): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Clear"
		end

	frozen system_collections_idictionary_remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Remove"
		end

	frozen internal_sort (sorter: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL signature (System.Collections.IComparer): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"InternalSort"
		end

	frozen system_collections_idictionary_get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_Item"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen internal_sort_array_string (names: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"InternalSort"
		end

	frozen system_collections_ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_idictionary_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_IsFixedSize"
		end

	frozen system_collections_idictionary_add (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_collections_ilist_add (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_idictionary_contains (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Contains"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_idictionary_set_item (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen get_enumerator_idictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.GetEnumerator"
		end

	frozen system_collections_idictionary_get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_Keys"
		end

	frozen system_collections_ilist_contains (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_idictionary_get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_Values"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"Finalize"
		end

	frozen system_collections_idictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION
