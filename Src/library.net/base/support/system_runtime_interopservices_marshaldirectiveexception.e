indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.MarshalDirectiveException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALDIRECTIVEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_marshaldirectiveexception_2,
	make_marshaldirectiveexception,
	make_marshaldirectiveexception_1

feature {NONE} -- Initialization

	frozen make_marshaldirectiveexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.MarshalDirectiveException"
		end

	frozen make_marshaldirectiveexception is
		external
			"IL creator use System.Runtime.InteropServices.MarshalDirectiveException"
		end

	frozen make_marshaldirectiveexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.MarshalDirectiveException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALDIRECTIVEEXCEPTION
