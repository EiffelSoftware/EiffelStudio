indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.SoapFault"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_FAULT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.SoapFault"
		end

	frozen make_1 (fault_code: SYSTEM_STRING; fault_string: SYSTEM_STRING; fault_actor: SYSTEM_STRING; server_fault: SERVER_FAULT) is
		external
			"IL creator signature (System.String, System.String, System.String, System.Runtime.Serialization.Formatters.ServerFault) use System.Runtime.Serialization.Formatters.SoapFault"
		end

feature -- Access

	frozen get_fault_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_FaultString"
		end

	frozen get_fault_code: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_FaultCode"
		end

	frozen get_detail: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_Detail"
		end

	frozen get_fault_actor: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_FaultActor"
		end

feature -- Element Change

	frozen set_fault_code (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_FaultCode"
		end

	frozen set_fault_actor (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_FaultActor"
		end

	frozen set_fault_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_FaultString"
		end

	frozen set_detail (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_Detail"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"GetHashCode"
		end

	frozen get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"Finalize"
		end

end -- class SOAP_FAULT
