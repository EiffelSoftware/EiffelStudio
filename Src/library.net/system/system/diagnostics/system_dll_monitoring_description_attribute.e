indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.MonitoringDescriptionAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_MONITORING_DESCRIPTION_ATTRIBUTE

inherit
	SYSTEM_DLL_DESCRIPTION_ATTRIBUTE
		redefine
			get_description
		end

create
	make_system_dll_monitoring_description_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_monitoring_description_attribute (description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.MonitoringDescriptionAttribute"
		end

feature -- Access

	get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.MonitoringDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_DLL_MONITORING_DESCRIPTION_ATTRIBUTE
