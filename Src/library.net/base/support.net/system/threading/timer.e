indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.Timer"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TIMER

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	IDISPOSABLE

create
	make_timer,
	make_timer_2,
	make_timer_1

feature {NONE} -- Initialization

	frozen make_timer (callback: TIMER_CALLBACK; state: SYSTEM_OBJECT; due_time: INTEGER; period: INTEGER) is
		external
			"IL creator signature (System.Threading.TimerCallback, System.Object, System.Int32, System.Int32) use System.Threading.Timer"
		end

	frozen make_timer_2 (callback: TIMER_CALLBACK; state: SYSTEM_OBJECT; due_time: INTEGER_64; period: INTEGER_64) is
		external
			"IL creator signature (System.Threading.TimerCallback, System.Object, System.Int64, System.Int64) use System.Threading.Timer"
		end

	frozen make_timer_1 (callback: TIMER_CALLBACK; state: SYSTEM_OBJECT; due_time: TIME_SPAN; period: TIME_SPAN) is
		external
			"IL creator signature (System.Threading.TimerCallback, System.Object, System.TimeSpan, System.TimeSpan) use System.Threading.Timer"
		end

feature -- Basic Operations

	frozen change (due_time: INTEGER_64; period: INTEGER_64): BOOLEAN is
		external
			"IL signature (System.Int64, System.Int64): System.Boolean use System.Threading.Timer"
		alias
			"Change"
		end

	frozen dispose_wait_handle (notify_object: WAIT_HANDLE): BOOLEAN is
		external
			"IL signature (System.Threading.WaitHandle): System.Boolean use System.Threading.Timer"
		alias
			"Dispose"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Threading.Timer"
		alias
			"Dispose"
		end

	frozen change_time_span (due_time: TIME_SPAN; period: TIME_SPAN): BOOLEAN is
		external
			"IL signature (System.TimeSpan, System.TimeSpan): System.Boolean use System.Threading.Timer"
		alias
			"Change"
		end

	frozen change_int32 (due_time: INTEGER; period: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Threading.Timer"
		alias
			"Change"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Threading.Timer"
		alias
			"Finalize"
		end

end -- class TIMER
