indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.RemotingException"

external class
	SYSTEM_RUNTIME_REMOTING_REMOTINGEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_remotingexception_2,
	make_remotingexception_1,
	make_remotingexception

feature {NONE} -- Initialization

	frozen make_remotingexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.RemotingException"
		end

	frozen make_remotingexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.RemotingException"
		end

	frozen make_remotingexception is
		external
			"IL creator use System.Runtime.Remoting.RemotingException"
		end

end -- class SYSTEM_RUNTIME_REMOTING_REMOTINGEXCEPTION
