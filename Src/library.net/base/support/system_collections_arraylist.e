indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.ArrayList"

external class
	SYSTEM_COLLECTIONS_ARRAYLIST

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			copy_to as copy_to_array_at
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as copy_to_array_at
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_ICLONEABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (c: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use System.Collections.ArrayList"
		end

	frozen make is
		external
			"IL creator use System.Collections.ArrayList"
		end

	frozen make_1 (capacity2: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.ArrayList"
		end

feature -- Access

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ArrayList"
		alias
			"get_IsReadOnly"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.ArrayList"
		alias
			"get_SyncRoot"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ArrayList"
		alias
			"get_IsSynchronized"
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

	get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Collections.ArrayList"
		alias
			"get_Item"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ArrayList"
		alias
			"get_Count"
		end

feature -- Element Change

	set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"set_Capacity"
		end

	put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.ArrayList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	part_copy_to_array_at (index: INTEGER; array: SYSTEM_ARRAY; array_index: INTEGER; count2: INTEGER) is
		external
			"IL signature (System.Int32, System.Array, System.Int32, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"CopyTo"
		end

	frozen fixed_size_list (list: SYSTEM_COLLECTIONS_ILIST): SYSTEM_COLLECTIONS_ILIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.IList use System.Collections.ArrayList"
		alias
			"FixedSize"
		end

	get_part_enumerator (index: INTEGER; count2: INTEGER): SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (System.Int32, System.Int32): System.Collections.IEnumerator use System.Collections.ArrayList"
		alias
			"GetEnumerator"
		end

	copy_to_array_at (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"CopyTo"
		end

	extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"Add"
		end

	last_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"LastIndexOf"
		end

	has (item2: ANY): BOOLEAN is
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

	frozen repeat (value: ANY; count2: INTEGER): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL static signature (System.Object, System.Int32): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"Repeat"
		end

	frozen fixed_size_array (list: SYSTEM_COLLECTIONS_ARRAYLIST): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL static signature (System.Collections.ArrayList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"FixedSize"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.ArrayList"
		alias
			"GetEnumerator"
		end

	index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"IndexOf"
		end

	copy_to (array: SYSTEM_ARRAY) is
		external
			"IL signature (System.Array): System.Void use System.Collections.ArrayList"
		alias
			"CopyTo"
		end

	to_specific_array (type: SYSTEM_TYPE): SYSTEM_ARRAY is
		external
			"IL signature (System.Type): System.Array use System.Collections.ArrayList"
		alias
			"ToArray"
		end

	reverse is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Reverse"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.ArrayList"
		alias
			"ToString"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.ArrayList"
		alias
			"Clone"
		end

	frozen synchronized (list: SYSTEM_COLLECTIONS_ARRAYLIST): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL static signature (System.Collections.ArrayList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"Synchronized"
		end

	index_of_starting_at (value: ANY; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"IndexOf"
		end

	last_index_of_starting_at (value: ANY; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"LastIndexOf"
		end

	trim_to_size is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"TrimToSize"
		end

	reverse_interval (index: INTEGER; count2: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"Reverse"
		end

	get_range (index: INTEGER; count2: INTEGER): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (System.Int32, System.Int32): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"GetRange"
		end

	sort_interval (index: INTEGER; count2: INTEGER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL signature (System.Int32, System.Int32, System.Collections.IComparer): System.Void use System.Collections.ArrayList"
		alias
			"Sort"
		end

	frozen read_only_list (list: SYSTEM_COLLECTIONS_ILIST): SYSTEM_COLLECTIONS_ILIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.IList use System.Collections.ArrayList"
		alias
			"ReadOnly"
		end

	insert_range (index: INTEGER; c: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL signature (System.Int32, System.Collections.ICollection): System.Void use System.Collections.ArrayList"
		alias
			"InsertRange"
		end

	binary_search (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.ArrayList"
		alias
			"BinarySearch"
		end

	remove (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.ArrayList"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ArrayList"
		alias
			"GetHashCode"
		end

	to_array: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Collections.ArrayList"
		alias
			"ToArray"
		end

	frozen read_only_arraylist (list: SYSTEM_COLLECTIONS_ARRAYLIST): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL static signature (System.Collections.ArrayList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"ReadOnly"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.ArrayList"
		alias
			"Equals"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Clear"
		end

	binary_search_with_comparer (value: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER): INTEGER is
		external
			"IL signature (System.Object, System.Collections.IComparer): System.Int32 use System.Collections.ArrayList"
		alias
			"BinarySearch"
		end

	frozen synchronized_list (list: SYSTEM_COLLECTIONS_ILIST): SYSTEM_COLLECTIONS_ILIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.IList use System.Collections.ArrayList"
		alias
			"Synchronized"
		end

	prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"RemoveAt"
		end

	append (c: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL signature (System.Collections.ICollection): System.Void use System.Collections.ArrayList"
		alias
			"AddRange"
		end

	frozen adapter (list: SYSTEM_COLLECTIONS_ILIST): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL static signature (System.Collections.IList): System.Collections.ArrayList use System.Collections.ArrayList"
		alias
			"Adapter"
		end

	last_index_of_in (value: ANY; start_index: INTEGER; count2: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"LastIndexOf"
		end

	sort_with_comparer (comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL signature (System.Collections.IComparer): System.Void use System.Collections.ArrayList"
		alias
			"Sort"
		end

	remove_range (index: INTEGER; count2: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Collections.ArrayList"
		alias
			"RemoveRange"
		end

	set_range (index: INTEGER; c: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL signature (System.Int32, System.Collections.ICollection): System.Void use System.Collections.ArrayList"
		alias
			"SetRange"
		end

	index_of_in (value: ANY; start_index: INTEGER; count2: INTEGER): INTEGER is
		external
			"IL signature (System.Object, System.Int32, System.Int32): System.Int32 use System.Collections.ArrayList"
		alias
			"IndexOf"
		end

	insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.ArrayList"
		alias
			"Insert"
		end

	binary_search_with_comparer_in (index: INTEGER; count2: INTEGER; value: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32, System.Object, System.Collections.IComparer): System.Int32 use System.Collections.ArrayList"
		alias
			"BinarySearch"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.ArrayList"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_ARRAYLIST
