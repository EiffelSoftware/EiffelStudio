indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LicenseContext"

external class
	SYSTEM_COMPONENTMODEL_LICENSECONTEXT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ISERVICEPROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.LicenseContext"
		end

feature -- Access

	get_usage_mode: SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE is
		external
			"IL signature (): System.ComponentModel.LicenseUsageMode use System.ComponentModel.LicenseContext"
		alias
			"get_UsageMode"
		end

feature -- Basic Operations

	get_service (type: SYSTEM_TYPE): ANY is
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

	get_saved_license_key (type: SYSTEM_TYPE; resource_assembly: SYSTEM_REFLECTION_ASSEMBLY): STRING is
		external
			"IL signature (System.Type, System.Reflection.Assembly): System.String use System.ComponentModel.LicenseContext"
		alias
			"GetSavedLicenseKey"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.LicenseContext"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.LicenseContext"
		alias
			"Equals"
		end

	set_saved_license_key (type: SYSTEM_TYPE; key: STRING) is
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

end -- class SYSTEM_COMPONENTMODEL_LICENSECONTEXT
