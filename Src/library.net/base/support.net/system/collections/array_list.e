indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.ArrayList"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ARRAY_LIST

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ILIST
		rename
			copy_to as copy_to_array_int32
		end
	ICOLLECTION
		rename
			copy_to as copy_to_array_int32
		end
	IENUMERABLE
	ICLONEABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (c: ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use System.Collections.ArrayList"
		end

	frozen make is
		external
			"IL creator use System.Collections.ArrayList"
		end

	frozen make_1 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.ArrayList"
		end

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ArrayList"
		alias
			"get_IsSynchronized"
		end

	get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Collections.ArrayList"
		alias
			"get_Item"
		end

	get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.ArrayList"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ArrayList"
		alias
			"get_Count"
		end

	get_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ArrayList"
		alias
			"get_Capacity"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ArrayList"
		alias
			"get_IsFixedSize"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ArrayList"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"set_Capacity"
		end

	set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.ArrayList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_range (index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"RemoveRange"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ArrayList"
		alias
			"GetHashCode"
		end

	reverse is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Reverse"
		end

	copy_to_array_int32 (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"CopyTo"
		end

	frozen synchronized (list: ARRAY_LIST): ARRAY_LIST is
		external
			"IL static signature (System.Collections.ArrayList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"Synchronized"
		end

	add_range (c: ICOLLECTION) is
		external
			"IL signature (System.Collections.ICollection): System.Void use System.Collections.ArrayList"
		alias
			"AddRange"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"RemoveAt"
		end

	insert_range (index: INTEGER; c: ICOLLECTION) is
		external
			"IL signature (System.Int32, System.Collections.ICollection): System.Void use System.Collections.ArrayList"
		alias
			"InsertRange"
		end

	to_array_type (type: TYPE): SYSTEM_ARRAY is
		external
			"IL signature (System.Type): System.Array use System.Collections.ArrayList"
		alias
			"ToArray"
		end

	binary_search (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"BinarySearch"
		end

	frozen read_only (list: ARRAY_LIST): ARRAY_LIST is
		external
			"IL static signature (System.Collections.ArrayList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"ReadOnly"
		end

	get_enumerator_int32 (index: INTEGER; count: INTEGER): IENUMERATOR is
		external
			"IL signature (System.Int32, System.Int32): System.Collections.IEnumerator use System.Collections.ArrayList"
		alias
			"GetEnumerator"
		end

	copy_to_int32 (index: INTEGER; array: SYSTEM_ARRAY; array_index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Int32, System.Array, System.Int32, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"CopyTo"
		end

	frozen synchronized_ilist (list: ILIST): ILIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.IList use System.Collections.ArrayList"
		alias
			"Synchronized"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.ArrayList"
		alias
			"Clone"
		end

	insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.ArrayList"
		alias
			"Insert"
		end

	binary_search_int32 (index: INTEGER; count: INTEGER; value: SYSTEM_OBJECT; comparer: ICOMPARER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32, System.Object, System.Collections.IComparer): System.Int32 use System.Collections.ArrayList"
		alias
			"BinarySearch"
		end

	last_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"LastIndexOf"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Clear"
		end

	remove (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.ArrayList"
		alias
			"Remove"
		end

	frozen read_only_ilist (list: ILIST): ILIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.IList use System.Collections.ArrayList"
		alias
			"ReadOnly"
		end

	get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.ArrayList"
		alias
			"GetEnumerator"
		end

	get_range (index: INTEGER; count: INTEGER): ARRAY_LIST is
		external
			"IL signature (System.Int32, System.Int32): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"GetRange"
		end

	trim_to_size is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"TrimToSize"
		end

	frozen repeat (value: SYSTEM_OBJECT; count: INTEGER): ARRAY_LIST is
		external
			"IL static signature (System.Object, System.Int32): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"Repeat"
		end

	set_range (index: INTEGER; c: ICOLLECTION) is
		external
			"IL signature (System.Int32, System.Collections.ICollection): System.Void use System.Collections.ArrayList"
		alias
			"SetRange"
		end

	index_of_object_int32_int32 (value: SYSTEM_OBJECT; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"IndexOf"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.ArrayList"
		alias
			"ToString"
		end

	sort_int32 (index: INTEGER; count: INTEGER; comparer: ICOMPARER) is
		external
			"IL signature (System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Collections.ArrayList"
		alias
			"Sort"
		end

	last_index_of_object_int32_int32 (value: SYSTEM_OBJECT; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"LastIndexOf"
		end

	add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"Add"
		end

	frozen fixed_size_ilist (list: ILIST): ILIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.IList use System.Collections.ArrayList"
		alias
			"FixedSize"
		end

	index_of_object_int32 (value: SYSTEM_OBJECT; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"IndexOf"
		end

	frozen fixed_size (list: ARRAY_LIST): ARRAY_LIST is
		external
			"IL static signature (System.Collections.ArrayList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"FixedSize"
		end

	frozen adapter (list: ILIST): ARRAY_LIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"Adapter"
		end

	sort_icomparer (comparer: ICOMPARER) is
		external
			"IL signature (System.Collections.IComparer): System.Void use System.Collections.ArrayList"
		alias
			"Sort"
		end

	contains (item: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.ArrayList"
		alias
			"Contains"
		end

	sort is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Sort"
		end

	last_index_of_object_int32 (value: SYSTEM_OBJECT; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"LastIndexOf"
		end

	binary_search_object_icomparer (value: SYSTEM_OBJECT; comparer: ICOMPARER): INTEGER is
		external
			"IL signature (System.Object, System.Collections.IComparer): System.Int32 use System.Collections.ArrayList"
		alias
			"BinarySearch"
		end

	copy_to (array: SYSTEM_ARRAY) is
		external
			"IL signature (System.Array): System.Void use System.Collections.ArrayList"
		alias
			"CopyTo"
		end

	index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"IndexOf"
		end

	reverse_int32 (index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"Reverse"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.ArrayList"
		alias
			"Equals"
		end

	to_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Collections.ArrayList"
		alias
			"ToArray"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Finalize"
		end

end -- class ARRAY_LIST
