indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.LogRecord"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_LOG_RECORD

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_flags: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL signature (): System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecord"
		alias
			"get_Flags"
		end

	frozen get_record: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.EnterpriseServices.CompensatingResourceManager.LogRecord"
		alias
			"get_Record"
		end

	frozen get_sequence: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.CompensatingResourceManager.LogRecord"
		alias
			"get_Sequence"
		end

end -- class ENT_SERV_LOG_RECORD
