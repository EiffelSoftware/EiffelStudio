indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ProcessThread"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	PROCESSTHREAD

inherit
	COMPONENT
	ICOMPONENT
	IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_current_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.ProcessThread"
		alias
			"get_CurrentPriority"
		end

	frozen get_thread_state: THREAD_STATE is
		external
			"IL signature (): System.Diagnostics.ThreadState use System.Diagnostics.ProcessThread"
		alias
			"get_ThreadState"
		end

	frozen get_start_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.ProcessThread"
		alias
			"get_StartTime"
		end

	frozen get_total_processor_time: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.Diagnostics.ProcessThread"
		alias
			"get_TotalProcessorTime"
		end

	frozen get_start_address: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.ProcessThread"
		alias
			"get_StartAddress"
		end

	frozen get_base_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.ProcessThread"
		alias
			"get_BasePriority"
		end

	frozen get_wait_reason: THREADWAITREASON is
		external
			"IL signature (): System.Diagnostics.ThreadWaitReason use System.Diagnostics.ProcessThread"
		alias
			"get_WaitReason"
		end

	frozen get_priority_level: THREADPRIORITYLEVEL is
		external
			"IL signature (): System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ProcessThread"
		alias
			"get_PriorityLevel"
		end

	frozen get_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.ProcessThread"
		alias
			"get_Id"
		end

	frozen get_priority_boost_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessThread"
		alias
			"get_PriorityBoostEnabled"
		end

	frozen get_user_processor_time: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.Diagnostics.ProcessThread"
		alias
			"get_UserProcessorTime"
		end

	frozen get_privileged_processor_time: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.Diagnostics.ProcessThread"
		alias
			"get_PrivilegedProcessorTime"
		end

feature -- Element Change

	frozen set_priority_level (value: THREADPRIORITYLEVEL) is
		external
			"IL signature (System.Diagnostics.ThreadPriorityLevel): System.Void use System.Diagnostics.ProcessThread"
		alias
			"set_PriorityLevel"
		end

	frozen set_priority_boost_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessThread"
		alias
			"set_PriorityBoostEnabled"
		end

	frozen set_ideal_processor (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Diagnostics.ProcessThread"
		alias
			"set_IdealProcessor"
		end

	frozen set_processor_affinity (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Diagnostics.ProcessThread"
		alias
			"set_ProcessorAffinity"
		end

feature -- Basic Operations

	frozen reset_ideal_processor is
		external
			"IL signature (): System.Void use System.Diagnostics.ProcessThread"
		alias
			"ResetIdealProcessor"
		end

end -- class PROCESSTHREAD
