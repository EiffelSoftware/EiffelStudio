indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.IMethodCallMessage"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE

inherit
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

feature -- Access

	get_in_arg_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"get_InArgCount"
		end

	get_in_args: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"get_InArgs"
		end

feature -- Basic Operations

	get_in_arg (argNum: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"GetInArg"
		end

	get_in_arg_name (index: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.IMethodCallMessage"
		alias
			"GetInArgName"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE
