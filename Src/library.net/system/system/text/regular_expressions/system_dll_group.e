indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.Group"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_GROUP

inherit
	SYSTEM_DLL_CAPTURE

create {NONE}

feature -- Access

	frozen get_success: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.Group"
		alias
			"get_Success"
		end

	frozen get_captures: SYSTEM_DLL_CAPTURE_COLLECTION is
		external
			"IL signature (): System.Text.RegularExpressions.CaptureCollection use System.Text.RegularExpressions.Group"
		alias
			"get_Captures"
		end

feature -- Basic Operations

	frozen synchronized (inner: SYSTEM_DLL_GROUP): SYSTEM_DLL_GROUP is
		external
			"IL static signature (System.Text.RegularExpressions.Group): System.Text.RegularExpressions.Group use System.Text.RegularExpressions.Group"
		alias
			"Synchronized"
		end

end -- class SYSTEM_DLL_GROUP
