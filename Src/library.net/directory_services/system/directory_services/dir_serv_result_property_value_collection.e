indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.ResultPropertyValueCollection"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_RESULT_PROPERTY_VALUE_COLLECTION

inherit
	READ_ONLY_COLLECTION_BASE
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"Contains"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (values: NATIVE_ARRAY [SYSTEM_OBJECT]; index: INTEGER) is
		external
			"IL signature (System.Object[], System.Int32): System.Void use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"CopyTo"
		end

end -- class DIR_SERV_RESULT_PROPERTY_VALUE_COLLECTION
