indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ResolveEventArgs"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RESOLVE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_resolve_event_args

feature {NONE} -- Initialization

	frozen make_resolve_event_args (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ResolveEventArgs"
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ResolveEventArgs"
		alias
			"get_Name"
		end

end -- class RESOLVE_EVENT_ARGS
