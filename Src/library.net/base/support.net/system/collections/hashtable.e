indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Hashtable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	HASHTABLE

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
	ISERIALIZABLE
	IDESERIALIZATION_CALLBACK
	ICLONEABLE

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

	frozen make_7 (d: IDICTIONARY; load_factor: REAL) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Single) use System.Collections.Hashtable"
		end

	frozen make_6 (d: IDICTIONARY) is
		external
			"IL creator signature (System.Collections.IDictionary) use System.Collections.Hashtable"
		end

	frozen make_5 (capacity: INTEGER; hcp: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Int32, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_4 (hcp: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_3 (capacity: INTEGER; load_factor: REAL; hcp: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
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

	frozen make_9 (d: IDICTIONARY; load_factor: REAL; hcp: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Single, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

	frozen make_8 (d: IDICTIONARY; hcp: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Hashtable"
		end

feature -- Access

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Collections.Hashtable"
		alias
			"get_Item"
		end

	get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Hashtable"
		alias
			"get_Values"
		end

	get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Hashtable"
		alias
			"get_Keys"
		end

	get_sync_root: SYSTEM_OBJECT is
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

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Hashtable"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Hashtable"
		alias
			"ToString"
		end

	contains_value (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"ContainsValue"
		end

	on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Hashtable"
		alias
			"OnDeserialization"
		end

	remove (key: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Hashtable"
		alias
			"Remove"
		end

	get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.Hashtable"
		alias
			"GetEnumerator"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Hashtable"
		alias
			"Clone"
		end

	copy_to (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Hashtable"
		alias
			"CopyTo"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.Hashtable"
		alias
			"Clear"
		end

	contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"Contains"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"Equals"
		end

	add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Hashtable"
		alias
			"Add"
		end

	frozen synchronized (table: HASHTABLE): HASHTABLE is
		external
			"IL static signature (System.Collections.Hashtable): System.Collections.Hashtable use System.Collections.Hashtable"
		alias
			"Synchronized"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Hashtable"
		alias
			"GetHashCode"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Collections.Hashtable"
		alias
			"GetObjectData"
		end

	contains_key (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"ContainsKey"
		end

feature {NONE} -- Implementation

	frozen set_hcp (value: IHASH_CODE_PROVIDER) is
		external
			"IL signature (System.Collections.IHashCodeProvider): System.Void use System.Collections.Hashtable"
		alias
			"set_hcp"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Hashtable"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	get_hash (key: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.Hashtable"
		alias
			"GetHash"
		end

	frozen get_comparer: ICOMPARER is
		external
			"IL signature (): System.Collections.IComparer use System.Collections.Hashtable"
		alias
			"get_comparer"
		end

	key_equals (item: SYSTEM_OBJECT; key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object, System.Object): System.Boolean use System.Collections.Hashtable"
		alias
			"KeyEquals"
		end

	frozen get_hcp: IHASH_CODE_PROVIDER is
		external
			"IL signature (): System.Collections.IHashCodeProvider use System.Collections.Hashtable"
		alias
			"get_hcp"
		end

	frozen set_comparer (value: ICOMPARER) is
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

end -- class HASHTABLE
