indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ManualResetEvent"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MANUAL_RESET_EVENT

inherit
	WAIT_HANDLE
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_manual_reset_event

feature {NONE} -- Initialization

	frozen make_manual_reset_event (initial_state: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Threading.ManualResetEvent"
		end

feature -- Basic Operations

	frozen reset: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.ManualResetEvent"
		alias
			"Reset"
		end

	frozen set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.ManualResetEvent"
		alias
			"Set"
		end

end -- class MANUAL_RESET_EVENT
