indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesigntimeLicenseContext"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNTIME_LICENSE_CONTEXT

inherit
	SYSTEM_DLL_LICENSE_CONTEXT
		redefine
			set_saved_license_key,
			get_saved_license_key,
			get_usage_mode
		end
	ISERVICE_PROVIDER

create
	make_system_dll_designtime_license_context

feature {NONE} -- Initialization

	frozen make_system_dll_designtime_license_context is
		external
			"IL creator use System.ComponentModel.Design.DesigntimeLicenseContext"
		end

feature -- Access

	get_usage_mode: SYSTEM_DLL_LICENSE_USAGE_MODE is
		external
			"IL signature (): System.ComponentModel.LicenseUsageMode use System.ComponentModel.Design.DesigntimeLicenseContext"
		alias
			"get_UsageMode"
		end

feature -- Basic Operations

	set_saved_license_key (type: TYPE; key: SYSTEM_STRING) is
		external
			"IL signature (System.Type, System.String): System.Void use System.ComponentModel.Design.DesigntimeLicenseContext"
		alias
			"SetSavedLicenseKey"
		end

	get_saved_license_key (type: TYPE; resource_assembly: ASSEMBLY): SYSTEM_STRING is
		external
			"IL signature (System.Type, System.Reflection.Assembly): System.String use System.ComponentModel.Design.DesigntimeLicenseContext"
		alias
			"GetSavedLicenseKey"
		end

end -- class SYSTEM_DLL_DESIGNTIME_LICENSE_CONTEXT
