indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.SearchScope"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DIR_SERV_SEARCH_SCOPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen base: DIR_SERV_SEARCH_SCOPE is
		external
			"IL enum signature :System.DirectoryServices.SearchScope use System.DirectoryServices.SearchScope"
		alias
			"0"
		end

	frozen one_level: DIR_SERV_SEARCH_SCOPE is
		external
			"IL enum signature :System.DirectoryServices.SearchScope use System.DirectoryServices.SearchScope"
		alias
			"1"
		end

	frozen subtree: DIR_SERV_SEARCH_SCOPE is
		external
			"IL enum signature :System.DirectoryServices.SearchScope use System.DirectoryServices.SearchScope"
		alias
			"2"
		end

end -- class DIR_SERV_SEARCH_SCOPE
