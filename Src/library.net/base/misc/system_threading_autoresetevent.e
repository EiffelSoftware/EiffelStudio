indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.AutoResetEvent"

frozen external class
	SYSTEM_THREADING_AUTORESETEVENT

inherit
	SYSTEM_THREADING_WAITHANDLE
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_autoresetevent

feature {NONE} -- Initialization

	frozen make_autoresetevent (initial_state: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Threading.AutoResetEvent"
		end

feature -- Basic Operations

	frozen reset: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.AutoResetEvent"
		alias
			"Reset"
		end

	frozen set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.AutoResetEvent"
		alias
			"Set"
		end

end -- class SYSTEM_THREADING_AUTORESETEVENT
