indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.ProcessInfo"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PROCESS_INFO

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (start_time: SYSTEM_DATE_TIME; age: TIME_SPAN; process_id: INTEGER; request_count: INTEGER; status: WEB_PROCESS_STATUS; shutdown_reason: WEB_PROCESS_SHUTDOWN_REASON; peak_memory_used: INTEGER) is
		external
			"IL creator signature (System.DateTime, System.TimeSpan, System.Int32, System.Int32, System.Web.ProcessStatus, System.Web.ProcessShutdownReason, System.Int32) use System.Web.ProcessInfo"
		end

	frozen make_1 is
		external
			"IL creator use System.Web.ProcessInfo"
		end

feature -- Access

	frozen get_age: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.Web.ProcessInfo"
		alias
			"get_Age"
		end

	frozen get_shutdown_reason: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL signature (): System.Web.ProcessShutdownReason use System.Web.ProcessInfo"
		alias
			"get_ShutdownReason"
		end

	frozen get_request_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.ProcessInfo"
		alias
			"get_RequestCount"
		end

	frozen get_status: WEB_PROCESS_STATUS is
		external
			"IL signature (): System.Web.ProcessStatus use System.Web.ProcessInfo"
		alias
			"get_Status"
		end

	frozen get_start_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.ProcessInfo"
		alias
			"get_StartTime"
		end

	frozen get_peak_memory_used: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.ProcessInfo"
		alias
			"get_PeakMemoryUsed"
		end

	frozen get_process_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.ProcessInfo"
		alias
			"get_ProcessID"
		end

feature -- Basic Operations

	frozen set_all (start_time: SYSTEM_DATE_TIME; age: TIME_SPAN; process_id: INTEGER; request_count: INTEGER; status: WEB_PROCESS_STATUS; shutdown_reason: WEB_PROCESS_SHUTDOWN_REASON; peak_memory_used: INTEGER) is
		external
			"IL signature (System.DateTime, System.TimeSpan, System.Int32, System.Int32, System.Web.ProcessStatus, System.Web.ProcessShutdownReason, System.Int32): System.Void use System.Web.ProcessInfo"
		alias
			"SetAll"
		end

end -- class WEB_PROCESS_INFO
