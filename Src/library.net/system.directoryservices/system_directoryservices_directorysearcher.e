indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectorySearcher"

external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYSEARCHER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE

create
	make_directorysearcher,
	make_directorysearcher_1,
	make_directorysearcher_2,
	make_directorysearcher_3,
	make_directorysearcher_4,
	make_directorysearcher_5,
	make_directorysearcher_6,
	make_directorysearcher_7

feature {NONE} -- Initialization

	frozen make_directorysearcher is
		external
			"IL creator use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_1 (search_root: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_2 (search_root: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY; filter: STRING) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry, System.String) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_3 (search_root: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY; filter: STRING; properties_to_load: ARRAY [STRING]) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry, System.String, System.String[]) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_4 (filter: STRING) is
		external
			"IL creator signature (System.String) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_5 (filter: STRING; properties_to_load: ARRAY [STRING]) is
		external
			"IL creator signature (System.String, System.String[]) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_6 (filter: STRING; properties_to_load: ARRAY [STRING]; scope: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE) is
		external
			"IL creator signature (System.String, System.String[], System.DirectoryServices.SearchScope) use System.DirectoryServices.DirectorySearcher"
		end

	frozen make_directorysearcher_7 (search_root: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY; filter: STRING; properties_to_load: ARRAY [STRING]; scope: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryEntry, System.String, System.String[], System.DirectoryServices.SearchScope) use System.DirectoryServices.DirectorySearcher"
		end

feature -- Access

	frozen get_search_scope: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE is
		external
			"IL signature (): System.DirectoryServices.SearchScope use System.DirectoryServices.DirectorySearcher"
		alias
			"get_SearchScope"
		end

	frozen get_server_time_limit: SYSTEM_TIMESPAN is
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

	frozen get_filter: STRING is
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

	frozen get_server_page_time_limit: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ServerPageTimeLimit"
		end

	frozen get_client_timeout: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ClientTimeout"
		end

	frozen get_search_root: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectorySearcher"
		alias
			"get_SearchRoot"
		end

	frozen get_referral_chasing: SYSTEM_DIRECTORYSERVICES_REFERRALCHASINGOPTION is
		external
			"IL signature (): System.DirectoryServices.ReferralChasingOption use System.DirectoryServices.DirectorySearcher"
		alias
			"get_ReferralChasing"
		end

	frozen get_properties_to_load: SYSTEM_COLLECTIONS_SPECIALIZED_STRINGCOLLECTION is
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

	frozen get_sort: SYSTEM_DIRECTORYSERVICES_SORTOPTION is
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

	frozen set_sort (value: SYSTEM_DIRECTORYSERVICES_SORTOPTION) is
		external
			"IL signature (System.DirectoryServices.SortOption): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_Sort"
		end

	frozen set_search_root (value: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY) is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_SearchRoot"
		end

	frozen set_server_time_limit (value: SYSTEM_TIMESPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ServerTimeLimit"
		end

	frozen set_client_timeout (value: SYSTEM_TIMESPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ClientTimeout"
		end

	frozen set_referral_chasing (value: SYSTEM_DIRECTORYSERVICES_REFERRALCHASINGOPTION) is
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

	frozen set_server_page_time_limit (value: SYSTEM_TIMESPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_ServerPageTimeLimit"
		end

	frozen set_filter (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectorySearcher"
		alias
			"set_Filter"
		end

	frozen set_search_scope (value: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE) is
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

	frozen find_one: SYSTEM_DIRECTORYSERVICES_SEARCHRESULT is
		external
			"IL signature (): System.DirectoryServices.SearchResult use System.DirectoryServices.DirectorySearcher"
		alias
			"FindOne"
		end

	frozen find_all: SYSTEM_DIRECTORYSERVICES_SEARCHRESULTCOLLECTION is
		external
			"IL signature (): System.DirectoryServices.SearchResultCollection use System.DirectoryServices.DirectorySearcher"
		alias
			"FindAll"
		end

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYSEARCHER
