indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.SEHException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SEHEXCEPTION

inherit
	EXTERNAL_EXCEPTION
	ISERIALIZABLE

create
	make_sehexception_1,
	make_sehexception,
	make_sehexception_2

feature {NONE} -- Initialization

	frozen make_sehexception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.SEHException"
		end

	frozen make_sehexception is
		external
			"IL creator use System.Runtime.InteropServices.SEHException"
		end

	frozen make_sehexception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.SEHException"
		end

feature -- Basic Operations

	can_resume: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.InteropServices.SEHException"
		alias
			"CanResume"
		end

end -- class SEHEXCEPTION
