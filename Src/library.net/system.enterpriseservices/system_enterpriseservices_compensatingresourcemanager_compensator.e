indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.Compensator"

external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOR

inherit
	SYSTEM_ENTERPRISESERVICES_IREMOTEDISPATCH
		rename
			remote_dispatch_not_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done,
			remote_dispatch_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENT

create
	make_compensator

feature {NONE} -- Initialization

	frozen make_compensator is
		external
			"IL creator use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		end

feature -- Access

	frozen get_clerk: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERK is
		external
			"IL signature (): System.EnterpriseServices.CompensatingResourceManager.Clerk use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"get_Clerk"
		end

feature -- Basic Operations

	end_prepare: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"EndPrepare"
		end

	begin_prepare is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"BeginPrepare"
		end

	abort_record (rec: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORD): BOOLEAN is
		external
			"IL signature (System.EnterpriseServices.CompensatingResourceManager.LogRecord): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"AbortRecord"
		end

	commit_record (rec: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORD): BOOLEAN is
		external
			"IL signature (System.EnterpriseServices.CompensatingResourceManager.LogRecord): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"CommitRecord"
		end

	prepare_record (rec: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_LOGRECORD): BOOLEAN is
		external
			"IL signature (System.EnterpriseServices.CompensatingResourceManager.LogRecord): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"PrepareRecord"
		end

	begin_commit (f_recovery: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"BeginCommit"
		end

	end_abort is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"EndAbort"
		end

	begin_abort (f_recovery: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"BeginAbort"
		end

	end_commit is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"EndCommit"
		end

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOR
