indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.StringInfo"

external class
	SYSTEM_GLOBALIZATION_STRINGINFO

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Globalization.StringInfo"
		end

feature -- Basic Operations

	frozen get_next_text_element (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Globalization.StringInfo"
		alias
			"GetNextTextElement"
		end

	frozen get_text_element_enumerator_string_int32 (str: STRING; index: INTEGER): SYSTEM_GLOBALIZATION_TEXTELEMENTENUMERATOR is
		external
			"IL static signature (System.String, System.Int32): System.Globalization.TextElementEnumerator use System.Globalization.StringInfo"
		alias
			"GetTextElementEnumerator"
		end

	frozen parse_combining_characters (str: STRING): ARRAY [INTEGER] is
		external
			"IL static signature (System.String): System.Int32[] use System.Globalization.StringInfo"
		alias
			"ParseCombiningCharacters"
		end

	frozen get_next_text_element_string_int32 (str: STRING; index: INTEGER): STRING is
		external
			"IL static signature (System.String, System.Int32): System.String use System.Globalization.StringInfo"
		alias
			"GetNextTextElement"
		end

	frozen get_text_element_enumerator (str: STRING): SYSTEM_GLOBALIZATION_TEXTELEMENTENUMERATOR is
		external
			"IL static signature (System.String): System.Globalization.TextElementEnumerator use System.Globalization.StringInfo"
		alias
			"GetTextElementEnumerator"
		end

end -- class SYSTEM_GLOBALIZATION_STRINGINFO
