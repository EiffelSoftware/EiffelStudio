indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.ThreadState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_THREADING_THREADSTATE

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen aborted: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"256"
		end

	frozen running: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"0"
		end

	frozen stop_requested: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"1"
		end

	frozen unstarted: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"8"
		end

	frozen background: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"4"
		end

	frozen abort_requested: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"128"
		end

	frozen suspend_requested: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"2"
		end

	frozen stopped: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"16"
		end

	frozen suspended: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"64"
		end

	frozen wait_sleep_join: SYSTEM_THREADING_THREADSTATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"32"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_THREADING_THREADSTATE
