indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IMethodMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMETHOD_MESSAGE

inherit
	IMESSAGE

feature -- Access

	get_uri: SYSTEM_STRING is
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

	get_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_Args"
		end

	get_method_base: METHOD_BASE is
		external
			"IL deferred signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_MethodBase"
		end

	get_type_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_TypeName"
		end

	get_method_signature: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_MethodSignature"
		end

	get_arg_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_ArgCount"
		end

	get_logical_call_context: LOGICAL_CALL_CONTEXT is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_LogicalCallContext"
		end

	get_method_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"get_MethodName"
		end

feature -- Basic Operations

	get_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"GetArg"
		end

	get_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.IMethodMessage"
		alias
			"GetArgName"
		end

end -- class IMETHOD_MESSAGE
