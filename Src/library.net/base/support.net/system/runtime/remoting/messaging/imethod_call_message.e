indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IMethodCallMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMETHOD_CALL_MESSAGE

inherit
	IMETHOD_MESSAGE
	IMESSAGE

feature -- Access

	get_in_args: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"get_InArgs"
		end

	get_in_arg_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"get_InArgCount"
		end

feature -- Basic Operations

	get_in_arg_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"GetInArgName"
		end

	get_in_arg (arg_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"GetInArg"
		end

end -- class IMETHOD_CALL_MESSAGE
