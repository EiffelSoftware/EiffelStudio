indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Caching.CacheDependency"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_CACHE_DEPENDENCY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

create
	make,
	make_7,
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make_1

feature {NONE} -- Initialization

	frozen make (filename: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.Caching.CacheDependency"
		end

	frozen make_7 (filenames: NATIVE_ARRAY [SYSTEM_STRING]; cachekeys: NATIVE_ARRAY [SYSTEM_STRING]; dependency: WEB_CACHE_DEPENDENCY; start: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.String[], System.String[], System.Web.Caching.CacheDependency, System.DateTime) use System.Web.Caching.CacheDependency"
		end

	frozen make_6 (filenames: NATIVE_ARRAY [SYSTEM_STRING]; cachekeys: NATIVE_ARRAY [SYSTEM_STRING]; dependency: WEB_CACHE_DEPENDENCY) is
		external
			"IL creator signature (System.String[], System.String[], System.Web.Caching.CacheDependency) use System.Web.Caching.CacheDependency"
		end

	frozen make_5 (filenames: NATIVE_ARRAY [SYSTEM_STRING]; cachekeys: NATIVE_ARRAY [SYSTEM_STRING]; start: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.String[], System.String[], System.DateTime) use System.Web.Caching.CacheDependency"
		end

	frozen make_4 (filenames: NATIVE_ARRAY [SYSTEM_STRING]; cachekeys: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String[], System.String[]) use System.Web.Caching.CacheDependency"
		end

	frozen make_3 (filenames: NATIVE_ARRAY [SYSTEM_STRING]; start: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.String[], System.DateTime) use System.Web.Caching.CacheDependency"
		end

	frozen make_2 (filenames: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String[]) use System.Web.Caching.CacheDependency"
		end

	frozen make_1 (filename: SYSTEM_STRING; start: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.String, System.DateTime) use System.Web.Caching.CacheDependency"
		end

feature -- Access

	frozen get_has_changed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Caching.CacheDependency"
		alias
			"get_HasChanged"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Caching.CacheDependency"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Web.Caching.CacheDependency"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Caching.CacheDependency"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Caching.CacheDependency"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Caching.CacheDependency"
		alias
			"Finalize"
		end

end -- class WEB_CACHE_DEPENDENCY
