indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.Formatters.ISoapMessage"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_ISOAPMESSAGE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER] is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.Header[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_Headers"
		end

	get_xml_name_space: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_XmlNameSpace"
		end

	get_method_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_MethodName"
		end

	get_param_values: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_ParamValues"
		end

	get_param_names: ARRAY [STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_ParamNames"
		end

	get_param_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"get_ParamTypes"
		end

feature -- Element Change

	set_headers (value: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_Headers"
		end

	set_param_names (value: ARRAY [STRING]) is
		external
			"IL deferred signature (System.String[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_ParamNames"
		end

	set_method_name (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_MethodName"
		end

	set_param_types (value: ARRAY [SYSTEM_TYPE]) is
		external
			"IL deferred signature (System.Type[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_ParamTypes"
		end

	set_param_values (value: ARRAY [ANY]) is
		external
			"IL deferred signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_ParamValues"
		end

	set_xml_name_space (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ISoapMessage"
		alias
			"set_XmlNameSpace"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_ISOAPMESSAGE
