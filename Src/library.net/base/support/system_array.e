indexing
	Generator: "Eiffel Emitter 2.5b2"
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
			prune_i_th as list_prune_i_th,
			remove as list_remove,
			insert as list_insert,
			index_of as list_index_of,
			clear as list_clear,
			has as list_has,
			extend as list_extend,
			put_i_th as list_put_i_th,
			get_item as list_get_item,
			get_count as collection_get_count
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_count as collection_get_Count
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	frozen get_rank: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"get_Rank"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Array"
		alias
			"get_IsReadOnly"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Array"
		alias
			"get_SyncRoot"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Array"
		alias
			"get_IsSynchronized"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Array"
		alias
			"get_IsFixedSize"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"get_Length"
		end

feature -- Basic Operations

	frozen sort_keys_and_items (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array, System.Array): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen i_th (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen binary_search_with_comparer (array: SYSTEM_ARRAY; value: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Collections.IComparer): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen last_index_of (array: SYSTEM_ARRAY; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen sort (array: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen put_i_th_2dimensions (value: ANY; index1: INTEGER; index2: INTEGER) is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen create_multi_dimensionel_array_with_bounds (elementType: SYSTEM_TYPE; lengths: ARRAY [INTEGER]; lowerBounds: ARRAY [INTEGER]): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32[], System.Int32[]): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Array"
		alias
			"GetEnumerator"
		end

	frozen i_th_2dimensions (index1: INTEGER; index2: INTEGER): ANY is
		external
			"IL signature (System.Int32, System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen index_of (array: SYSTEM_ARRAY; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen i_th_multi_dimensions (indices: ARRAY [INTEGER]): ANY is
		external
			"IL signature (System.Int32[]): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen create_array (elementType: SYSTEM_TYPE; length2: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen copy (sourceArray: SYSTEM_ARRAY; destinationArray: SYSTEM_ARRAY; length2: INTEGER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32): System.Void use System.Array"
		alias
			"Copy"
		end

	frozen reverse (array: SYSTEM_ARRAY) is
		external
			"IL static signature (System.Array): System.Void use System.Array"
		alias
			"Reverse"
		end

	frozen put_i_th (value: ANY; index: INTEGER) is
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

	frozen last_index_of_in (array: SYSTEM_ARRAY; value: ANY; startIndex: INTEGER; count2: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32, System.Int32): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Array"
		alias
			"Clone"
		end

	frozen index_of_starting_at (array: SYSTEM_ARRAY; value: ANY; startIndex: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	frozen sort_between_with_comparer (array: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen copy_from_to (sourceArray: SYSTEM_ARRAY; sourceIndex: INTEGER; destinationArray: SYSTEM_ARRAY; destinationIndex: INTEGER; length2: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Copy"
		end

	frozen initialize is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"Initialize"
		end

	frozen put_i_th_3dimensions (value: ANY; index1: INTEGER; index2: INTEGER; index3: INTEGER) is
		external
			"IL signature (System.Object, System.Int32, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen get_length_in (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetLength"
		end

	frozen create_multi_dimensionel_array (elementType: SYSTEM_TYPE; lengths: ARRAY [INTEGER]): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32[]): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen upper_bound (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetUpperBound"
		end

	frozen binary_search (array: SYSTEM_ARRAY; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Object): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen index_of_in (array: SYSTEM_ARRAY; value: ANY; startIndex: INTEGER; count2: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32, System.Int32): System.Int32 use System.Array"
		alias
			"IndexOf"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Array"
		alias
			"ToString"
		end

	frozen lower_bound (dimension: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Array"
		alias
			"GetLowerBound"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"GetHashCode"
		end

	frozen sort_keys_and_items_with_comparer (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Array, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen create_3dimensions_array (elementType: SYSTEM_TYPE; length1: INTEGER; length2: INTEGER; length3: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32, System.Int32, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen clear (array: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Clear"
		end

	frozen sort_keys_and_items_between (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen reverse_between (array: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Reverse"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Array"
		alias
			"Equals"
		end

	frozen last_index_of_starting_at (array: SYSTEM_ARRAY; value: ANY; startIndex: INTEGER): INTEGER is
		external
			"IL static signature (System.Array, System.Object, System.Int32): System.Int32 use System.Array"
		alias
			"LastIndexOf"
		end

	frozen create_2dimensions_array (elementType: SYSTEM_TYPE; length1: INTEGER; length2: INTEGER): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type, System.Int32, System.Int32): System.Array use System.Array"
		alias
			"CreateInstance"
		end

	frozen binary_search_in (array: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER; value: ANY): INTEGER is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Object): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen sort_keys_and_items_between_with_comparer (keys: SYSTEM_ARRAY; items: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Array, System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen put_i_th_multi_dimension (value: ANY; indices: ARRAY [INTEGER]) is
		external
			"IL signature (System.Object, System.Int32[]): System.Void use System.Array"
		alias
			"SetValue"
		end

	frozen i_th_dimensions (index1: INTEGER; index2: INTEGER; index3: INTEGER): ANY is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Object use System.Array"
		alias
			"GetValue"
		end

	frozen sort_between (array: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Int32): System.Void use System.Array"
		alias
			"Sort"
		end

	frozen binary_search_in_with_comparer (array: SYSTEM_ARRAY; index: INTEGER; length2: INTEGER; value: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER): INTEGER is
		external
			"IL static signature (System.Array, System.Int32, System.Int32, System.Object, System.Collections.IComparer): System.Int32 use System.Array"
		alias
			"BinarySearch"
		end

	frozen sort_with_comparer (array: SYSTEM_ARRAY; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL static signature (System.Array, System.Collections.IComparer): System.Void use System.Array"
		alias
			"Sort"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"Finalize"
		end

	frozen list_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Array"
		alias
			"System.Collections.IList.Contains"
		end

	frozen list_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Array"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen list_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Array"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen list_clear is
		external
			"IL signature (): System.Void use System.Array"
		alias
			"System.Collections.IList.Clear"
		end

	frozen list_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen list_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.Remove"
		end

	frozen list_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Array"
		alias
			"System.Collections.IList.Add"
		end

	frozen list_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Array"
		alias
			"System.Collections.IList.Insert"
		end

	frozen collection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Array"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen list_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Array"
		alias
			"System.Collections.IList.RemoveAt"
		end

end -- class SYSTEM_ARRAY
