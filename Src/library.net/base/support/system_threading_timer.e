indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.Timer"

frozen external class
	SYSTEM_THREADING_TIMER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (callback: SYSTEM_THREADING_TIMERCALLBACK; state: ANY; due_time: INTEGER_64; period: INTEGER_64) is
		external
			"IL creator signature (System.Threading.TimerCallback, System.Object, System.Int64, System.Int64) use System.Threading.Timer"
		end

	frozen make (callback: SYSTEM_THREADING_TIMERCALLBACK; state: ANY; due_time: INTEGER; period: INTEGER) is
		external
			"IL creator signature (System.Threading.TimerCallback, System.Object, System.Int32, System.Int32) use System.Threading.Timer"
		end

	frozen make_1 (callback: SYSTEM_THREADING_TIMERCALLBACK; state: ANY; due_time: SYSTEM_TIMESPAN; period: SYSTEM_TIMESPAN) is
		external
			"IL creator signature (System.Threading.TimerCallback, System.Object, System.TimeSpan, System.TimeSpan) use System.Threading.Timer"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Threading.Timer"
		alias
			"ToString"
		end

	frozen change_time_span (due_time: SYSTEM_TIMESPAN; period: SYSTEM_TIMESPAN): BOOLEAN is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Threading.Timer"
		alias
			"Equals"
		end

	frozen change (due_time: INTEGER_64; period: INTEGER_64): BOOLEAN is
		external
			"IL signature (System.Int64, System.Int64): System.Boolean use System.Threading.Timer"
		alias
			"Change"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Threading.Timer"
		alias
			"Dispose"
		end

	frozen dispose_wait_handle (notify_object: SYSTEM_THREADING_WAITHANDLE): BOOLEAN is
		external
			"IL signature (System.Threading.WaitHandle): System.Boolean use System.Threading.Timer"
		alias
			"Dispose"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Threading.Timer"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Threading.Timer"
		alias
			"Finalize"
		end

end -- class SYSTEM_THREADING_TIMER
