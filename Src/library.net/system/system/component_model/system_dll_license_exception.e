indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LicenseException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_LICENSE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_system_dll_license_exception_3,
	make_system_dll_license_exception_1,
	make_system_dll_license_exception,
	make_system_dll_license_exception_2

feature {NONE} -- Initialization

	frozen make_system_dll_license_exception_3 (type: TYPE; instance: SYSTEM_OBJECT; message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.Type, System.Object, System.String, System.Exception) use System.ComponentModel.LicenseException"
		end

	frozen make_system_dll_license_exception_1 (type: TYPE; instance: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Type, System.Object) use System.ComponentModel.LicenseException"
		end

	frozen make_system_dll_license_exception (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.LicenseException"
		end

	frozen make_system_dll_license_exception_2 (type: TYPE; instance: SYSTEM_OBJECT; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.Object, System.String) use System.ComponentModel.LicenseException"
		end

feature -- Access

	frozen get_licensed_type: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.LicenseException"
		alias
			"get_LicensedType"
		end

end -- class SYSTEM_DLL_LICENSE_EXCEPTION
