indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EventArgs"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	EVENT_ARGS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EventArgs"
		end

feature -- Access

	frozen empty: EVENT_ARGS is
		external
			"IL static_field signature :System.EventArgs use System.EventArgs"
		alias
			"Empty"
		end

end -- class EVENT_ARGS
