indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.SearchResult"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_SEARCH_RESULT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.SearchResult"
		alias
			"get_Path"
		end

	frozen get_properties: DIR_SERV_RESULT_PROPERTY_COLLECTION is
		external
			"IL signature (): System.DirectoryServices.ResultPropertyCollection use System.DirectoryServices.SearchResult"
		alias
			"get_Properties"
		end

feature -- Basic Operations

	frozen get_directory_entry: DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.SearchResult"
		alias
			"GetDirectoryEntry"
		end

end -- class DIR_SERV_SEARCH_RESULT
