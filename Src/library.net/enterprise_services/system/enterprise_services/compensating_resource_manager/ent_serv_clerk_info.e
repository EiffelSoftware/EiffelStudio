indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_CLERK_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create {NONE}

feature -- Access

	frozen get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_Description"
		end

	frozen get_clerk: ENT_SERV_CLERK is
		external
			"IL signature (): System.EnterpriseServices.CompensatingResourceManager.Clerk use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_Clerk"
		end

	frozen get_compensator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_Compensator"
		end

	frozen get_activity_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_ActivityId"
		end

	frozen get_instance_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_InstanceId"
		end

	frozen get_transaction_uow: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_TransactionUOW"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"Finalize"
		end

end -- class ENT_SERV_CLERK_INFO
