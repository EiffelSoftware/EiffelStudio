indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCookieCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_COOKIE_COLLECTION

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
	make_web_http_cookie_collection

feature {NONE} -- Initialization

	frozen make_web_http_cookie_collection is
		external
			"IL creator use System.Web.HttpCookieCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): WEB_HTTP_COOKIE is
		external
			"IL signature (System.Int32): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (name: SYSTEM_STRING): WEB_HTTP_COOKIE is
		external
			"IL signature (System.String): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"get_Item"
		end

	frozen get_all_keys: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpCookieCollection"
		alias
			"get_AllKeys"
		end

feature -- Basic Operations

	frozen get_key (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpCookieCollection"
		alias
			"GetKey"
		end

	frozen get (index: INTEGER): WEB_HTTP_COOKIE is
		external
			"IL signature (System.Int32): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"Get"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.HttpCookieCollection"
		alias
			"CopyTo"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookieCollection"
		alias
			"Remove"
		end

	frozen add (cookie: WEB_HTTP_COOKIE) is
		external
			"IL signature (System.Web.HttpCookie): System.Void use System.Web.HttpCookieCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.HttpCookieCollection"
		alias
			"Clear"
		end

	frozen set (cookie: WEB_HTTP_COOKIE) is
		external
			"IL signature (System.Web.HttpCookie): System.Void use System.Web.HttpCookieCollection"
		alias
			"Set"
		end

	frozen get_string (name: SYSTEM_STRING): WEB_HTTP_COOKIE is
		external
			"IL signature (System.String): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"Get"
		end

end -- class WEB_HTTP_COOKIE_COLLECTION
