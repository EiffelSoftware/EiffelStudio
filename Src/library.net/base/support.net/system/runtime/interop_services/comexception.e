indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.COMException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	COMEXCEPTION

inherit
	EXTERNAL_EXCEPTION
		redefine
			to_string
		end
	ISERIALIZABLE

create
	make_comexception_3,
	make_comexception_2,
	make_comexception,
	make_comexception_1

feature {NONE} -- Initialization

	frozen make_comexception_3 (message: SYSTEM_STRING; error_code: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.InteropServices.COMException"
		end

	frozen make_comexception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.COMException"
		end

	frozen make_comexception is
		external
			"IL creator use System.Runtime.InteropServices.COMException"
		end

	frozen make_comexception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.COMException"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.COMException"
		alias
			"ToString"
		end

end -- class COMEXCEPTION
