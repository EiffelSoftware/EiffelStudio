indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS

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

	frozen written_during_prepare: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"2"
		end

	frozen written_durring_recovery: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"16"
		end

	frozen written_during_abort: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"8"
		end

	frozen written_during_commit: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"4"
		end

	frozen written_during_replay: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"32"
		end

	frozen forget_target: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags use System.EnterpriseServices.CompensatingResourceManager.LogRecordFlags"
		alias
			"1"
		end

	frozen replay_in_progress: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS is
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

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORDFLAGS
