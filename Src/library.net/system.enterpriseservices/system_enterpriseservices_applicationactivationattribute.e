indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ApplicationActivationAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_APPLICATIONACTIVATIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_applicationactivationattribute

feature {NONE} -- Initialization

	frozen make_applicationactivationattribute (opt: SYSTEM_ENTERPRISESERVICES_ACTIVATIONOPTION) is
		external
			"IL creator signature (System.EnterpriseServices.ActivationOption) use System.EnterpriseServices.ApplicationActivationAttribute"
		end

feature -- Access

	frozen get_soap_mailbox: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"get_SoapMailbox"
		end

	frozen get_soap_vroot: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"get_SoapVRoot"
		end

	frozen get_value: SYSTEM_ENTERPRISESERVICES_ACTIVATIONOPTION is
		external
			"IL signature (): System.EnterpriseServices.ActivationOption use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_soap_mailbox (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"set_SoapMailbox"
		end

	frozen set_soap_vroot (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ApplicationActivationAttribute"
		alias
			"set_SoapVRoot"
		end

end -- class SYSTEM_ENTERPRISESERVICES_APPLICATIONACTIVATIONATTRIBUTE
