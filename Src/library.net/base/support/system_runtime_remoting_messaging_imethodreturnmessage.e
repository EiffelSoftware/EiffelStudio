indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.IMethodReturnMessage"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODRETURNMESSAGE

inherit
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

feature -- Access

	get_out_arg_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_OutArgCount"
		end

	get_exception: SYSTEM_EXCEPTION is
		external
			"IL deferred signature (): System.Exception use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_Exception"
		end

	get_return_value: ANY is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_ReturnValue"
		end

	get_out_args: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"get_OutArgs"
		end

feature -- Basic Operations

	get_out_arg (argNum: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"GetOutArg"
		end

	get_out_arg_name (index: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.IMethodReturnMessage"
		alias
			"GetOutArgName"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODRETURNMESSAGE
