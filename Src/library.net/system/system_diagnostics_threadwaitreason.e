indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ThreadWaitReason"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_THREADWAITREASON

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen execution_delay: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"4"
		end

	frozen page_in: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"2"
		end

	frozen user_request: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"6"
		end

	frozen lpc_receive: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"9"
		end

	frozen event_pair_low: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"8"
		end

	frozen page_out: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"12"
		end

	frozen system_allocation: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"3"
		end

	frozen event_pair_high: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"7"
		end

	frozen virtual_memory: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"11"
		end

	frozen unknown: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"13"
		end

	frozen free_page: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"1"
		end

	frozen suspended: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"5"
		end

	frozen executive: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"0"
		end

	frozen lpc_reply: SYSTEM_DIAGNOSTICS_THREADWAITREASON is
		external
			"IL enum signature :System.Diagnostics.ThreadWaitReason use System.Diagnostics.ThreadWaitReason"
		alias
			"10"
		end

end -- class SYSTEM_DIAGNOSTICS_THREADWAITREASON
