indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesigntimeLicenseContext"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNTIMELICENSECONTEXT

inherit
	SYSTEM_COMPONENTMODEL_LICENSECONTEXT
		redefine
			set_saved_license_key,
			get_saved_license_key,
			get_usage_mode
		end
	SYSTEM_ISERVICEPROVIDER

create
	make_designtimelicensecontext

feature {NONE} -- Initialization

	frozen make_designtimelicensecontext is
		external
			"IL creator use System.ComponentModel.Design.DesigntimeLicenseContext"
		end

feature -- Access

	get_usage_mode: SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE is
		external
			"IL signature (): System.ComponentModel.LicenseUsageMode use System.ComponentModel.Design.DesigntimeLicenseContext"
		alias
			"get_UsageMode"
		end

feature -- Basic Operations

	set_saved_license_key (type: SYSTEM_TYPE; key: STRING) is
		external
			"IL signature (System.Type, System.String): System.Void use System.ComponentModel.Design.DesigntimeLicenseContext"
		alias
			"SetSavedLicenseKey"
		end

	get_saved_license_key (type: SYSTEM_TYPE; resource_assembly: SYSTEM_REFLECTION_ASSEMBLY): STRING is
		external
			"IL signature (System.Type, System.Reflection.Assembly): System.String use System.ComponentModel.Design.DesigntimeLicenseContext"
		alias
			"GetSavedLicenseKey"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNTIMELICENSECONTEXT
