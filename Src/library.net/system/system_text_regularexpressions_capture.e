indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.Capture"

external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURE

inherit
	ANY
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

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.Capture"
		alias
			"get_Value"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.Capture"
		alias
			"ToString"
		end

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURE
