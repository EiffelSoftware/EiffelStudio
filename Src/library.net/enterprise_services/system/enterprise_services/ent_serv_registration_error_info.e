indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.RegistrationErrorInfo"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_REGISTRATION_ERROR_INFO

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_error_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.RegistrationErrorInfo"
		alias
			"get_ErrorString"
		end

	frozen get_minor_ref: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.RegistrationErrorInfo"
		alias
			"get_MinorRef"
		end

	frozen get_major_ref: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.RegistrationErrorInfo"
		alias
			"get_MajorRef"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.RegistrationErrorInfo"
		alias
			"get_Name"
		end

	frozen get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.RegistrationErrorInfo"
		alias
			"get_ErrorCode"
		end

end -- class ENT_SERV_REGISTRATION_ERROR_INFO
