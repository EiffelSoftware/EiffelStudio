indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.NameObjectCollectionBase"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end
	IENUMERABLE
	ISERIALIZABLE
	IDESERIALIZATION_CALLBACK

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"get_Count"
		end

	get_keys: SYSTEM_DLL_KEYS_COLLECTION_IN_SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE is
		external
			"IL signature (): System.Collections.Specialized.NameObjectCollectionBase+KeysCollection use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"get_Keys"
		end

feature -- Basic Operations

	on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"OnDeserialization"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"GetEnumerator"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen base_get_all_values_type (type: TYPE): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type): System.Object[] use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetAllValues"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen base_get_all_keys: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetAllKeys"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"Finalize"
		end

	frozen base_remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseRemove"
		end

	frozen base_get_key (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetKey"
		end

	frozen base_get_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGet"
		end

	frozen base_set (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseSet"
		end

	frozen base_get_all_values: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetAllValues"
		end

	frozen base_set_string (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseSet"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"get_IsReadOnly"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen base_clear is
		external
			"IL signature (): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseClear"
		end

	frozen base_add (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseAdd"
		end

	frozen base_get (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGet"
		end

	frozen set_is_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"set_IsReadOnly"
		end

	frozen base_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseRemoveAt"
		end

	frozen base_has_keys: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseHasKeys"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE
