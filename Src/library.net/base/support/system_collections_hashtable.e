indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Hashtable"

external class
	SYSTEM_COLLECTIONS_HASHTABLE

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
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_ICLONEABLE

create
	make,
	make_7,
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make_1,
	make_9,
	make_8

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.Hashtable"
		end

	frozen make_7 (d: SYSTEM_COLLECTIONS_IDICTIONARY; load_factor: REAL) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Single) use System.Collections.Hashtable"
		end

	frozen make_6 (d: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL creator signature (System.Collections.IDictionary) use System.Collections.Hashtable"
		end

	frozen make_5 (capacity: INTEGER; hcp: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Int32, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_4 (hcp: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_3 (capacity: INTEGER; load_factor: REAL; hcp: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Int32, System.Single, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_2 (capacity: INTEGER; load_factor: REAL) is
		external
			"IL creator signature (System.Int32, System.Single) use System.Collections.Hashtable"
		end

	frozen make_1 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Hashtable"
		end

	frozen make_9 (d: SYSTEM_COLLECTIONS_IDICTIONARY; load_factor: REAL; hcp: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Single, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_8 (d: SYSTEM_COLLECTIONS_IDICTIONARY; hcp: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

feature -- Access

	get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Collections.Hashtable"
		alias
			"get_Item"
		end

	get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Hashtable"
		alias
			"get_Values"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Hashtable"
		alias
			"get_Keys"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Hashtable"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Hashtable"
		alias
			"get_Count"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Hashtable"
		alias
			"get_IsFixedSize"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Hashtable"
		alias
			"get_IsReadOnly"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Hashtable"
		alias
			"get_IsSynchronized"
		end

feature -- Element Change

	put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Hashtable"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Hashtable"
		alias
			"ToString"
		end

	contains_value (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"ContainsValue"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Hashtable"
		alias
			"GetHashCode"
		end

	get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.Hashtable"
		alias
			"GetEnumerator"
		end

	on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Hashtable"
		alias
			"OnDeserialization"
		end

	copy_to (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Hashtable"
		alias
			"CopyTo"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.Hashtable"
		alias
			"Clone"
		end

	remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Hashtable"
		alias
			"Remove"
		end

	has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"Contains"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"Equals"
		end

	extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Hashtable"
		alias
			"Add"
		end

	frozen synchronized (table: SYSTEM_COLLECTIONS_HASHTABLE): SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL static signature (System.Collections.Hashtable): System.Collections.Hashtable use System.Collections.Hashtable"
		alias
			"Synchronized"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.Hashtable"
		alias
			"Clear"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Collections.Hashtable"
		alias
			"GetObjectData"
		end

	contains_key (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"ContainsKey"
		end

feature {NONE} -- Implementation

	frozen set_hcp (value: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER) is
		external
			"IL signature (System.Collections.IHashCodeProvider): System.Void use System.Collections.Hashtable"
		alias
			"set_hcp"
		end

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Hashtable"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	get_hash (key: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.Hashtable"
		alias
			"GetHash"
		end

	frozen get_comparer: SYSTEM_COLLECTIONS_ICOMPARER is
		external
			"IL signature (): System.Collections.IComparer use System.Collections.Hashtable"
		alias
			"get_comparer"
		end

	key_equals (item: ANY; key: ANY): BOOLEAN is
		external
			"IL signature (System.Object, System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"KeyEquals"
		end

	frozen get_hcp: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER is
		external
			"IL signature (): System.Collections.IHashCodeProvider use System.Collections.Hashtable"
		alias
			"get_hcp"
		end

	frozen set_comparer (value: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL signature (System.Collections.IComparer): System.Void use System.Collections.Hashtable"
		alias
			"set_comparer"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Hashtable"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_HASHTABLE
