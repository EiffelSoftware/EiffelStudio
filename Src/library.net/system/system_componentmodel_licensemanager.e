indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LicenseManager"

frozen external class
	SYSTEM_COMPONENTMODEL_LICENSEMANAGER

create {NONE}

feature -- Access

	frozen get_current_context: SYSTEM_COMPONENTMODEL_LICENSECONTEXT is
		external
			"IL static signature (): System.ComponentModel.LicenseContext use System.ComponentModel.LicenseManager"
		alias
			"get_CurrentContext"
		end

	frozen get_usage_mode: SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE is
		external
			"IL static signature (): System.ComponentModel.LicenseUsageMode use System.ComponentModel.LicenseManager"
		alias
			"get_UsageMode"
		end

feature -- Element Change

	frozen set_current_context (value: SYSTEM_COMPONENTMODEL_LICENSECONTEXT) is
		external
			"IL static signature (System.ComponentModel.LicenseContext): System.Void use System.ComponentModel.LicenseManager"
		alias
			"set_CurrentContext"
		end

feature -- Basic Operations

	frozen create_with_context (type: SYSTEM_TYPE; creation_context: SYSTEM_COMPONENTMODEL_LICENSECONTEXT): ANY is
		external
			"IL static signature (System.Type, System.ComponentModel.LicenseContext): System.Object use System.ComponentModel.LicenseManager"
		alias
			"CreateWithContext"
		end

	frozen is_valid (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.ComponentModel.LicenseManager"
		alias
			"IsValid"
		end

	frozen create_with_context_type_license_context_array_object (type: SYSTEM_TYPE; creation_context: SYSTEM_COMPONENTMODEL_LICENSECONTEXT; args: ARRAY [ANY]): ANY is
		external
			"IL static signature (System.Type, System.ComponentModel.LicenseContext, System.Object[]): System.Object use System.ComponentModel.LicenseManager"
		alias
			"CreateWithContext"
		end

	frozen lock_context (context_user: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.ComponentModel.LicenseManager"
		alias
			"LockContext"
		end

	frozen validate (type: SYSTEM_TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.ComponentModel.LicenseManager"
		alias
			"Validate"
		end

	frozen validate_type_object (type: SYSTEM_TYPE; instance: ANY): SYSTEM_COMPONENTMODEL_LICENSE is
		external
			"IL static signature (System.Type, System.Object): System.ComponentModel.License use System.ComponentModel.LicenseManager"
		alias
			"Validate"
		end

	frozen unlock_context (context_user: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.ComponentModel.LicenseManager"
		alias
			"UnlockContext"
		end

	frozen is_licensed (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.ComponentModel.LicenseManager"
		alias
			"IsLicensed"
		end

	frozen is_valid_type_object (type: SYSTEM_TYPE; instance: ANY; license: SYSTEM_COMPONENTMODEL_LICENSE): BOOLEAN is
		external
			"IL static signature (System.Type, System.Object, System.ComponentModel.License&): System.Boolean use System.ComponentModel.LicenseManager"
		alias
			"IsValid"
		end

end -- class SYSTEM_COMPONENTMODEL_LICENSEMANAGER
