indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"

frozen external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERKINFO

inherit
	ANY
		redefine
			finalize
		end

create {NONE}

feature -- Access

	frozen get_description: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_Description"
		end

	frozen get_clerk: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERK is
		external
			"IL signature (): System.EnterpriseServices.CompensatingResourceManager.Clerk use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_Clerk"
		end

	frozen get_compensator: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_Compensator"
		end

	frozen get_activity_id: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_ActivityId"
		end

	frozen get_instance_id: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkInfo"
		alias
			"get_InstanceId"
		end

	frozen get_transaction_uow: STRING is
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

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERKINFO
