indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.RegistrationException"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_REGISTRATION_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_ent_serv_registration_exception

feature {NONE} -- Initialization

	frozen make_ent_serv_registration_exception (msg: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.RegistrationException"
		end

feature -- Access

	frozen get_error_info: NATIVE_ARRAY [ENT_SERV_REGISTRATION_ERROR_INFO] is
		external
			"IL signature (): System.EnterpriseServices.RegistrationErrorInfo[] use System.EnterpriseServices.RegistrationException"
		alias
			"get_ErrorInfo"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; ctx: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.EnterpriseServices.RegistrationException"
		alias
			"GetObjectData"
		end

end -- class ENT_SERV_REGISTRATION_EXCEPTION
