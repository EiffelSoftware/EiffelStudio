indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.RemotingTimeoutException"

external class
	SYSTEM_RUNTIME_REMOTING_REMOTINGTIMEOUTEXCEPTION

inherit
	SYSTEM_RUNTIME_REMOTING_REMOTINGEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_remotingtimeoutexception_2,
	make_remotingtimeoutexception,
	make_remotingtimeoutexception_1

feature {NONE} -- Initialization

	frozen make_remotingtimeoutexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.RemotingTimeoutException"
		end

	frozen make_remotingtimeoutexception is
		external
			"IL creator use System.Runtime.Remoting.RemotingTimeoutException"
		end

	frozen make_remotingtimeoutexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.RemotingTimeoutException"
		end

end -- class SYSTEM_RUNTIME_REMOTING_REMOTINGTIMEOUTEXCEPTION
