indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.StringFormat"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_STRING_FORMAT

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			to_string
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_string_format_2,
	make_drawing_string_format_3,
	make_drawing_string_format,
	make_drawing_string_format_1

feature {NONE} -- Initialization

	frozen make_drawing_string_format_2 (options: DRAWING_STRING_FORMAT_FLAGS; language: INTEGER) is
		external
			"IL creator signature (System.Drawing.StringFormatFlags, System.Int32) use System.Drawing.StringFormat"
		end

	frozen make_drawing_string_format_3 (format: DRAWING_STRING_FORMAT) is
		external
			"IL creator signature (System.Drawing.StringFormat) use System.Drawing.StringFormat"
		end

	frozen make_drawing_string_format is
		external
			"IL creator use System.Drawing.StringFormat"
		end

	frozen make_drawing_string_format_1 (options: DRAWING_STRING_FORMAT_FLAGS) is
		external
			"IL creator signature (System.Drawing.StringFormatFlags) use System.Drawing.StringFormat"
		end

feature -- Access

	frozen get_trimming: DRAWING_STRING_TRIMMING is
		external
			"IL signature (): System.Drawing.StringTrimming use System.Drawing.StringFormat"
		alias
			"get_Trimming"
		end

	frozen get_digit_substitution_method: DRAWING_STRING_DIGIT_SUBSTITUTE is
		external
			"IL signature (): System.Drawing.StringDigitSubstitute use System.Drawing.StringFormat"
		alias
			"get_DigitSubstitutionMethod"
		end

	frozen get_line_alignment: DRAWING_STRING_ALIGNMENT is
		external
			"IL signature (): System.Drawing.StringAlignment use System.Drawing.StringFormat"
		alias
			"get_LineAlignment"
		end

	frozen get_format_flags: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL signature (): System.Drawing.StringFormatFlags use System.Drawing.StringFormat"
		alias
			"get_FormatFlags"
		end

	frozen get_hotkey_prefix: DRAWING_HOTKEY_PREFIX is
		external
			"IL signature (): System.Drawing.Text.HotkeyPrefix use System.Drawing.StringFormat"
		alias
			"get_HotkeyPrefix"
		end

	frozen get_digit_substitution_language: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.StringFormat"
		alias
			"get_DigitSubstitutionLanguage"
		end

	frozen get_generic_default: DRAWING_STRING_FORMAT is
		external
			"IL static signature (): System.Drawing.StringFormat use System.Drawing.StringFormat"
		alias
			"get_GenericDefault"
		end

	frozen get_alignment: DRAWING_STRING_ALIGNMENT is
		external
			"IL signature (): System.Drawing.StringAlignment use System.Drawing.StringFormat"
		alias
			"get_Alignment"
		end

	frozen get_generic_typographic: DRAWING_STRING_FORMAT is
		external
			"IL static signature (): System.Drawing.StringFormat use System.Drawing.StringFormat"
		alias
			"get_GenericTypographic"
		end

feature -- Element Change

	frozen set_trimming (value: DRAWING_STRING_TRIMMING) is
		external
			"IL signature (System.Drawing.StringTrimming): System.Void use System.Drawing.StringFormat"
		alias
			"set_Trimming"
		end

	frozen set_hotkey_prefix (value: DRAWING_HOTKEY_PREFIX) is
		external
			"IL signature (System.Drawing.Text.HotkeyPrefix): System.Void use System.Drawing.StringFormat"
		alias
			"set_HotkeyPrefix"
		end

	frozen set_line_alignment (value: DRAWING_STRING_ALIGNMENT) is
		external
			"IL signature (System.Drawing.StringAlignment): System.Void use System.Drawing.StringFormat"
		alias
			"set_LineAlignment"
		end

	frozen set_format_flags (value: DRAWING_STRING_FORMAT_FLAGS) is
		external
			"IL signature (System.Drawing.StringFormatFlags): System.Void use System.Drawing.StringFormat"
		alias
			"set_FormatFlags"
		end

	frozen set_alignment (value: DRAWING_STRING_ALIGNMENT) is
		external
			"IL signature (System.Drawing.StringAlignment): System.Void use System.Drawing.StringFormat"
		alias
			"set_Alignment"
		end

feature -- Basic Operations

	frozen set_digit_substitution (language: INTEGER; substitute: DRAWING_STRING_DIGIT_SUBSTITUTE) is
		external
			"IL signature (System.Int32, System.Drawing.StringDigitSubstitute): System.Void use System.Drawing.StringFormat"
		alias
			"SetDigitSubstitution"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.StringFormat"
		alias
			"Dispose"
		end

	frozen set_tab_stops (first_tab_offset: REAL; tab_stops: NATIVE_ARRAY [REAL]) is
		external
			"IL signature (System.Single, System.Single[]): System.Void use System.Drawing.StringFormat"
		alias
			"SetTabStops"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.StringFormat"
		alias
			"ToString"
		end

	frozen get_tab_stops (first_tab_offset: REAL): NATIVE_ARRAY [REAL] is
		external
			"IL signature (System.Single&): System.Single[] use System.Drawing.StringFormat"
		alias
			"GetTabStops"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.StringFormat"
		alias
			"Clone"
		end

	frozen set_measurable_character_ranges (ranges: NATIVE_ARRAY [DRAWING_CHARACTER_RANGE]) is
		external
			"IL signature (System.Drawing.CharacterRange[]): System.Void use System.Drawing.StringFormat"
		alias
			"SetMeasurableCharacterRanges"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.StringFormat"
		alias
			"Finalize"
		end

end -- class DRAWING_STRING_FORMAT
