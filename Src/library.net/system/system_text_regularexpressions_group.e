indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.Group"

external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_GROUP

inherit
	SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURE

create {NONE}

feature -- Access

	frozen get_success: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.Group"
		alias
			"get_Success"
		end

	frozen get_captures: SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURECOLLECTION is
		external
			"IL signature (): System.Text.RegularExpressions.CaptureCollection use System.Text.RegularExpressions.Group"
		alias
			"get_Captures"
		end

feature -- Basic Operations

	frozen synchronized (inner: SYSTEM_TEXT_REGULAREXPRESSIONS_GROUP): SYSTEM_TEXT_REGULAREXPRESSIONS_GROUP is
		external
			"IL static signature (System.Text.RegularExpressions.Group): System.Text.RegularExpressions.Group use System.Text.RegularExpressions.Group"
		alias
			"Synchronized"
		end

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_GROUP
