indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataSysDescriptionAttribute"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_SYS_DESCRIPTION_ATTRIBUTE

inherit
	SYSTEM_DLL_DESCRIPTION_ATTRIBUTE
		redefine
			get_description
		end

create
	make_data_data_sys_description_attribute

feature {NONE} -- Initialization

	frozen make_data_data_sys_description_attribute (description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataSysDescriptionAttribute"
		end

feature -- Access

	get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataSysDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class DATA_DATA_SYS_DESCRIPTION_ATTRIBUTE
