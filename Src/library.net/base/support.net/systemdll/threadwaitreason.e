indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ThreadWaitReason"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	THREADWAITREASON

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen execution_delay: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"4"
		end

	frozen page_in: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"2"
		end

	frozen user_request: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"6"
		end

	frozen lpc_receive: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"9"
		end

	frozen event_pair_low: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"8"
		end

	frozen page_out: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"12"
		end

	frozen system_allocation: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"3"
		end

	frozen event_pair_high: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"7"
		end

	frozen virtual_memory: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"11"
		end

	frozen unknown: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"13"
		end

	frozen free_page: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"1"
		end

	frozen suspended: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"5"
		end

	frozen executive: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"0"
		end

	frozen lpc_reply: THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"10"
		end

end -- class THREADWAITREASON
