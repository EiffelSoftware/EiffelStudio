indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LicenseProvider"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_LICENSE_PROVIDER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	get_license (context: SYSTEM_DLL_LICENSE_CONTEXT; type: TYPE; instance: SYSTEM_OBJECT; allow_exceptions: BOOLEAN): SYSTEM_DLL_LICENSE is
		external
			"IL deferred signature (System.ComponentModel.LicenseContext, System.Type, System.Object, System.Boolean): System.ComponentModel.License use System.ComponentModel.LicenseProvider"
		alias
			"GetLicense"
		end

end -- class SYSTEM_DLL_LICENSE_PROVIDER
