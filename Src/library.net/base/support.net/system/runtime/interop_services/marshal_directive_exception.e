indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.MarshalDirectiveException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MARSHAL_DIRECTIVE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_marshal_directive_exception,
	make_marshal_directive_exception_1,
	make_marshal_directive_exception_2

feature {NONE} -- Initialization

	frozen make_marshal_directive_exception is
		external
			"IL creator use System.Runtime.InteropServices.MarshalDirectiveException"
		end

	frozen make_marshal_directive_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.MarshalDirectiveException"
		end

	frozen make_marshal_directive_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.MarshalDirectiveException"
		end

end -- class MARSHAL_DIRECTIVE_EXCEPTION
