indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.Formatters.SoapFault"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SOAPFAULT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.SoapFault"
		end

	frozen make_1 (fault_code: STRING; fault_string: STRING; fault_actor: STRING; server_fault: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SERVERFAULT) is
		external
			"IL creator signature (System.String, System.String, System.String, System.Runtime.Serialization.Formatters.ServerFault) use System.Runtime.Serialization.Formatters.SoapFault"
		end

feature -- Access

	frozen get_fault_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_FaultString"
		end

	frozen get_fault_code: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_FaultCode"
		end

	frozen get_detail: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_Detail"
		end

	frozen get_fault_actor: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"get_FaultActor"
		end

feature -- Element Change

	frozen set_fault_code (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_FaultCode"
		end

	frozen set_fault_actor (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_FaultActor"
		end

	frozen set_fault_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"set_FaultString"
		end

	frozen set_detail (value: ANY) is
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

	frozen get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"GetObjectData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapFault"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SOAPFAULT
