indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.TraceSwitch"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TRACE_SWITCH

inherit
	SYSTEM_DLL_SWITCH
		redefine
			on_switch_setting_changed
		end

create
	make_system_dll_trace_switch

feature {NONE} -- Initialization

	frozen make_system_dll_trace_switch (display_name: SYSTEM_STRING; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.TraceSwitch"
		end

feature -- Access

	frozen get_trace_info: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceSwitch"
		alias
			"get_TraceInfo"
		end

	frozen get_trace_warning: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceSwitch"
		alias
			"get_TraceWarning"
		end

	frozen get_trace_verbose: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceSwitch"
		alias
			"get_TraceVerbose"
		end

	frozen get_trace_error: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceSwitch"
		alias
			"get_TraceError"
		end

	frozen get_level: SYSTEM_DLL_TRACE_LEVEL is
		external
			"IL signature (): System.Diagnostics.TraceLevel use System.Diagnostics.TraceSwitch"
		alias
			"get_Level"
		end

feature -- Element Change

	frozen set_level (value: SYSTEM_DLL_TRACE_LEVEL) is
		external
			"IL signature (System.Diagnostics.TraceLevel): System.Void use System.Diagnostics.TraceSwitch"
		alias
			"set_Level"
		end

feature {NONE} -- Implementation

	on_switch_setting_changed is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceSwitch"
		alias
			"OnSwitchSettingChanged"
		end

end -- class SYSTEM_DLL_TRACE_SWITCH
