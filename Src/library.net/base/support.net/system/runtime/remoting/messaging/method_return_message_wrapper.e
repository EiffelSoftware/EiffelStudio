indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	METHOD_RETURN_MESSAGE_WRAPPER

inherit
	INTERNAL_MESSAGE_WRAPPER
	IMETHOD_RETURN_MESSAGE
	IMETHOD_MESSAGE
	IMESSAGE

create
	make_method_return_message_wrapper

feature {NONE} -- Initialization

	frozen make_method_return_message_wrapper (msg: IMETHOD_RETURN_MESSAGE) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMethodReturnMessage) use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		end

feature -- Access

	frozen get_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Uri"
		end

	get_has_var_args: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_HasVarArgs"
		end

	get_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Exception"
		end

	get_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Args"
		end

	get_out_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_OutArgs"
		end

	get_method_base: METHOD_BASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_MethodBase"
		end

	get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_TypeName"
		end

	get_method_signature: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_MethodSignature"
		end

	get_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_ArgCount"
		end

	get_out_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_OutArgCount"
		end

	get_logical_call_context: LOGICAL_CALL_CONTEXT is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_LogicalCallContext"
		end

	get_method_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_MethodName"
		end

	get_return_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_ReturnValue"
		end

	get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Properties"
		end

feature -- Element Change

	set_return_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_ReturnValue"
		end

	set_exception (value: EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_Exception"
		end

	set_args (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_Args"
		end

	frozen set_uri (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_Uri"
		end

feature -- Basic Operations

	get_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetArg"
		end

	get_out_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetOutArgName"
		end

	get_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetArgName"
		end

	get_out_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetOutArg"
		end

end -- class METHOD_RETURN_MESSAGE_WRAPPER
