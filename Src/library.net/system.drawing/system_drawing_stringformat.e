indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.StringFormat"

frozen external class
	SYSTEM_DRAWING_STRINGFORMAT

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_stringformat_2,
	make_stringformat_3,
	make_stringformat_1,
	make_stringformat

feature {NONE} -- Initialization

	frozen make_stringformat_2 (options: SYSTEM_DRAWING_STRINGFORMATFLAGS; language: INTEGER) is
		external
			"IL creator signature (System.Drawing.StringFormatFlags, System.Int32) use System.Drawing.StringFormat"
		end

	frozen make_stringformat_3 (format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL creator signature (System.Drawing.StringFormat) use System.Drawing.StringFormat"
		end

	frozen make_stringformat_1 (options: SYSTEM_DRAWING_STRINGFORMATFLAGS) is
		external
			"IL creator signature (System.Drawing.StringFormatFlags) use System.Drawing.StringFormat"
		end

	frozen make_stringformat is
		external
			"IL creator use System.Drawing.StringFormat"
		end

feature -- Access

	frozen get_trimming: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL signature (): System.Drawing.StringTrimming use System.Drawing.StringFormat"
		alias
			"get_Trimming"
		end

	frozen get_digit_substitution_method: SYSTEM_DRAWING_STRINGDIGITSUBSTITUTE is
		external
			"IL signature (): System.Drawing.StringDigitSubstitute use System.Drawing.StringFormat"
		alias
			"get_DigitSubstitutionMethod"
		end

	frozen get_line_alignment: SYSTEM_DRAWING_STRINGALIGNMENT is
		external
			"IL signature (): System.Drawing.StringAlignment use System.Drawing.StringFormat"
		alias
			"get_LineAlignment"
		end

	frozen get_format_flags: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL signature (): System.Drawing.StringFormatFlags use System.Drawing.StringFormat"
		alias
			"get_FormatFlags"
		end

	frozen get_hotkey_prefix: SYSTEM_DRAWING_TEXT_HOTKEYPREFIX is
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

	frozen get_generic_default: SYSTEM_DRAWING_STRINGFORMAT is
		external
			"IL static signature (): System.Drawing.StringFormat use System.Drawing.StringFormat"
		alias
			"get_GenericDefault"
		end

	frozen get_alignment: SYSTEM_DRAWING_STRINGALIGNMENT is
		external
			"IL signature (): System.Drawing.StringAlignment use System.Drawing.StringFormat"
		alias
			"get_Alignment"
		end

	frozen get_generic_typographic: SYSTEM_DRAWING_STRINGFORMAT is
		external
			"IL static signature (): System.Drawing.StringFormat use System.Drawing.StringFormat"
		alias
			"get_GenericTypographic"
		end

feature -- Element Change

	frozen set_trimming (value: SYSTEM_DRAWING_STRINGTRIMMING) is
		external
			"IL signature (System.Drawing.StringTrimming): System.Void use System.Drawing.StringFormat"
		alias
			"set_Trimming"
		end

	frozen set_hotkey_prefix (value: SYSTEM_DRAWING_TEXT_HOTKEYPREFIX) is
		external
			"IL signature (System.Drawing.Text.HotkeyPrefix): System.Void use System.Drawing.StringFormat"
		alias
			"set_HotkeyPrefix"
		end

	frozen set_line_alignment (value: SYSTEM_DRAWING_STRINGALIGNMENT) is
		external
			"IL signature (System.Drawing.StringAlignment): System.Void use System.Drawing.StringFormat"
		alias
			"set_LineAlignment"
		end

	frozen set_format_flags (value: SYSTEM_DRAWING_STRINGFORMATFLAGS) is
		external
			"IL signature (System.Drawing.StringFormatFlags): System.Void use System.Drawing.StringFormat"
		alias
			"set_FormatFlags"
		end

	frozen set_alignment (value: SYSTEM_DRAWING_STRINGALIGNMENT) is
		external
			"IL signature (System.Drawing.StringAlignment): System.Void use System.Drawing.StringFormat"
		alias
			"set_Alignment"
		end

feature -- Basic Operations

	frozen set_digit_substitution (language: INTEGER; substitute: SYSTEM_DRAWING_STRINGDIGITSUBSTITUTE) is
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

	frozen set_tab_stops (first_tab_offset: REAL; tab_stops: ARRAY [REAL]) is
		external
			"IL signature (System.Single, System.Single[]): System.Void use System.Drawing.StringFormat"
		alias
			"SetTabStops"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.StringFormat"
		alias
			"ToString"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.StringFormat"
		alias
			"Clone"
		end

	frozen get_tab_stops (first_tab_offset: REAL): ARRAY [REAL] is
		external
			"IL signature (System.Single&): System.Single[] use System.Drawing.StringFormat"
		alias
			"GetTabStops"
		end

	frozen set_measurable_character_ranges (ranges: ARRAY [SYSTEM_DRAWING_CHARACTERRANGE]) is
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

end -- class SYSTEM_DRAWING_STRINGFORMAT
