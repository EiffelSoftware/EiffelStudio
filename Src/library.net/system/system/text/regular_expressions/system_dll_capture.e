indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.Capture"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CAPTURE

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.Capture"
		alias
			"get_Index"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.Capture"
		alias
			"get_Length"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.Capture"
		alias
			"get_Value"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.Capture"
		alias
			"ToString"
		end

end -- class SYSTEM_DLL_CAPTURE
