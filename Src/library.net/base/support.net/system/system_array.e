indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Array"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_ARRAY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	ILIST
		rename
			remove_at as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			clear as system_collections_ilist_clear,
			contains as system_collections_ilist_contains,
			add as system_collections_ilist_add,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_count as system_collections_icollection_get_count
		end
	ICOLLECTION
		rename
			get_count as system_collections_icollection_get_count
		end
	IENUMERABLE

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

	get_sync_root: SYSTEM_OBJECT is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Array"
		alias
			"ToString"
		end

	frozen index_of_array_object_int32_int32 (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT; start_index: INTEGER; count: INTEGER): INTEGER is
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

	frozen set_value (value: SYSTEM_OBJECT; index: INTEGER) is
		external
			"IL signature (System.Object, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen sort_array_array (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array, System.Array): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen get_value_int32_int32 (index1: INTEGER; index2: INTEGER): SYSTEM_OBJECT is
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

	frozen binary_search_array_object_icomparer (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT; comparer: ICOMPARER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Collections.IComparer): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen binary_search (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen sort_array_array_int32_int32 (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen sort_array_array_int32_int32_icomparer (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; comparer: ICOMPARER) is
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

	frozen last_index_of_array_object_int32_int32 (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32, System.Int32): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen create_instance (element_type: TYPE; length: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen create_instance_type_int32_int32_int32 (element_type: TYPE; length1: INTEGER; length2: INTEGER; length3: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32, System.Int32, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen last_index_of (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT): INTEGER is
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

	frozen create_instance_type_int32_int32 (element_type: TYPE; length1: INTEGER; length2: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen sort_array_array_icomparer (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; comparer: ICOMPARER) is
		external
			"IL static signature (System.Array, System.Array, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen binary_search_array_int32_int32_object (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; value: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Object): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	get_enumerator: IENUMERATOR is
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

	frozen create_instance_type_array_int32 (element_type: TYPE; lengths: NATIVE_ARRAY [INTEGER]): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32[]): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Array"
		alias
			"Equals"
		end

	frozen sort_array_int32_int32_icomparer (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; comparer: ICOMPARER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen index_of_array_object_int32 (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT; start_index: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen last_index_of_array_object_int32 (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT; start_index: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen set_value_object_int32_int32_int32 (value: SYSTEM_OBJECT; index1: INTEGER; index2: INTEGER; index3: INTEGER) is
		external
			"IL signature (System.Object, System.Int32, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen set_value_object_int32_int32 (value: SYSTEM_OBJECT; index1: INTEGER; index2: INTEGER) is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen get_value (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen copy__array_int32 (source_array: SYSTEM_ARRAY; source_index: INTEGER; destination_array: SYSTEM_ARRAY; destination_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Copy"
		end

	frozen binary_search_array_int32_int32_object_icomparer (array: SYSTEM_ARRAY; index: INTEGER; length: INTEGER; value: SYSTEM_OBJECT; comparer: ICOMPARER): INTEGER is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Object, System.Collections.IComparer): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen set_value_object_array_int32 (value: SYSTEM_OBJECT; indices: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Object, System.Int32[]): System.Void use System.Array"
		alias
			"SetValue"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Array"
		alias
			"Clone"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Array"
		alias
			"CopyTo"
		end

	frozen index_of (array: SYSTEM_ARRAY; value: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen copy_ (source_array: SYSTEM_ARRAY; destination_array: SYSTEM_ARRAY; length: INTEGER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32): System.Void use System.Array"
		alias
			"Copy"
		end

	frozen get_value_int32_int32_int32 (index1: INTEGER; index2: INTEGER; index3: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen create_instance_type_array_int32_array_int32 (element_type: TYPE; lengths: NATIVE_ARRAY [INTEGER]; lower_bounds: NATIVE_ARRAY [INTEGER]): SYSTEM_ARRAY is
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

	frozen sort_array_icomparer (array: SYSTEM_ARRAY; comparer: ICOMPARER) is
		external
			"IL static signature (System.Array, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen get_lower_bound (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetLowerBound"
		end

	frozen get_value_array_int32 (indices: NATIVE_ARRAY [INTEGER]): SYSTEM_OBJECT is
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

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Array"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Array"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Array"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Array"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
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

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_ARRAY
