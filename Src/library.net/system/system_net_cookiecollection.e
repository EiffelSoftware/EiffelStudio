indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.CookieCollection"

external class
	SYSTEM_NET_COOKIECOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.CookieCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.CookieCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (name: STRING): SYSTEM_NET_COOKIE is
		external
			"IL signature (System.String): System.Net.Cookie use System.Net.CookieCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Net.CookieCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.CookieCollection"
		alias
			"get_IsReadOnly"
		end

	frozen get_item_int32 (index: INTEGER): SYSTEM_NET_COOKIE is
		external
			"IL signature (System.Int32): System.Net.Cookie use System.Net.CookieCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.CookieCollection"
		alias
			"GetEnumerator"
		end

	frozen add_cookie (cookie: SYSTEM_NET_COOKIE) is
		external
			"IL signature (System.Net.Cookie): System.Void use System.Net.CookieCollection"
		alias
			"Add"
		end

	frozen add (cookies: SYSTEM_NET_COOKIECOLLECTION) is
		external
			"IL signature (System.Net.CookieCollection): System.Void use System.Net.CookieCollection"
		alias
			"Add"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.CookieCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Net.CookieCollection"
		alias
			"CopyTo"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.CookieCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Net.CookieCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_NET_COOKIECOLLECTION
