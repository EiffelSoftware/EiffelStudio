indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.SortOption"

external class
	SYSTEM_DIRECTORYSERVICES_SORTOPTION

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.DirectoryServices.SortOption"
		end

	frozen make_1 (property_name: STRING; direction: SYSTEM_DIRECTORYSERVICES_SORTDIRECTION) is
		external
			"IL creator signature (System.String, System.DirectoryServices.SortDirection) use System.DirectoryServices.SortOption"
		end

feature -- Access

	frozen get_direction: SYSTEM_DIRECTORYSERVICES_SORTDIRECTION is
		external
			"IL signature (): System.DirectoryServices.SortDirection use System.DirectoryServices.SortOption"
		alias
			"get_Direction"
		end

	frozen get_property_name: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.SortOption"
		alias
			"get_PropertyName"
		end

feature -- Element Change

	frozen set_direction (value: SYSTEM_DIRECTORYSERVICES_SORTDIRECTION) is
		external
			"IL signature (System.DirectoryServices.SortDirection): System.Void use System.DirectoryServices.SortOption"
		alias
			"set_Direction"
		end

	frozen set_property_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.SortOption"
		alias
			"set_PropertyName"
		end

end -- class SYSTEM_DIRECTORYSERVICES_SORTOPTION
