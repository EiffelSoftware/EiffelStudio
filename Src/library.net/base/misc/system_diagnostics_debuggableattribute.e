indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.DebuggableAttribute"

frozen external class
	SYSTEM_DIAGNOSTICS_DEBUGGABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_debuggableattribute

feature {NONE} -- Initialization

	frozen make_debuggableattribute (is_jittracking_enabled: BOOLEAN; is_jitoptimizer_disabled: BOOLEAN) is
		external
			"IL creator signature (System.Boolean, System.Boolean) use System.Diagnostics.DebuggableAttribute"
		end

feature -- Access

	frozen get_is_jitoptimizer_disabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.DebuggableAttribute"
		alias
			"get_IsJITOptimizerDisabled"
		end

	frozen get_is_jittracking_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.DebuggableAttribute"
		alias
			"get_IsJITTrackingEnabled"
		end

end -- class SYSTEM_DIAGNOSTICS_DEBUGGABLEATTRIBUTE
