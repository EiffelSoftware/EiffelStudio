indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.SortOption"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_SORT_OPTION

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.DirectoryServices.SortOption"
		end

	frozen make_1 (property_name: SYSTEM_STRING; direction: DIR_SERV_SORT_DIRECTION) is
		external
			"IL creator signature (System.String, System.DirectoryServices.SortDirection) use System.DirectoryServices.SortOption"
		end

feature -- Access

	frozen get_direction: DIR_SERV_SORT_DIRECTION is
		external
			"IL signature (): System.DirectoryServices.SortDirection use System.DirectoryServices.SortOption"
		alias
			"get_Direction"
		end

	frozen get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.SortOption"
		alias
			"get_PropertyName"
		end

feature -- Element Change

	frozen set_direction (value: DIR_SERV_SORT_DIRECTION) is
		external
			"IL signature (System.DirectoryServices.SortDirection): System.Void use System.DirectoryServices.SortOption"
		alias
			"set_Direction"
		end

	frozen set_property_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.SortOption"
		alias
			"set_PropertyName"
		end

end -- class DIR_SERV_SORT_OPTION
