indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.DebuggableAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DEBUGGABLE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_debuggable_attribute

feature {NONE} -- Initialization

	frozen make_debuggable_attribute (is_jittracking_enabled: BOOLEAN; is_jitoptimizer_disabled: BOOLEAN) is
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

end -- class DEBUGGABLE_ATTRIBUTE
