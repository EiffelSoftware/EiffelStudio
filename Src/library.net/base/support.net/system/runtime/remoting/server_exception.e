indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.ServerException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SERVER_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_server_exception_2,
	make_server_exception_1,
	make_server_exception

feature {NONE} -- Initialization

	frozen make_server_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Remoting.ServerException"
		end

	frozen make_server_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.ServerException"
		end

	frozen make_server_exception is
		external
			"IL creator use System.Runtime.Remoting.ServerException"
		end

end -- class SERVER_EXCEPTION
