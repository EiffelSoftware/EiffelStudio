indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.ServerException"

external class
	SYSTEM_RUNTIME_REMOTING_SERVEREXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_server_exception_2,
	make_server_exception_1,
	make_server_exception

feature {NONE} -- Initialization

	frozen make_server_exception_2 (message2: STRING; InnerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.ServerException"
		end

	frozen make_server_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.ServerException"
		end

	frozen make_server_exception is
		external
			"IL creator use System.Runtime.Remoting.ServerException"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SERVEREXCEPTION
