indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadState"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	THREAD_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen aborted: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"256"
		end

	frozen running: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"0"
		end

	frozen stop_requested: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"1"
		end

	frozen unstarted: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"8"
		end

	frozen background: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"4"
		end

	frozen abort_requested: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"128"
		end

	frozen suspend_requested: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"2"
		end

	frozen stopped: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"16"
		end

	frozen suspended: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"64"
		end

	frozen wait_sleep_join: THREAD_STATE is
		external
			"IL enum signature :System.Threading.ThreadState use System.Threading.ThreadState"
		alias
			"32"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class THREAD_STATE
