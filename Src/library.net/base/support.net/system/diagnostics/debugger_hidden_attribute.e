indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.DebuggerHiddenAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DEBUGGER_HIDDEN_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_debugger_hidden_attribute

feature {NONE} -- Initialization

	frozen make_debugger_hidden_attribute is
		external
			"IL creator use System.Diagnostics.DebuggerHiddenAttribute"
		end

end -- class DEBUGGER_HIDDEN_ATTRIBUTE
