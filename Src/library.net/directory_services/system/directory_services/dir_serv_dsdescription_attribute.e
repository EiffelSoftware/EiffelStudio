indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DSDescriptionAttribute"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DSDESCRIPTION_ATTRIBUTE

inherit
	SYSTEM_DLL_DESCRIPTION_ATTRIBUTE
		redefine
			get_description
		end

create
	make_dir_serv_dsdescription_attribute

feature {NONE} -- Initialization

	frozen make_dir_serv_dsdescription_attribute (description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.DirectoryServices.DSDescriptionAttribute"
		end

feature -- Access

	get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DSDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class DIR_SERV_DSDESCRIPTION_ATTRIBUTE
