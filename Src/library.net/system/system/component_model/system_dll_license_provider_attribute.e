indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LicenseProviderAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_LICENSE_PROVIDER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			equals
		end

create
	make_system_dll_license_provider_attribute_1,
	make_system_dll_license_provider_attribute,
	make_system_dll_license_provider_attribute_2

feature {NONE} -- Initialization

	frozen make_system_dll_license_provider_attribute_1 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.LicenseProviderAttribute"
		end

	frozen make_system_dll_license_provider_attribute is
		external
			"IL creator use System.ComponentModel.LicenseProviderAttribute"
		end

	frozen make_system_dll_license_provider_attribute_2 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.LicenseProviderAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_LICENSE_PROVIDER_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LicenseProviderAttribute use System.ComponentModel.LicenseProviderAttribute"
		alias
			"Default"
		end

	frozen get_license_provider: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.LicenseProviderAttribute"
		alias
			"get_LicenseProvider"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.LicenseProviderAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.LicenseProviderAttribute"
		alias
			"GetHashCode"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.LicenseProviderAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_LICENSE_PROVIDER_ATTRIBUTE
