indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.NameObjectCollectionBase"

deferred external class
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			copy_to as icollection_copy_to
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"get_Count"
		end

	get_keys: KEYSCOLLECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE is
		external
			"IL signature (): System.Collections.Specialized.NameObjectCollectionBase+KeysCollection use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"get_Keys"
		end

feature -- Basic Operations

	on_deserialization (sender: ANY) is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"GetEnumerator"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"GetObjectData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen base_get_all_values_type (type: SYSTEM_TYPE): ARRAY [ANY] is
		external
			"IL signature (System.Type): System.Object[] use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetAllValues"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen base_get_all_keys: ARRAY [STRING] is
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

	frozen base_remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseRemove"
		end

	frozen base_get_key (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetKey"
		end

	frozen base_get_string (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGet"
		end

	frozen base_set (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseSet"
		end

	frozen base_get_all_values: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseGetAllValues"
		end

	frozen base_set_string (name: STRING; value: ANY) is
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

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
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

	frozen base_add (name: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"BaseAdd"
		end

	frozen base_get (index: INTEGER): ANY is
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

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Specialized.NameObjectCollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE
