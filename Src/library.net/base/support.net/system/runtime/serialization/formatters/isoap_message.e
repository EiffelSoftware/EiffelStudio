indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.ISoapMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISOAP_MESSAGE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_headers: NATIVE_ARRAY [HEADER] is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.Header[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_Headers"
		end

	get_xml_name_space: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_XmlNameSpace"
		end

	get_method_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_MethodName"
		end

	get_param_values: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_ParamValues"
		end

	get_param_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_ParamNames"
		end

	get_param_types: NATIVE_ARRAY [TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_ParamTypes"
		end

feature -- Element Change

	set_headers (value: NATIVE_ARRAY [HEADER]) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_Headers"
		end

	set_param_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL deferred signature (System.String[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_ParamNames"
		end

	set_method_name (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_MethodName"
		end

	set_param_types (value: NATIVE_ARRAY [TYPE]) is
		external
			"IL deferred signature (System.Type[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_ParamTypes"
		end

	set_param_values (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL deferred signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_ParamValues"
		end

	set_xml_name_space (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_XmlNameSpace"
		end

end -- class ISOAP_MESSAGE
