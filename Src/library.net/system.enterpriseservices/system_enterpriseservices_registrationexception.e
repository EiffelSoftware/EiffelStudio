indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.RegistrationException"

frozen external class
	SYSTEM_ENTERPRISESERVICES_REGISTRATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_registrationexception

feature {NONE} -- Initialization

	frozen make_registrationexception (msg: STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.RegistrationException"
		end

feature -- Access

	frozen get_error_info: ARRAY [SYSTEM_ENTERPRISESERVICES_REGISTRATIONERRORINFO] is
		external
			"IL signature (): System.EnterpriseServices.RegistrationErrorInfo[] use System.EnterpriseServices.RegistrationException"
		alias
			"get_ErrorInfo"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; ctx: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.EnterpriseServices.RegistrationException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_ENTERPRISESERVICES_REGISTRATIONEXCEPTION
