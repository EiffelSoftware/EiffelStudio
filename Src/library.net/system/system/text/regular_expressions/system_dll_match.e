indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.Match"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_MATCH

inherit
	SYSTEM_DLL_GROUP

create {NONE}

feature -- Access

	frozen get_empty: SYSTEM_DLL_MATCH is
		external
			"IL static signature (): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Match"
		alias
			"get_Empty"
		end

	get_groups: SYSTEM_DLL_GROUP_COLLECTION is
		external
			"IL signature (): System.Text.RegularExpressions.GroupCollection use System.Text.RegularExpressions.Match"
		alias
			"get_Groups"
		end

feature -- Basic Operations

	frozen synchronized_match (inner: SYSTEM_DLL_MATCH): SYSTEM_DLL_MATCH is
		external
			"IL static signature (System.Text.RegularExpressions.Match): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Match"
		alias
			"Synchronized"
		end

	frozen next_match: SYSTEM_DLL_MATCH is
		external
			"IL signature (): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Match"
		alias
			"NextMatch"
		end

	result_ (replacement: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Text.RegularExpressions.Match"
		alias
			"Result"
		end

end -- class SYSTEM_DLL_MATCH
