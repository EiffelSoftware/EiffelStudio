indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.IRemotingTypeInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IREMOTING_TYPE_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_type_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.IRemotingTypeInfo"
		alias
			"get_TypeName"
		end

feature -- Element Change

	set_type_name (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Remoting.IRemotingTypeInfo"
		alias
			"set_TypeName"
		end

feature -- Basic Operations

	can_cast_to (from_type: TYPE; o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Type, System.Object): System.Boolean use System.Runtime.Remoting.IRemotingTypeInfo"
		alias
			"CanCastTo"
		end

end -- class IREMOTING_TYPE_INFO
