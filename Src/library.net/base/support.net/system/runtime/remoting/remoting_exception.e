indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.RemotingException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	REMOTING_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_remoting_exception_1,
	make_remoting_exception,
	make_remoting_exception_2

feature {NONE} -- Initialization

	frozen make_remoting_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.RemotingException"
		end

	frozen make_remoting_exception is
		external
			"IL creator use System.Runtime.Remoting.RemotingException"
		end

	frozen make_remoting_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.RemotingException"
		end

end -- class REMOTING_EXCEPTION
