indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.Clerk"

frozen external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERK

inherit
	ANY
		redefine
			finalize
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (compensator: SYSTEM_TYPE; description: STRING; flags: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS) is
		external
			"IL creator signature (System.Type, System.String, System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions) use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		end

	frozen make_1 (compensator: STRING; description: STRING; flags: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS) is
		external
			"IL creator signature (System.String, System.String, System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions) use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		end

feature -- Access

	frozen get_log_record_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"get_LogRecordCount"
		end

	frozen get_transaction_uow: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"get_TransactionUOW"
		end

feature -- Basic Operations

	frozen force_log is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"ForceLog"
		end

	frozen write_log_record (record: ANY) is
		external
			"IL signature (System.Object): System.Void use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"WriteLogRecord"
		end

	frozen forget_log_record is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"ForgetLogRecord"
		end

	frozen force_transaction_to_abort is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"ForceTransactionToAbort"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Clerk"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERK
