indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.IMethodMessage"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE

inherit
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

feature -- Access

	get_arg_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_ArgCount"
		end

	get_uri: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_Uri"
		end

	get_has_var_args: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_HasVarArgs"
		end

	get_type_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_TypeName"
		end

	get_args: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_Args"
		end

	get_method_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_MethodName"
		end

	get_method_signature: ANY is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_MethodSignature"
		end

	get_logical_call_context: SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_LogicalCallContext"
		end

	get_method_base: SYSTEM_REFLECTION_METHODBASE is
		external
			"IL deferred signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_MethodBase"
		end

feature -- Basic Operations

	get_arg_name (index: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"GetArgName"
		end

	get_arg (argNum: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"GetArg"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
