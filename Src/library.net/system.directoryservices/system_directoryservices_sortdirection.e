indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.SortDirection"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIRECTORYSERVICES_SORTDIRECTION

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

	frozen descending: SYSTEM_DIRECTORYSERVICES_SORTDIRECTION is
		external
			"IL enum signature :System.DirectoryServices.SortDirection use System.DirectoryServices.SortDirection"
		alias
			"1"
		end

	frozen ascending: SYSTEM_DIRECTORYSERVICES_SORTDIRECTION is
		external
			"IL enum signature :System.DirectoryServices.SortDirection use System.DirectoryServices.SortDirection"
		alias
			"0"
		end

end -- class SYSTEM_DIRECTORYSERVICES_SORTDIRECTION
