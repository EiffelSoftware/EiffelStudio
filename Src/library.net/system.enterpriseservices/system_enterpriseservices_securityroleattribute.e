indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SecurityRoleAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SECURITYROLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_securityroleattribute,
	make_securityroleattribute_1

feature {NONE} -- Initialization

	frozen make_securityroleattribute (role: STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.SecurityRoleAttribute"
		end

	frozen make_securityroleattribute_1 (role: STRING; everyone: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.EnterpriseServices.SecurityRoleAttribute"
		end

feature -- Access

	frozen get_description: STRING is
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

	frozen get_role: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"get_Role"
		end

feature -- Element Change

	frozen set_description (value: STRING) is
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

	frozen set_role (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.SecurityRoleAttribute"
		alias
			"set_Role"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SECURITYROLEATTRIBUTE
