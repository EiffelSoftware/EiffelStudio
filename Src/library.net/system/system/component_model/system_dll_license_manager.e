indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LicenseManager"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_LICENSE_MANAGER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_current_context: SYSTEM_DLL_LICENSE_CONTEXT is
		external
			"IL static signature (): System.ComponentModel.LicenseContext use System.ComponentModel.LicenseManager"
		alias
			"get_CurrentContext"
		end

	frozen get_usage_mode: SYSTEM_DLL_LICENSE_USAGE_MODE is
		external
			"IL static signature (): System.ComponentModel.LicenseUsageMode use System.ComponentModel.LicenseManager"
		alias
			"get_UsageMode"
		end

feature -- Element Change

	frozen set_current_context (value: SYSTEM_DLL_LICENSE_CONTEXT) is
		external
			"IL static signature (System.ComponentModel.LicenseContext): System.Void use System.ComponentModel.LicenseManager"
		alias
			"set_CurrentContext"
		end

feature -- Basic Operations

	frozen create_with_context (type: TYPE; creation_context: SYSTEM_DLL_LICENSE_CONTEXT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.ComponentModel.LicenseContext): System.Object use System.ComponentModel.LicenseManager"
		alias
			"CreateWithContext"
		end

	frozen is_valid (type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.ComponentModel.LicenseManager"
		alias
			"IsValid"
		end

	frozen create_with_context_type_license_context_array_object (type: TYPE; creation_context: SYSTEM_DLL_LICENSE_CONTEXT; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.ComponentModel.LicenseContext, System.Object[]): System.Object use System.ComponentModel.LicenseManager"
		alias
			"CreateWithContext"
		end

	frozen lock_context (context_user: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.ComponentModel.LicenseManager"
		alias
			"LockContext"
		end

	frozen validate (type: TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.ComponentModel.LicenseManager"
		alias
			"Validate"
		end

	frozen validate_type_object (type: TYPE; instance: SYSTEM_OBJECT): SYSTEM_DLL_LICENSE is
		external
			"IL static signature (System.Type, System.Object): System.ComponentModel.License use System.ComponentModel.LicenseManager"
		alias
			"Validate"
		end

	frozen unlock_context (context_user: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.ComponentModel.LicenseManager"
		alias
			"UnlockContext"
		end

	frozen is_licensed (type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.ComponentModel.LicenseManager"
		alias
			"IsLicensed"
		end

	frozen is_valid_type_object (type: TYPE; instance: SYSTEM_OBJECT; license: SYSTEM_DLL_LICENSE): BOOLEAN is
		external
			"IL static signature (System.Type, System.Object, System.ComponentModel.License&): System.Boolean use System.ComponentModel.LicenseManager"
		alias
			"IsValid"
		end

end -- class SYSTEM_DLL_LICENSE_MANAGER
