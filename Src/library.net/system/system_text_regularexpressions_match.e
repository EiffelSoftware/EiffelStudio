indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.Match"

external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH

inherit
	SYSTEM_TEXT_REGULAREXPRESSIONS_GROUP

create {NONE}

feature -- Access

	frozen get_empty: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL static signature (): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Match"
		alias
			"get_Empty"
		end

	get_groups: SYSTEM_TEXT_REGULAREXPRESSIONS_GROUPCOLLECTION is
		external
			"IL signature (): System.Text.RegularExpressions.GroupCollection use System.Text.RegularExpressions.Match"
		alias
			"get_Groups"
		end

feature -- Basic Operations

	frozen synchronized_match (inner: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL static signature (System.Text.RegularExpressions.Match): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Match"
		alias
			"Synchronized"
		end

	Result_ (replacement: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Text.RegularExpressions.Match"
		alias
			"Result"
		end

	frozen next_match: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL signature (): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Match"
		alias
			"NextMatch"
		end

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH
