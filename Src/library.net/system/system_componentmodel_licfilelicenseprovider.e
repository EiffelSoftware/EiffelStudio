indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LicFileLicenseProvider"

external class
	SYSTEM_COMPONENTMODEL_LICFILELICENSEPROVIDER

inherit
	SYSTEM_COMPONENTMODEL_LICENSEPROVIDER

create
	make_licfilelicenseprovider

feature {NONE} -- Initialization

	frozen make_licfilelicenseprovider is
		external
			"IL creator use System.ComponentModel.LicFileLicenseProvider"
		end

feature -- Basic Operations

	get_license (context: SYSTEM_COMPONENTMODEL_LICENSECONTEXT; type: SYSTEM_TYPE; instance: ANY; allow_exceptions: BOOLEAN): SYSTEM_COMPONENTMODEL_LICENSE is
		external
			"IL signature (System.ComponentModel.LicenseContext, System.Type, System.Object, System.Boolean): System.ComponentModel.License use System.ComponentModel.LicFileLicenseProvider"
		alias
			"GetLicense"
		end

feature {NONE} -- Implementation

	is_key_valid (key: STRING; type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.String, System.Type): System.Boolean use System.ComponentModel.LicFileLicenseProvider"
		alias
			"IsKeyValid"
		end

	get_key (type: SYSTEM_TYPE): STRING is
		external
			"IL signature (System.Type): System.String use System.ComponentModel.LicFileLicenseProvider"
		alias
			"GetKey"
		end

end -- class SYSTEM_COMPONENTMODEL_LICFILELICENSEPROVIDER
