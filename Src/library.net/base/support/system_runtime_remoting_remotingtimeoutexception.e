indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.RemotingTimeoutException"

external class
	SYSTEM_RUNTIME_REMOTING_REMOTINGTIMEOUTEXCEPTION

inherit
	SYSTEM_RUNTIME_REMOTING_REMOTINGEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_remoting_timeout_exception_2,
	make_remoting_timeout_exception,
	make_remoting_timeout_exception_1

feature {NONE} -- Initialization

	frozen make_remoting_timeout_exception_2 (message2: STRING; InnerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.RemotingTimeoutException"
		end

	frozen make_remoting_timeout_exception is
		external
			"IL creator use System.Runtime.Remoting.RemotingTimeoutException"
		end

	frozen make_remoting_timeout_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.RemotingTimeoutException"
		end

end -- class SYSTEM_RUNTIME_REMOTING_REMOTINGTIMEOUTEXCEPTION
