indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.StringInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STRING_INFO

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Globalization.StringInfo"
		end

feature -- Basic Operations

	frozen get_next_text_element (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Globalization.StringInfo"
		alias
			"GetNextTextElement"
		end

	frozen get_text_element_enumerator_string_int32 (str: SYSTEM_STRING; index: INTEGER): TEXT_ELEMENT_ENUMERATOR is
		external
			"IL static signature (System.String, System.Int32): System.Globalization.TextElementEnumerator use System.Globalization.StringInfo"
		alias
			"GetTextElementEnumerator"
		end

	frozen parse_combining_characters (str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER] is
		external
			"IL static signature (System.String): System.Int32[] use System.Globalization.StringInfo"
		alias
			"ParseCombiningCharacters"
		end

	frozen get_next_text_element_string_int32 (str: SYSTEM_STRING; index: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Int32): System.String use System.Globalization.StringInfo"
		alias
			"GetNextTextElement"
		end

	frozen get_text_element_enumerator (str: SYSTEM_STRING): TEXT_ELEMENT_ENUMERATOR is
		external
			"IL static signature (System.String): System.Globalization.TextElementEnumerator use System.Globalization.StringInfo"
		alias
			"GetTextElementEnumerator"
		end

end -- class STRING_INFO
