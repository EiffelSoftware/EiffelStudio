indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IMethodReturnMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMETHOD_RETURN_MESSAGE

inherit
	IMETHOD_MESSAGE
	IMESSAGE

feature -- Access

	get_out_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_OutArgs"
		end

	get_out_arg_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_OutArgCount"
		end

	get_exception: EXCEPTION is
		external
			"IL deferred signature (): System.Exception use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_Exception"
		end

	get_return_value: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_ReturnValue"
		end

feature -- Basic Operations

	get_out_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"GetOutArgName"
		end

	get_out_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"GetOutArg"
		end

end -- class IMETHOD_RETURN_MESSAGE
