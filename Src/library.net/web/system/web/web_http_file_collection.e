indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpFileCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_FILE_COLLECTION

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

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): WEB_HTTP_POSTED_FILE is
		external
			"IL signature (System.Int32): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (name: SYSTEM_STRING): WEB_HTTP_POSTED_FILE is
		external
			"IL signature (System.String): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"get_Item"
		end

	frozen get_all_keys: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpFileCollection"
		alias
			"get_AllKeys"
		end

feature -- Basic Operations

	frozen get_key (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpFileCollection"
		alias
			"GetKey"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.HttpFileCollection"
		alias
			"CopyTo"
		end

	frozen get (index: INTEGER): WEB_HTTP_POSTED_FILE is
		external
			"IL signature (System.Int32): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"Get"
		end

	frozen get_string (name: SYSTEM_STRING): WEB_HTTP_POSTED_FILE is
		external
			"IL signature (System.String): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"Get"
		end

end -- class WEB_HTTP_FILE_COLLECTION
