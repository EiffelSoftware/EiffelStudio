indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LicenseUsageMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen designtime: SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE is
		external
			"IL enum signature :System.ComponentModel.LicenseUsageMode use System.ComponentModel.LicenseUsageMode"
		alias
			"1"
		end

	frozen runtime: SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE is
		external
			"IL enum signature :System.ComponentModel.LicenseUsageMode use System.ComponentModel.LicenseUsageMode"
		alias
			"0"
		end

end -- class SYSTEM_COMPONENTMODEL_LICENSEUSAGEMODE
