indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.CookieContainer"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COOKIE_CONTAINER

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (capacity: INTEGER; per_domain_capacity: INTEGER; max_cookie_size: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.Net.CookieContainer"
		end

	frozen make is
		external
			"IL creator use System.Net.CookieContainer"
		end

	frozen make_1 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Net.CookieContainer"
		end

feature -- Access

	frozen default_per_domain_cookie_limit: INTEGER is 0x14

	frozen get_max_cookie_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieContainer"
		alias
			"get_MaxCookieSize"
		end

	frozen get_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieContainer"
		alias
			"get_Capacity"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieContainer"
		alias
			"get_Count"
		end

	frozen default_cookie_limit: INTEGER is 0x12c

	frozen default_cookie_length_limit: INTEGER is 0x1000

	frozen get_per_domain_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieContainer"
		alias
			"get_PerDomainCapacity"
		end

feature -- Element Change

	frozen set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.CookieContainer"
		alias
			"set_Capacity"
		end

	frozen set_per_domain_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.CookieContainer"
		alias
			"set_PerDomainCapacity"
		end

	frozen set_max_cookie_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.CookieContainer"
		alias
			"set_MaxCookieSize"
		end

feature -- Basic Operations

	frozen get_cookies (uri: SYSTEM_DLL_URI): SYSTEM_DLL_COOKIE_COLLECTION is
		external
			"IL signature (System.Uri): System.Net.CookieCollection use System.Net.CookieContainer"
		alias
			"GetCookies"
		end

	frozen add_uri_cookie_collection (uri: SYSTEM_DLL_URI; cookies: SYSTEM_DLL_COOKIE_COLLECTION) is
		external
			"IL signature (System.Uri, System.Net.CookieCollection): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

	frozen set_cookies (uri: SYSTEM_DLL_URI; cookie_header: SYSTEM_STRING) is
		external
			"IL signature (System.Uri, System.String): System.Void use System.Net.CookieContainer"
		alias
			"SetCookies"
		end

	frozen add (cookies: SYSTEM_DLL_COOKIE_COLLECTION) is
		external
			"IL signature (System.Net.CookieCollection): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

	frozen add_cookie (cookie: SYSTEM_DLL_COOKIE) is
		external
			"IL signature (System.Net.Cookie): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

	frozen get_cookie_header (uri: SYSTEM_DLL_URI): SYSTEM_STRING is
		external
			"IL signature (System.Uri): System.String use System.Net.CookieContainer"
		alias
			"GetCookieHeader"
		end

	frozen add_uri_cookie (uri: SYSTEM_DLL_URI; cookie: SYSTEM_DLL_COOKIE) is
		external
			"IL signature (System.Uri, System.Net.Cookie): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

end -- class SYSTEM_DLL_COOKIE_CONTAINER
