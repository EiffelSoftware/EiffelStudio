indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.SearchScope"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen base: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE is
		external
			"IL enum signature :System.DirectoryServices.SearchScope use System.DirectoryServices.SearchScope"
		alias
			"0"
		end

	frozen one_level: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE is
		external
			"IL enum signature :System.DirectoryServices.SearchScope use System.DirectoryServices.SearchScope"
		alias
			"1"
		end

	frozen subtree: SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE is
		external
			"IL enum signature :System.DirectoryServices.SearchScope use System.DirectoryServices.SearchScope"
		alias
			"2"
		end

end -- class SYSTEM_DIRECTORYSERVICES_SEARCHSCOPE
