indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.SearchResult"

external class
	SYSTEM_DIRECTORYSERVICES_SEARCHRESULT

create {NONE}

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.SearchResult"
		alias
			"get_Path"
		end

	frozen get_properties: SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYCOLLECTION is
		external
			"IL signature (): System.DirectoryServices.ResultPropertyCollection use System.DirectoryServices.SearchResult"
		alias
			"get_Properties"
		end

feature -- Basic Operations

	frozen get_directory_entry: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.SearchResult"
		alias
			"GetDirectoryEntry"
		end

end -- class SYSTEM_DIRECTORYSERVICES_SEARCHRESULT
