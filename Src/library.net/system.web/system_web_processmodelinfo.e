indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.ProcessModelInfo"

external class
	SYSTEM_WEB_PROCESSMODELINFO

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.ProcessModelInfo"
		end

feature -- Basic Operations

	frozen get_history (num_records: INTEGER): ARRAY [SYSTEM_WEB_PROCESSINFO] is
		external
			"IL static signature (System.Int32): System.Web.ProcessInfo[] use System.Web.ProcessModelInfo"
		alias
			"GetHistory"
		end

	frozen get_current_process_info: SYSTEM_WEB_PROCESSINFO is
		external
			"IL static signature (): System.Web.ProcessInfo use System.Web.ProcessModelInfo"
		alias
			"GetCurrentProcessInfo"
		end

end -- class SYSTEM_WEB_PROCESSMODELINFO
