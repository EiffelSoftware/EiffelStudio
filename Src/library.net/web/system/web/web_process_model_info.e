indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.ProcessModelInfo"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PROCESS_MODEL_INFO

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.ProcessModelInfo"
		end

feature -- Basic Operations

	frozen get_history (num_records: INTEGER): NATIVE_ARRAY [WEB_PROCESS_INFO] is
		external
			"IL static signature (System.Int32): System.Web.ProcessInfo[] use System.Web.ProcessModelInfo"
		alias
			"GetHistory"
		end

	frozen get_current_process_info: WEB_PROCESS_INFO is
		external
			"IL static signature (): System.Web.ProcessInfo use System.Web.ProcessModelInfo"
		alias
			"GetCurrentProcessInfo"
		end

end -- class WEB_PROCESS_MODEL_INFO
