indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadPriority"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	THREAD_PRIORITY

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen highest: THREAD_PRIORITY is
		external
			"IL enum signature :System.Threading.ThreadPriority use System.Threading.ThreadPriority"
		alias
			"4"
		end

	frozen lowest: THREAD_PRIORITY is
		external
			"IL enum signature :System.Threading.ThreadPriority use System.Threading.ThreadPriority"
		alias
			"0"
		end

	frozen normal: THREAD_PRIORITY is
		external
			"IL enum signature :System.Threading.ThreadPriority use System.Threading.ThreadPriority"
		alias
			"2"
		end

	frozen above_normal: THREAD_PRIORITY is
		external
			"IL enum signature :System.Threading.ThreadPriority use System.Threading.ThreadPriority"
		alias
			"3"
		end

	frozen below_normal: THREAD_PRIORITY is
		external
			"IL enum signature :System.Threading.ThreadPriority use System.Threading.ThreadPriority"
		alias
			"1"
		end

end -- class THREAD_PRIORITY
