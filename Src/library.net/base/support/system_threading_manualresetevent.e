indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.ManualResetEvent"

frozen external class
	SYSTEM_THREADING_MANUALRESETEVENT

inherit
	SYSTEM_THREADING_WAITHANDLE
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_manualresetevent

feature {NONE} -- Initialization

	frozen make_manualresetevent (initial_state: BOOLEAN) is
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

end -- class SYSTEM_THREADING_MANUALRESETEVENT
