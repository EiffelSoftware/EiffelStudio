indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LicFileLicenseProvider"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_LIC_FILE_LICENSE_PROVIDER

inherit
	SYSTEM_DLL_LICENSE_PROVIDER

create
	make_system_dll_lic_file_license_provider

feature {NONE} -- Initialization

	frozen make_system_dll_lic_file_license_provider is
		external
			"IL creator use System.ComponentModel.LicFileLicenseProvider"
		end

feature -- Basic Operations

	get_license (context: SYSTEM_DLL_LICENSE_CONTEXT; type: TYPE; instance: SYSTEM_OBJECT; allow_exceptions: BOOLEAN): SYSTEM_DLL_LICENSE is
		external
			"IL signature (System.ComponentModel.LicenseContext, System.Type, System.Object, System.Boolean): System.ComponentModel.License use System.ComponentModel.LicFileLicenseProvider"
		alias
			"GetLicense"
		end

feature {NONE} -- Implementation

	is_key_valid (key: SYSTEM_STRING; type: TYPE): BOOLEAN is
		external
			"IL signature (System.String, System.Type): System.Boolean use System.ComponentModel.LicFileLicenseProvider"
		alias
			"IsKeyValid"
		end

	get_key (type: TYPE): SYSTEM_STRING is
		external
			"IL signature (System.Type): System.String use System.ComponentModel.LicFileLicenseProvider"
		alias
			"GetKey"
		end

end -- class SYSTEM_DLL_LIC_FILE_LICENSE_PROVIDER
