indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.CookieContainer"

external class
	SYSTEM_NET_COOKIECONTAINER

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

	frozen get_max_cookie_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieContainer"
		alias
			"get_MaxCookieSize"
		end

	frozen get_default: SYSTEM_NET_COOKIECONTAINER is
		external
			"IL static signature (): System.Net.CookieContainer use System.Net.CookieContainer"
		alias
			"get_Default"
		end

	frozen get_per_domain_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CookieContainer"
		alias
			"get_PerDomainCapacity"
		end

	frozen default_cookie_limit: INTEGER is 0x12c

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

	frozen default_cookie_length_limit: INTEGER is 0x1000

	frozen default_per_domain_cookie_limit: INTEGER is 0x14

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

	frozen get_cookies (uri: SYSTEM_URI): SYSTEM_NET_COOKIECOLLECTION is
		external
			"IL signature (System.Uri): System.Net.CookieCollection use System.Net.CookieContainer"
		alias
			"GetCookies"
		end

	frozen add_uri_cookie_collection (uri: SYSTEM_URI; cookies: SYSTEM_NET_COOKIECOLLECTION) is
		external
			"IL signature (System.Uri, System.Net.CookieCollection): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

	frozen set_cookies (uri: SYSTEM_URI; cookie_header: STRING) is
		external
			"IL signature (System.Uri, System.String): System.Void use System.Net.CookieContainer"
		alias
			"SetCookies"
		end

	frozen add (cookies: SYSTEM_NET_COOKIECOLLECTION) is
		external
			"IL signature (System.Net.CookieCollection): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

	frozen add_cookie (cookie: SYSTEM_NET_COOKIE) is
		external
			"IL signature (System.Net.Cookie): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

	frozen get_cookie_header (uri: SYSTEM_URI): STRING is
		external
			"IL signature (System.Uri): System.String use System.Net.CookieContainer"
		alias
			"GetCookieHeader"
		end

	frozen add_uri_cookie (uri: SYSTEM_URI; cookie: SYSTEM_NET_COOKIE) is
		external
			"IL signature (System.Uri, System.Net.Cookie): System.Void use System.Net.CookieContainer"
		alias
			"Add"
		end

end -- class SYSTEM_NET_COOKIECONTAINER
