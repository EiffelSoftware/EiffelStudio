indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	METHOD_CALL_MESSAGE_WRAPPER

inherit
	INTERNAL_MESSAGE_WRAPPER
	IMETHOD_CALL_MESSAGE
	IMETHOD_MESSAGE
	IMESSAGE

create
	make_method_call_message_wrapper

feature {NONE} -- Initialization

	frozen make_method_call_message_wrapper (msg: IMETHOD_CALL_MESSAGE) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMethodCallMessage) use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		end

feature -- Access

	get_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_Uri"
		end

	get_has_var_args: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_HasVarArgs"
		end

	get_in_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_InArgs"
		end

	get_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_Args"
		end

	get_method_base: METHOD_BASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_MethodBase"
		end

	get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_TypeName"
		end

	get_method_signature: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_MethodSignature"
		end

	get_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_ArgCount"
		end

	get_in_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_InArgCount"
		end

	get_logical_call_context: LOGICAL_CALL_CONTEXT is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_LogicalCallContext"
		end

	get_method_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_MethodName"
		end

	get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_Properties"
		end

feature -- Element Change

	set_uri (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"set_Uri"
		end

	set_args (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"set_Args"
		end

feature -- Basic Operations

	get_in_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetInArgName"
		end

	get_in_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetInArg"
		end

	get_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetArg"
		end

	get_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetArgName"
		end

end -- class METHOD_CALL_MESSAGE_WRAPPER
