indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.IRemotingTypeInfo"

deferred external class
	SYSTEM_RUNTIME_REMOTING_IREMOTINGTYPEINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_type_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.IRemotingTypeInfo"
		alias
			"get_TypeName"
		end

feature -- Element Change

	set_type_name (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Remoting.IRemotingTypeInfo"
		alias
			"set_TypeName"
		end

feature -- Basic Operations

	can_cast_to (from_type: SYSTEM_TYPE; o: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Type, System.Object): System.Boolean use System.Runtime.Remoting.IRemotingTypeInfo"
		alias
			"CanCastTo"
		end

end -- class SYSTEM_RUNTIME_REMOTING_IREMOTINGTYPEINFO
