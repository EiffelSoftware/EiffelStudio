indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.NameValueCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_NAME_VALUE_COLLECTION

inherit
	SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end
	IENUMERABLE
	ISERIALIZABLE
	IDESERIALIZATION_CALLBACK

create
	make_system_dll_name_value_collection_5,
	make_system_dll_name_value_collection_4,
	make_system_dll_name_value_collection_3,
	make_system_dll_name_value_collection_2,
	make_system_dll_name_value_collection_1,
	make_system_dll_name_value_collection

feature {NONE} -- Initialization

	frozen make_system_dll_name_value_collection_5 (capacity: INTEGER; hash_provider: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Int32, System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_system_dll_name_value_collection_4 (capacity: INTEGER; col: SYSTEM_DLL_NAME_VALUE_COLLECTION) is
		external
			"IL creator signature (System.Int32, System.Collections.Specialized.NameValueCollection) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_system_dll_name_value_collection_3 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_system_dll_name_value_collection_2 (hash_provider: IHASH_CODE_PROVIDER; comparer: ICOMPARER) is
		external
			"IL creator signature (System.Collections.IHashCodeProvider, System.Collections.IComparer) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_system_dll_name_value_collection_1 (col: SYSTEM_DLL_NAME_VALUE_COLLECTION) is
		external
			"IL creator signature (System.Collections.Specialized.NameValueCollection) use System.Collections.Specialized.NameValueCollection"
		end

	frozen make_system_dll_name_value_collection is
		external
			"IL creator use System.Collections.Specialized.NameValueCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"get_Item"
		end

	get_all_keys: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Collections.Specialized.NameValueCollection"
		alias
			"get_AllKeys"
		end

feature -- Element Change

	frozen set_item (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_key (index: INTEGER): SYSTEM_STRING is
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

	add_string (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Add"
		end

	get (name: SYSTEM_STRING): SYSTEM_STRING is
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

	get_values (name: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.Collections.Specialized.NameValueCollection"
		alias
			"GetValues"
		end

	remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Remove"
		end

	get_int32 (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameValueCollection"
		alias
			"Get"
		end

	frozen add (c: SYSTEM_DLL_NAME_VALUE_COLLECTION) is
		external
			"IL signature (System.Collections.Specialized.NameValueCollection): System.Void use System.Collections.Specialized.NameValueCollection"
		alias
			"Add"
		end

	get_values_int32 (index: INTEGER): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.Int32): System.String[] use System.Collections.Specialized.NameValueCollection"
		alias
			"GetValues"
		end

	set (name: SYSTEM_STRING; value: SYSTEM_STRING) is
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

end -- class SYSTEM_DLL_NAME_VALUE_COLLECTION
