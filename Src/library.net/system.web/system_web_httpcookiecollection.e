indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCookieCollection"

frozen external class
	SYSTEM_WEB_HTTPCOOKIECOLLECTION

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
	make_httpcookiecollection

feature {NONE} -- Initialization

	frozen make_httpcookiecollection is
		external
			"IL creator use System.Web.HttpCookieCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_WEB_HTTPCOOKIE is
		external
			"IL signature (System.Int32): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (name: STRING): SYSTEM_WEB_HTTPCOOKIE is
		external
			"IL signature (System.String): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"get_Item"
		end

	frozen get_all_keys: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpCookieCollection"
		alias
			"get_AllKeys"
		end

feature -- Basic Operations

	frozen get_key (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpCookieCollection"
		alias
			"GetKey"
		end

	frozen get (index: INTEGER): SYSTEM_WEB_HTTPCOOKIE is
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

	frozen remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookieCollection"
		alias
			"Remove"
		end

	frozen extend (cookie: SYSTEM_WEB_HTTPCOOKIE) is
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

	frozen set (cookie: SYSTEM_WEB_HTTPCOOKIE) is
		external
			"IL signature (System.Web.HttpCookie): System.Void use System.Web.HttpCookieCollection"
		alias
			"Set"
		end

	frozen get_string (name: STRING): SYSTEM_WEB_HTTPCOOKIE is
		external
			"IL signature (System.String): System.Web.HttpCookie use System.Web.HttpCookieCollection"
		alias
			"Get"
		end

end -- class SYSTEM_WEB_HTTPCOOKIECOLLECTION
