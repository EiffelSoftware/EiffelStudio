indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LicenseContext"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_LICENSE_CONTEXT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERVICE_PROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.LicenseContext"
		end

feature -- Access

	get_usage_mode: SYSTEM_DLL_LICENSE_USAGE_MODE is
		external
			"IL signature (): System.ComponentModel.LicenseUsageMode use System.ComponentModel.LicenseContext"
		alias
			"get_UsageMode"
		end

feature -- Basic Operations

	get_service (type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.LicenseContext"
		alias
			"GetService"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.LicenseContext"
		alias
			"GetHashCode"
		end

	get_saved_license_key (type: TYPE; resource_assembly: ASSEMBLY): SYSTEM_STRING is
		external
			"IL signature (System.Type, System.Reflection.Assembly): System.String use System.ComponentModel.LicenseContext"
		alias
			"GetSavedLicenseKey"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.LicenseContext"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.LicenseContext"
		alias
			"Equals"
		end

	set_saved_license_key (type: TYPE; key: SYSTEM_STRING) is
		external
			"IL signature (System.Type, System.String): System.Void use System.ComponentModel.LicenseContext"
		alias
			"SetSavedLicenseKey"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.LicenseContext"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_LICENSE_CONTEXT
