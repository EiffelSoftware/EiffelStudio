indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.SortedList"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_SORTED_LIST

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICLONEABLE

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (d: IDICTIONARY; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.IComparer) use System.Collections.SortedList"
		end

	frozen make_4 (d: IDICTIONARY) is
		external
			"IL creator signature (System.Collections.IDictionary) use System.Collections.SortedList"
		end

	frozen make_3 (comparer: ICOMPARER; capacity: INTEGER) is
		external
			"IL creator signature (System.Collections.IComparer, System.Int32) use System.Collections.SortedList"
		end

	frozen make_2 (comparer: ICOMPARER) is
		external
			"IL creator signature (System.Collections.IComparer) use System.Collections.SortedList"
		end

	frozen make is
		external
			"IL creator use System.Collections.SortedList"
		end

	frozen make_1 (initial_capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.SortedList"
		end

feature -- Access

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Collections.SortedList"
		alias
			"get_Item"
		end

	get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.SortedList"
		alias
			"get_Values"
		end

	get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.SortedList"
		alias
			"get_Keys"
		end

	get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.SortedList"
		alias
			"get_SyncRoot"
		end

	get_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.SortedList"
		alias
			"get_Capacity"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.SortedList"
		alias
			"get_Count"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.SortedList"
		alias
			"get_IsFixedSize"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.SortedList"
		alias
			"get_IsReadOnly"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.SortedList"
		alias
			"get_IsSynchronized"
		end

feature -- Element Change

	set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.SortedList"
		alias
			"set_Capacity"
		end

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.SortedList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.SortedList"
		alias
			"RemoveAt"
		end

	add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.SortedList"
		alias
			"Add"
		end

	remove (key: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.SortedList"
		alias
			"Remove"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"Equals"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.SortedList"
		alias
			"Clear"
		end

	index_of_key (key: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.SortedList"
		alias
			"IndexOfKey"
		end

	contains_value (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"ContainsValue"
		end

	get_key_list: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.SortedList"
		alias
			"GetKeyList"
		end

	frozen synchronized (list: SYSTEM_SORTED_LIST): SYSTEM_SORTED_LIST is
		external
			"IL static signature (System.Collections.SortedList): System.Collections.SortedList use System.Collections.SortedList"
		alias
			"Synchronized"
		end

	get_by_index (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Collections.SortedList"
		alias
			"GetByIndex"
		end

	contains_key (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"ContainsKey"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.SortedList"
		alias
			"Clone"
		end

	contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"Contains"
		end

	trim_to_size is
		external
			"IL signature (): System.Void use System.Collections.SortedList"
		alias
			"TrimToSize"
		end

	index_of_value (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.SortedList"
		alias
			"IndexOfValue"
		end

	get_key (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Collections.SortedList"
		alias
			"GetKey"
		end

	get_value_list: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.SortedList"
		alias
			"GetValueList"
		end

	copy_to (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.SortedList"
		alias
			"CopyTo"
		end

	get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.SortedList"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.SortedList"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.SortedList"
		alias
			"GetHashCode"
		end

	set_by_index (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.SortedList"
		alias
			"SetByIndex"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.SortedList"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.SortedList"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_SORTED_LIST
