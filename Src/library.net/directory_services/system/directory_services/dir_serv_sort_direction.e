indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.SortDirection"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DIR_SERV_SORT_DIRECTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen descending: DIR_SERV_SORT_DIRECTION is
		external
			"IL enum signature :System.DirectoryServices.SortDirection use System.DirectoryServices.SortDirection"
		alias
			"1"
		end

	frozen ascending: DIR_SERV_SORT_DIRECTION is
		external
			"IL enum signature :System.DirectoryServices.SortDirection use System.DirectoryServices.SortDirection"
		alias
			"0"
		end

end -- class DIR_SERV_SORT_DIRECTION
