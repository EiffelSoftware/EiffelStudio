indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.CharacterRange"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_CHARACTER_RANGE

inherit
	VALUE_TYPE

feature -- Initialization

	frozen make_drawing_character_range (first: INTEGER; length: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Drawing.CharacterRange"
		end

feature -- Access

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.CharacterRange"
		alias
			"get_Length"
		end

	frozen get_first: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.CharacterRange"
		alias
			"get_First"
		end

feature -- Element Change

	frozen set_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.CharacterRange"
		alias
			"set_Length"
		end

	frozen set_first (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.CharacterRange"
		alias
			"set_First"
		end

end -- class DRAWING_CHARACTER_RANGE
