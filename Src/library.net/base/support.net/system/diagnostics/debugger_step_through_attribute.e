indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.DebuggerStepThroughAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DEBUGGER_STEP_THROUGH_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_debugger_step_through_attribute

feature {NONE} -- Initialization

	frozen make_debugger_step_through_attribute is
		external
			"IL creator use System.Diagnostics.DebuggerStepThroughAttribute"
		end

end -- class DEBUGGER_STEP_THROUGH_ATTRIBUTE
