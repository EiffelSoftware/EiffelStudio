indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SecurityRoleAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SECURITY_ROLE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_security_role_attribute_1,
	make_ent_serv_security_role_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_security_role_attribute_1 (role: SYSTEM_STRING; everyone: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.EnterpriseServices.SecurityRoleAttribute"
		end

	frozen make_ent_serv_security_role_attribute (role: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.SecurityRoleAttribute"
		end

feature -- Access

	frozen get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"get_Description"
		end

	frozen get_set_everyone_access: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"get_SetEveryoneAccess"
		end

	frozen get_role: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"get_Role"
		end

feature -- Element Change

	frozen set_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"set_Description"
		end

	frozen set_set_everyone_access (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"set_SetEveryoneAccess"
		end

	frozen set_role (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"set_Role"
		end

end -- class ENT_SERV_SECURITY_ROLE_ATTRIBUTE
