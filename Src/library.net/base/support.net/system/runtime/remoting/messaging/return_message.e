indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.ReturnMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RETURN_MESSAGE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IMETHOD_RETURN_MESSAGE
	IMETHOD_MESSAGE
	IMESSAGE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (ret: SYSTEM_OBJECT; out_args: NATIVE_ARRAY [SYSTEM_OBJECT]; out_args_count: INTEGER; call_ctx: LOGICAL_CALL_CONTEXT; mcm: IMETHOD_CALL_MESSAGE) is
		external
			"IL creator signature (System.Object, System.Object[], System.Int32, System.Runtime.Remoting.Messaging.LogicalCallContext, System.Runtime.Remoting.Messaging.IMethodCallMessage) use System.Runtime.Remoting.Messaging.ReturnMessage"
		end

	frozen make_1 (e: EXCEPTION; mcm: IMETHOD_CALL_MESSAGE) is
		external
			"IL creator signature (System.Exception, System.Runtime.Remoting.Messaging.IMethodCallMessage) use System.Runtime.Remoting.Messaging.ReturnMessage"
		end

feature -- Access

	frozen get_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Uri"
		end

	frozen get_has_var_args: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_HasVarArgs"
		end

	frozen get_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Exception"
		end

	frozen get_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Args"
		end

	frozen get_out_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_OutArgs"
		end

	frozen get_method_base: METHOD_BASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_MethodBase"
		end

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_TypeName"
		end

	frozen get_method_signature: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_MethodSignature"
		end

	frozen get_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_ArgCount"
		end

	frozen get_out_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_OutArgCount"
		end

	frozen get_logical_call_context: LOGICAL_CALL_CONTEXT is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_LogicalCallContext"
		end

	frozen get_method_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_MethodName"
		end

	get_return_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_ReturnValue"
		end

	get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Properties"
		end

feature -- Element Change

	frozen set_uri (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"set_Uri"
		end

feature -- Basic Operations

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"ToString"
		end

	frozen get_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetArg"
		end

	frozen get_out_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetOutArgName"
		end

	frozen get_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetArgName"
		end

	frozen get_out_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetOutArg"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"Finalize"
		end

end -- class RETURN_MESSAGE
