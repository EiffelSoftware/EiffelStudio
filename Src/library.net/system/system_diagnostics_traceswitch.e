indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.TraceSwitch"

external class
	SYSTEM_DIAGNOSTICS_TRACESWITCH

inherit
	SYSTEM_DIAGNOSTICS_SWITCH
		redefine
			on_switch_setting_changed
		end

create
	make_traceswitch

feature {NONE} -- Initialization

	frozen make_traceswitch (display_name: STRING; description: STRING) is
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

	frozen get_level: SYSTEM_DIAGNOSTICS_TRACELEVEL is
		external
			"IL signature (): System.Diagnostics.TraceLevel use System.Diagnostics.TraceSwitch"
		alias
			"get_Level"
		end

feature -- Element Change

	frozen set_level (value: SYSTEM_DIAGNOSTICS_TRACELEVEL) is
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

end -- class SYSTEM_DIAGNOSTICS_TRACESWITCH
