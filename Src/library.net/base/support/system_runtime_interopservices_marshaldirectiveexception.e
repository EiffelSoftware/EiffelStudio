indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.MarshalDirectiveException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALDIRECTIVEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_marshal_directive_exception_2,
	make_marshal_directive_exception,
	make_marshal_directive_exception_1

feature {NONE} -- Initialization

	frozen make_marshal_directive_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.MarshalDirectiveException"
		end

	frozen make_marshal_directive_exception is
		external
			"IL creator use System.Runtime.InteropServices.MarshalDirectiveException"
		end

	frozen make_marshal_directive_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.MarshalDirectiveException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALDIRECTIVEEXCEPTION
