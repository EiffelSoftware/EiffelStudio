indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.CharacterRange"

frozen expanded external class
	SYSTEM_DRAWING_CHARACTERRANGE

inherit
	VALUE_TYPE



feature -- Initialization

	frozen make_characterrange (first: INTEGER; length: INTEGER) is
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

end -- class SYSTEM_DRAWING_CHARACTERRANGE
