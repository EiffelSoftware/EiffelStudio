indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.COMException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_COMEXCEPTION

inherit
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
		redefine
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_comexception_3,
	make_comexception_2,
	make_comexception,
	make_comexception_1

feature {NONE} -- Initialization

	frozen make_comexception_3 (message: STRING; error_code: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.InteropServices.COMException"
		end

	frozen make_comexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.COMException"
		end

	frozen make_comexception is
		external
			"IL creator use System.Runtime.InteropServices.COMException"
		end

	frozen make_comexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.COMException"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.COMException"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_COMEXCEPTION
