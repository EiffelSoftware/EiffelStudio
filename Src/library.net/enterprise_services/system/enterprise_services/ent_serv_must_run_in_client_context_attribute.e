indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.MustRunInClientContextAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_MUST_RUN_IN_CLIENT_CONTEXT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_must_run_in_client_context_attribute,
	make_ent_serv_must_run_in_client_context_attribute_1

feature {NONE} -- Initialization

	frozen make_ent_serv_must_run_in_client_context_attribute is
		external
			"IL creator use System.EnterpriseServices.MustRunInClientContextAttribute"
		end

	frozen make_ent_serv_must_run_in_client_context_attribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.MustRunInClientContextAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.MustRunInClientContextAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_MUST_RUN_IN_CLIENT_CONTEXT_ATTRIBUTE
