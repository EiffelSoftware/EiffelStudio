indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Caching.CacheDependency"

frozen external class
	SYSTEM_WEB_CACHING_CACHEDEPENDENCY

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (filenames: ARRAY [STRING]; cachekeys: ARRAY [STRING]) is
		external
			"IL creator signature (System.String[], System.String[]) use System.Web.Caching.CacheDependency"
		end

	frozen make (filename: STRING) is
		external
			"IL creator signature (System.String) use System.Web.Caching.CacheDependency"
		end

	frozen make_1 (filenames: ARRAY [STRING]) is
		external
			"IL creator signature (System.String[]) use System.Web.Caching.CacheDependency"
		end

end -- class SYSTEM_WEB_CACHING_CACHEDEPENDENCY
