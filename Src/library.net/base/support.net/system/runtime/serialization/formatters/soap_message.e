indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.SoapMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SOAP_MESSAGE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISOAP_MESSAGE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.SoapMessage"
		end

feature -- Access

	frozen get_headers: NATIVE_ARRAY [HEADER] is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.Header[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_Headers"
		end

	frozen get_xml_name_space: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_XmlNameSpace"
		end

	frozen get_method_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_MethodName"
		end

	frozen get_param_values: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_ParamValues"
		end

	frozen get_param_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_ParamNames"
		end

	frozen get_param_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_ParamTypes"
		end

feature -- Element Change

	frozen set_headers (value: NATIVE_ARRAY [HEADER]) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_Headers"
		end

	frozen set_param_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_ParamNames"
		end

	frozen set_method_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_MethodName"
		end

	frozen set_param_types (value: NATIVE_ARRAY [TYPE]) is
		external
			"IL signature (System.Type[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_ParamTypes"
		end

	frozen set_param_values (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_ParamValues"
		end

	frozen set_xml_name_space (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_XmlNameSpace"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"Finalize"
		end

end -- class SOAP_MESSAGE
