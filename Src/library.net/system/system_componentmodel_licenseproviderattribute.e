indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LicenseProviderAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_LICENSEPROVIDERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			is_equal
		end

create
	make_licenseproviderattribute_2,
	make_licenseproviderattribute,
	make_licenseproviderattribute_1

feature {NONE} -- Initialization

	frozen make_licenseproviderattribute_2 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.LicenseProviderAttribute"
		end

	frozen make_licenseproviderattribute is
		external
			"IL creator use System.ComponentModel.LicenseProviderAttribute"
		end

	frozen make_licenseproviderattribute_1 (type_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.LicenseProviderAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_LICENSEPROVIDERATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LicenseProviderAttribute use System.ComponentModel.LicenseProviderAttribute"
		alias
			"Default"
		end

	frozen get_license_provider: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.LicenseProviderAttribute"
		alias
			"get_LicenseProvider"
		end

	get_type_id: ANY is
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

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.LicenseProviderAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_LICENSEPROVIDERATTRIBUTE
