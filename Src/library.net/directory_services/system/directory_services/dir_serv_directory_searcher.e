indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectorySearcher"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_SEARCHER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_dir_serv_directory_searcher_1,
	make_dir_serv_directory_searcher_6,
	make_dir_serv_directory_searcher,
	make_dir_serv_directory_searcher_4,
	make_dir_serv_directory_searcher_5,
	make_dir_serv_directory_searcher_7,
	make_dir_serv_directory_searcher_2,
	make_dir_serv_directory_searcher_3

feature {NONE} -- Initialization

	frozen make_dir_serv_directory_searcher_1 (search_root: DIR_SERV_DIRECTORY_ENTRY) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher_6 (filter: SYSTEM_STRING; properties_to_load: NATIVE_ARRAY [SYSTEM_STRING]; scope: DIR_SERV_SEARCH_SCOPE) is
		external
			"IL creator signature (System.String, System.String[], System.DirectoryServices.SearchScope) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher is
		external
			"IL creator use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher_4 (filter: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher_5 (filter: SYSTEM_STRING; properties_to_load: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String, System.String[]) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher_7 (search_root: DIR_SERV_DIRECTORY_ENTRY; filter: SYSTEM_STRING; properties_to_load: NATIVE_ARRAY [SYSTEM_STRING]; scope: DIR_SERV_SEARCH_SCOPE) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry, System.String, System.String[], System.DirectoryServices.SearchScope) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher_2 (search_root: DIR_SERV_DIRECTORY_ENTRY; filter: SYSTEM_STRING) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry, System.String) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_dir_serv_directory_searcher_3 (search_root: DIR_SERV_DIRECTORY_ENTRY; filter: SYSTEM_STRING; properties_to_load: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry, System.String, System.String[]) use System.DirectoryServices.DirectorySearcher"
		end

feature -- Access

	frozen get_search_scope: DIR_SERV_SEARCH_SCOPE is
		external
			"IL signature (): System.DirectoryServices.SearchScope use System.DirectoryServices.DirectorySearcher"
		alias
			"get_SearchScope"
		end

	frozen get_server_time_limit: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ServerTimeLimit"
		end

	frozen get_size_limit: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.DirectorySearcher"
		alias
			"get_SizeLimit"
		end

	frozen get_filter: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectorySearcher"
		alias
			"get_Filter"
		end

	frozen get_property_names_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.DirectorySearcher"
		alias
			"get_PropertyNamesOnly"
		end

	frozen get_server_page_time_limit: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ServerPageTimeLimit"
		end

	frozen get_client_timeout: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ClientTimeout"
		end

	frozen get_search_root: DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectorySearcher"
		alias
			"get_SearchRoot"
		end

	frozen get_referral_chasing: DIR_SERV_REFERRAL_CHASING_OPTION is
		external
			"IL signature (): System.DirectoryServices.ReferralChasingOption use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ReferralChasing"
		end

	frozen get_properties_to_load: SYSTEM_DLL_STRING_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.StringCollection use System.DirectoryServices.DirectorySearcher"
		alias
			"get_PropertiesToLoad"
		end

	frozen get_cache_results: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.DirectorySearcher"
		alias
			"get_CacheResults"
		end

	frozen get_page_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.DirectorySearcher"
		alias
			"get_PageSize"
		end

	frozen get_sort: DIR_SERV_SORT_OPTION is
		external
			"IL signature (): System.DirectoryServices.SortOption use System.DirectoryServices.DirectorySearcher"
		alias
			"get_Sort"
		end

feature -- Element Change

	frozen set_property_names_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_PropertyNamesOnly"
		end

	frozen set_sort (value: DIR_SERV_SORT_OPTION) is
		external
			"IL signature (System.DirectoryServices.SortOption): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_Sort"
		end

	frozen set_search_root (value: DIR_SERV_DIRECTORY_ENTRY) is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_SearchRoot"
		end

	frozen set_server_time_limit (value: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ServerTimeLimit"
		end

	frozen set_client_timeout (value: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ClientTimeout"
		end

	frozen set_referral_chasing (value: DIR_SERV_REFERRAL_CHASING_OPTION) is
		external
			"IL signature (System.DirectoryServices.ReferralChasingOption): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ReferralChasing"
		end

	frozen set_size_limit (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_SizeLimit"
		end

	frozen set_server_page_time_limit (value: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ServerPageTimeLimit"
		end

	frozen set_filter (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_Filter"
		end

	frozen set_search_scope (value: DIR_SERV_SEARCH_SCOPE) is
		external
			"IL signature (System.DirectoryServices.SearchScope): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_SearchScope"
		end

	frozen set_page_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_PageSize"
		end

	frozen set_cache_results (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_CacheResults"
		end

feature -- Basic Operations

	frozen find_all: DIR_SERV_SEARCH_RESULT_COLLECTION is
		external
			"IL signature (): System.DirectoryServices.SearchResultCollection use System.DirectoryServices.DirectorySearcher"
		alias
			"FindAll"
		end

	frozen find_one: DIR_SERV_SEARCH_RESULT is
		external
			"IL signature (): System.DirectoryServices.SearchResult use System.DirectoryServices.DirectorySearcher"
		alias
			"FindOne"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"Dispose"
		end

end -- class DIR_SERV_DIRECTORY_SEARCHER
