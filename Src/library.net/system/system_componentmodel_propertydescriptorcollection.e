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
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count,
			remove as idictionary_remove,
			get_values as idictionary_get_values,
			get_keys as idictionary_get_keys,
			put_i_th as idictionary_put_i_th,
			get_item as idictionary_get_item,
			get_is_read_only as idictionary_get_is_read_only,
			get_is_fixed_size as idictionary_get_is_fixed_size,
			has as idictionary_has,
			clear as idictionary_clear,
			extend as idictionary_extend
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only,
			get_count as icollection_get_count,
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			clear as ilist_clear,
			extend as ilist_extend,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count
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

	frozen extend (value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): INTEGER is
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

	frozen has (value: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): BOOLEAN is
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

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen ilist_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen idictionary_clear is
		external
			"IL signature (): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Clear"
		end

	frozen idictionary_remove (key: ANY) is
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

	frozen idictionary_get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_Item"
		end

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
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

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen idictionary_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_IsFixedSize"
		end

	frozen idictionary_extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen idictionary_has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.Contains"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen idictionary_put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.GetEnumerator"
		end

	frozen idictionary_get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_Keys"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen idictionary_get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_Values"
		end

	frozen icollection_get_sync_root: ANY is
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

	frozen idictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	frozen ilist_clear is
		external
			"IL signature (): System.Void use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptorCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION
