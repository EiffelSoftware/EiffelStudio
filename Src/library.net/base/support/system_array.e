indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Array"

deferred external class
	SYSTEM_ARRAY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_COLLECTIONS_ILIST
		rename
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			clear as ilist_clear,
			has as ilist_has,
			extend as ilist_extend,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_count as icollection_get_count
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_count as icollection_get_count
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Array"
		alias
			"get_IsSynchronized"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"get_Length"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Array"
		alias
			"get_SyncRoot"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Array"
		alias
			"get_IsFixedSize"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Array"
		alias
			"get_IsReadOnly"
		end

	frozen get_rank: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"get_Rank"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Array"
		alias
			"ToString"
		end

	frozen index_of_array_object_int32_int32 (array: SYSTEM_ARRAY; value: ANY; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32, System.Int32): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen sort (array: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen set_value (value: ANY; indices: ARRAY [INTEGER]) is
		external
			"IL signature (System.Object, System.Int32[]): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen sort_array_array (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array, System.Array): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen get_value_int32_int32 (index1: INTEGER; index2: INTEGER): ANY is
		external
			"IL signature (System.Int32, System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen reverse_array_int32 (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Reverse"
		end

	frozen binary_search_array_object_icomparer (array: SYSTEM_ARRAY; value: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Collections.IComparer): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen create_instance_type_int32_int32_int32 (element_type: SYSTEM_TYPE; length1: INTEGER; length2: INTEGER; length3: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32, System.Int32, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen sort_array_array_int32_int32 (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen sort_array_array_int32_int32_icomparer (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen initialize is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"Initialize"
		end

	frozen last_index_of_array_object_int32_int32 (array: SYSTEM_ARRAY; value: ANY; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32, System.Int32): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen create_instance (element_type: SYSTEM_TYPE; lengths: ARRAY [INTEGER]): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32[]): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen last_index_of (array: SYSTEM_ARRAY; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen clear (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Clear"
		end

	frozen create_instance_type_int32_int32 (element_type: SYSTEM_TYPE; length1: INTEGER; length2: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen sort_array_array_icomparer (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Array, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen binary_search_array_int32_int32_object (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Object): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Array"
		alias
			"GetEnumerator"
		end

	frozen get_length_int32 (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetLength"
		end

	frozen sort_array_int32_int32 (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen create_instance_type_int32 (element_type: SYSTEM_TYPE; length: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen copy (source_array: SYSTEM_ARRAY; destination_array: SYSTEM_ARRAY; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32): System.Void use System.Array"
		alias
			"Copy"
		end

	frozen copy_array_int32 (source_array: SYSTEM_ARRAY; source_index: INTEGER; destination_array: SYSTEM_ARRAY; destination_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Copy"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Array"
		alias
			"Equals"
		end

	frozen sort_array_int32_int32_icomparer (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen sort_array_icomparer (array: SYSTEM_ARRAY; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen index_of_array_object_int32 (array: SYSTEM_ARRAY; value: ANY; start_index: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen binary_search (array: SYSTEM_ARRAY; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen last_index_of_array_object_int32 (array: SYSTEM_ARRAY; value: ANY; start_index: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen set_value_object_int32_int32_int32 (value: ANY; index1: INTEGER; index2: INTEGER; index3: INTEGER) is
		external
			"IL signature (System.Object, System.Int32, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen set_value_object_int32_int32 (value: ANY; index1: INTEGER; index2: INTEGER) is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen get_value (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen binary_search_array_int32_int32_object_icomparer (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; value: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER): INTEGER is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Object, System.Collections.IComparer): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen set_value_object_int32 (value: ANY; index: INTEGER) is
		external
			"IL signature (System.Object, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Array"
		alias
			"CopyTo"
		end

	frozen index_of (array: SYSTEM_ARRAY; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen get_value_int32_int32_int32 (index1: INTEGER; index2: INTEGER; index3: INTEGER): ANY is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen create_instance_type_array_int32_array_int32 (element_type: SYSTEM_TYPE; lengths: ARRAY [INTEGER]; lower_bounds: ARRAY [INTEGER]): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32[], System.Int32[]): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen reverse (array: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array): System.Void use System.Array"
		alias
			"Reverse"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Array"
		alias
			"Clone"
		end

	frozen get_lower_bound (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetLowerBound"
		end

	frozen get_value_array_int32 (indices: ARRAY [INTEGER]): ANY is
		external
			"IL signature (System.Int32[]): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen get_upper_bound (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetUpperBound"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Array"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Array"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Array"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Array"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_clear is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"System.Collections.IList.Clear"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen ilist_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Array"
		alias
			"System.Collections.IList.RemoveAt"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"Finalize"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_ARRAY
