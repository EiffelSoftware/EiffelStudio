indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.ServerException"

external class
	SYSTEM_RUNTIME_REMOTING_SERVEREXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_serverexception_2,
	make_serverexception_1,
	make_serverexception

feature {NONE} -- Initialization

	frozen make_serverexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.ServerException"
		end

	frozen make_serverexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.ServerException"
		end

	frozen make_serverexception is
		external
			"IL creator use System.Runtime.Remoting.ServerException"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SERVEREXCEPTION
