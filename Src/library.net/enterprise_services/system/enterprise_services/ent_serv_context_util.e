indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ContextUtil"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_CONTEXT_UTIL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_deactivate_on_return: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.EnterpriseServices.ContextUtil"
		alias
			"get_DeactivateOnReturn"
		end

	frozen get_is_security_enabled: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.EnterpriseServices.ContextUtil"
		alias
			"get_IsSecurityEnabled"
		end

	frozen get_my_transaction_vote: ENT_SERV_TRANSACTION_VOTE is
		external
			"IL static signature (): System.EnterpriseServices.TransactionVote use System.EnterpriseServices.ContextUtil"
		alias
			"get_MyTransactionVote"
		end

	frozen get_application_instance_id: GUID is
		external
			"IL static signature (): System.Guid use System.EnterpriseServices.ContextUtil"
		alias
			"get_ApplicationInstanceId"
		end

	frozen get_activity_id: GUID is
		external
			"IL static signature (): System.Guid use System.EnterpriseServices.ContextUtil"
		alias
			"get_ActivityId"
		end

	frozen get_partition_id: GUID is
		external
			"IL static signature (): System.Guid use System.EnterpriseServices.ContextUtil"
		alias
			"get_PartitionId"
		end

	frozen get_is_in_transaction: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.EnterpriseServices.ContextUtil"
		alias
			"get_IsInTransaction"
		end

	frozen get_transaction: SYSTEM_OBJECT is
		external
			"IL static signature (): System.Object use System.EnterpriseServices.ContextUtil"
		alias
			"get_Transaction"
		end

	frozen get_transaction_id: GUID is
		external
			"IL static signature (): System.Guid use System.EnterpriseServices.ContextUtil"
		alias
			"get_TransactionId"
		end

	frozen get_context_id: GUID is
		external
			"IL static signature (): System.Guid use System.EnterpriseServices.ContextUtil"
		alias
			"get_ContextId"
		end

	frozen get_application_id: GUID is
		external
			"IL static signature (): System.Guid use System.EnterpriseServices.ContextUtil"
		alias
			"get_ApplicationId"
		end

feature -- Element Change

	frozen set_my_transaction_vote (value: ENT_SERV_TRANSACTION_VOTE) is
		external
			"IL static signature (System.EnterpriseServices.TransactionVote): System.Void use System.EnterpriseServices.ContextUtil"
		alias
			"set_MyTransactionVote"
		end

	frozen set_deactivate_on_return (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.EnterpriseServices.ContextUtil"
		alias
			"set_DeactivateOnReturn"
		end

feature -- Basic Operations

	frozen enable_commit is
		external
			"IL static signature (): System.Void use System.EnterpriseServices.ContextUtil"
		alias
			"EnableCommit"
		end

	frozen disable_commit is
		external
			"IL static signature (): System.Void use System.EnterpriseServices.ContextUtil"
		alias
			"DisableCommit"
		end

	frozen set_abort is
		external
			"IL static signature (): System.Void use System.EnterpriseServices.ContextUtil"
		alias
			"SetAbort"
		end

	frozen get_named_property (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.EnterpriseServices.ContextUtil"
		alias
			"GetNamedProperty"
		end

	frozen set_complete is
		external
			"IL static signature (): System.Void use System.EnterpriseServices.ContextUtil"
		alias
			"SetComplete"
		end

	frozen is_caller_in_role (role: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.EnterpriseServices.ContextUtil"
		alias
			"IsCallerInRole"
		end

end -- class ENT_SERV_CONTEXT_UTIL
