indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.ProcessInfo"

external class
	SYSTEM_WEB_PROCESSINFO

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (start_time: SYSTEM_DATETIME; age: SYSTEM_TIMESPAN; process_id: INTEGER; request_count: INTEGER; status: SYSTEM_WEB_PROCESSSTATUS; shutdown_reason: SYSTEM_WEB_PROCESSSHUTDOWNREASON; peak_memory_used: INTEGER) is
		external
			"IL creator signature (System.DateTime, System.TimeSpan, System.Int32, System.Int32, System.Web.ProcessStatus, System.Web.ProcessShutdownReason, System.Int32) use System.Web.ProcessInfo"
		end

	frozen make_1 is
		external
			"IL creator use System.Web.ProcessInfo"
		end

feature -- Access

	frozen get_age: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.Web.ProcessInfo"
		alias
			"get_Age"
		end

	frozen get_shutdown_reason: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
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

	frozen get_status: SYSTEM_WEB_PROCESSSTATUS is
		external
			"IL signature (): System.Web.ProcessStatus use System.Web.ProcessInfo"
		alias
			"get_Status"
		end

	frozen get_start_time: SYSTEM_DATETIME is
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

	frozen set_all (start_time: SYSTEM_DATETIME; age: SYSTEM_TIMESPAN; process_id: INTEGER; request_count: INTEGER; status: SYSTEM_WEB_PROCESSSTATUS; shutdown_reason: SYSTEM_WEB_PROCESSSHUTDOWNREASON; peak_memory_used: INTEGER) is
		external
			"IL signature (System.DateTime, System.TimeSpan, System.Int32, System.Int32, System.Web.ProcessStatus, System.Web.ProcessShutdownReason, System.Int32): System.Void use System.Web.ProcessInfo"
		alias
			"SetAll"
		end

end -- class SYSTEM_WEB_PROCESSINFO
