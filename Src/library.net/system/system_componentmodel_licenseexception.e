indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LicenseException"

external class
	SYSTEM_COMPONENTMODEL_LICENSEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_licenseexception,
	make_licenseexception_3,
	make_licenseexception_1,
	make_licenseexception_2

feature {NONE} -- Initialization

	frozen make_licenseexception (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.LicenseException"
		end

	frozen make_licenseexception_3 (type: SYSTEM_TYPE; instance: ANY; message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Type, System.Object, System.String, System.Exception) use System.ComponentModel.LicenseException"
		end

	frozen make_licenseexception_1 (type: SYSTEM_TYPE; instance: ANY) is
		external
			"IL creator signature (System.Type, System.Object) use System.ComponentModel.LicenseException"
		end

	frozen make_licenseexception_2 (type: SYSTEM_TYPE; instance: ANY; message: STRING) is
		external
			"IL creator signature (System.Type, System.Object, System.String) use System.ComponentModel.LicenseException"
		end

feature -- Access

	frozen get_licensed_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.LicenseException"
		alias
			"get_LicensedType"
		end

end -- class SYSTEM_COMPONENTMODEL_LICENSEEXCEPTION
