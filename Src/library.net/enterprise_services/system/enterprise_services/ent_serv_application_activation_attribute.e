indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ApplicationActivationAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_APPLICATION_ACTIVATION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_application_activation_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_application_activation_attribute (opt: ENT_SERV_ACTIVATION_OPTION) is
		external
			"IL creator signature (System.EnterpriseServices.ActivationOption) use System.EnterpriseServices.ApplicationActivationAttribute"
		end

feature -- Access

	frozen get_soap_mailbox: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"get_SoapMailbox"
		end

	frozen get_soap_vroot: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"get_SoapVRoot"
		end

	frozen get_value: ENT_SERV_ACTIVATION_OPTION is
		external
			"IL signature (): System.EnterpriseServices.ActivationOption use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_soap_mailbox (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"set_SoapMailbox"
		end

	frozen set_soap_vroot (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"set_SoapVRoot"
		end

end -- class ENT_SERV_APPLICATION_ACTIVATION_ATTRIBUTE
