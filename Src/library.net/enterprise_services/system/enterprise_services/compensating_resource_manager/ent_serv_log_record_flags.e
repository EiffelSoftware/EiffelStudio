indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	ENT_SERV_LOG_RECORD_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen written_during_prepare: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"2"
		end

	frozen written_durring_recovery: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"16"
		end

	frozen written_during_abort: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"8"
		end

	frozen written_during_commit: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"4"
		end

	frozen written_during_replay: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"32"
		end

	frozen forget_target: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"1"
		end

	frozen replay_in_progress: ENT_SERV_LOG_RECORD_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"64"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class ENT_SERV_LOG_RECORD_FLAGS
