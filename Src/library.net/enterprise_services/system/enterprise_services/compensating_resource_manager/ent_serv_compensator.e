indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.Compensator"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_COMPENSATOR

inherit
	ENT_SERV_SERVICED_COMPONENT
	ENT_SERV_IREMOTE_DISPATCH
		rename
			remote_dispatch_not_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done,
			remote_dispatch_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done
		end
	IDISPOSABLE
	ENT_SERV_ISERVICED_COMPONENT_INFO
		rename
			get_component_info as system_enterprise_services_iserviced_component_info_get_component_info
		end

create
	make_ent_serv_compensator

feature {NONE} -- Initialization

	frozen make_ent_serv_compensator is
		external
			"IL creator use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		end

feature -- Access

	frozen get_clerk: ENT_SERV_CLERK is
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

	abort_record (rec: ENT_SERV_LOG_RECORD): BOOLEAN is
		external
			"IL signature (System.EnterpriseServices.CompensatingResourceManager.LogRecord): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"AbortRecord"
		end

	commit_record (rec: ENT_SERV_LOG_RECORD): BOOLEAN is
		external
			"IL signature (System.EnterpriseServices.CompensatingResourceManager.LogRecord): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.Compensator"
		alias
			"CommitRecord"
		end

	prepare_record (rec: ENT_SERV_LOG_RECORD): BOOLEAN is
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

end -- class ENT_SERV_COMPENSATOR
