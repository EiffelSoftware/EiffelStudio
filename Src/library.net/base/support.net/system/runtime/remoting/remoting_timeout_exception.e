indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.RemotingTimeoutException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	REMOTING_TIMEOUT_EXCEPTION

inherit
	REMOTING_EXCEPTION
	ISERIALIZABLE

create
	make_remoting_timeout_exception_1,
	make_remoting_timeout_exception_2,
	make_remoting_timeout_exception

feature {NONE} -- Initialization

	frozen make_remoting_timeout_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.RemotingTimeoutException"
		end

	frozen make_remoting_timeout_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.RemotingTimeoutException"
		end

	frozen make_remoting_timeout_exception is
		external
			"IL creator use System.Runtime.Remoting.RemotingTimeoutException"
		end

end -- class REMOTING_TIMEOUT_EXCEPTION
