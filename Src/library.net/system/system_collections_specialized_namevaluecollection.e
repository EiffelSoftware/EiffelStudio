indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.NameValueCollection"

external class
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION

inherit
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			copy_to as icollection_copy_to
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE

create
	make_namevaluecollection,
	make_namevaluecollection_3,
	make_namevaluecollection_2,
	make_namevaluecollection_1,
	make_namevaluecollection_4,
	make_namevaluecollection_5

feature {NONE} -- Initialization

	frozen make_namevaluecollection is
		external
			"IL creator use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_namevaluecollection_3 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_namevaluecollection_2 (hash_provider: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_namevaluecollection_1 (col: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION) is
		external
			"IL creator signature (System.Collections.Specialized.NameValueCollection) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_namevaluecollection_4 (capacity: INTEGER; col: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION) is
		external
			"IL creator signature (System.Int32, System.Collections.Specialized.NameValueCollection) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_namevaluecollection_5 (capacity: INTEGER; hash_provider: SYSTEM_COLLECTIONS_IHASHCODEPROVIDER; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Int32, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Specialized.NameValueCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"get_Item"
		end

	get_all_keys: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Collections.Specialized.NameValueCollection"
		alias
			"get_AllKeys"
		end

feature -- Element Change

	frozen put_i_th (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_key (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"GetKey"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Clear"
		end

	frozen has_keys: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.NameValueCollection"
		alias
			"HasKeys"
		end

	add_string (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Add"
		end

	get (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"Get"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"CopyTo"
		end

	get_values (name: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Collections.Specialized.NameValueCollection"
		alias
			"GetValues"
		end

	remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Remove"
		end

	get_int32 (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"Get"
		end

	frozen extend (c: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION) is
		external
			"IL signature (System.Collections.Specialized.NameValueCollection): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Add"
		end

	get_values_int32 (index: INTEGER): ARRAY [STRING] is
		external
			"IL signature (System.Int32): System.String[] use System.Collections.Specialized.NameValueCollection"
		alias
			"GetValues"
		end

	set (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Set"
		end

feature {NONE} -- Implementation

	frozen invalidate_cached_arrays is
		external
			"IL signature (): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"InvalidateCachedArrays"
		end

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION
