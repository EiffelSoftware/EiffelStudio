indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.SortedList"

external class
	SYSTEM_COLLECTIONS_SORTEDLIST

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
			get_enumerator as get_enumerable_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as get_enumerable_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as get_enumerable_enumerator
		end
	SYSTEM_ICLONEABLE

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (d: SYSTEM_COLLECTIONS_IDICTIONARY; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.IComparer) use System.Collections.SortedList"
		end

	frozen make_4 (d: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL creator signature (System.Collections.IDictionary) use System.Collections.SortedList"
		end

	frozen make_3 (comparer: SYSTEM_COLLECTIONS_ICOMPARER; capacity2: INTEGER) is
		external
			"IL creator signature (System.Collections.IComparer, System.Int32) use System.Collections.SortedList"
		end

	frozen make_2 (comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IComparer) use System.Collections.SortedList"
		end

	frozen make is
		external
			"IL creator use System.Collections.SortedList"
		end

	frozen make_1 (initialCapacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.SortedList"
		end

feature -- Access

	get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Collections.SortedList"
		alias
			"get_Item"
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

	get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.SortedList"
		alias
			"get_Values"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.SortedList"
		alias
			"get_SyncRoot"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.SortedList"
		alias
			"get_IsSynchronized"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.SortedList"
		alias
			"get_IsFixedSize"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.SortedList"
		alias
			"get_Keys"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.SortedList"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.SortedList"
		alias
			"set_Capacity"
		end

	put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.SortedList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.SortedList"
		alias
			"Clone"
		end

	get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.SortedList"
		alias
			"GetEnumerator"
		end

	get_key (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Collections.SortedList"
		alias
			"GetKey"
		end

	extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.SortedList"
		alias
			"Add"
		end

	frozen synchronized (list: SYSTEM_COLLECTIONS_SORTEDLIST): SYSTEM_COLLECTIONS_SORTEDLIST is
		external
			"IL static signature (System.Collections.SortedList): System.Collections.SortedList use System.Collections.SortedList"
		alias
			"Synchronized"
		end

	has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"Contains"
		end

	get_key_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.SortedList"
		alias
			"GetKeyList"
		end

	has_item (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"ContainsValue"
		end

	get_by_index (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Collections.SortedList"
		alias
			"GetByIndex"
		end

	remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.SortedList"
		alias
			"Remove"
		end

	index_of_item (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.SortedList"
		alias
			"IndexOfValue"
		end

	index_of_key (key: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.SortedList"
		alias
			"IndexOfKey"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"Equals"
		end

	prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.SortedList"
		alias
			"RemoveAt"
		end

	get_value_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.SortedList"
		alias
			"GetValueList"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.SortedList"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.SortedList"
		alias
			"ToString"
		end

	trim_to_size is
		external
			"IL signature (): System.Void use System.Collections.SortedList"
		alias
			"TrimToSize"
		end

	has_key (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.SortedList"
		alias
			"ContainsKey"
		end

	copy_to (array: SYSTEM_ARRAY; arrayIndex: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.SortedList"
		alias
			"CopyTo"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.SortedList"
		alias
			"Clear"
		end

	set_by_index (index: INTEGER; value: ANY) is
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

	frozen get_enumerable_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.SortedList"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_COLLECTIONS_SORTEDLIST
