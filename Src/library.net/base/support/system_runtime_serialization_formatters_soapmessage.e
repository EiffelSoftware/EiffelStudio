indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.Formatters.SoapMessage"

external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SOAPMESSAGE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_ISOAPMESSAGE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.SoapMessage"
		end

feature -- Access

	frozen get_headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER] is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.Header[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_Headers"
		end

	frozen get_xml_name_space: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_XmlNameSpace"
		end

	frozen get_method_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_MethodName"
		end

	frozen get_param_values: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_ParamValues"
		end

	frozen get_param_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_ParamNames"
		end

	frozen get_param_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"get_ParamTypes"
		end

feature -- Element Change

	frozen set_headers (value: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_Headers"
		end

	frozen set_param_names (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_ParamNames"
		end

	frozen set_method_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_MethodName"
		end

	frozen set_param_types (value: ARRAY [SYSTEM_TYPE]) is
		external
			"IL signature (System.Type[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_ParamTypes"
		end

	frozen set_param_values (value: ARRAY [ANY]) is
		external
			"IL signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"set_ParamValues"
		end

	frozen set_xml_name_space (value: STRING) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.SoapMessage"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SOAPMESSAGE
