indexing
	description: "Defines the attributes of a font."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LOG_FONT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_FONT_QUALITY_CONSTANTS
		export
			{NONE} all
		end

	WEL_OUT_PRECISION_CONSTANTS
		export
			{NONE} all
		end

	WEL_CLIP_PRECISION_CONSTANTS
		export
			{NONE} all
		end

	WEL_FONT_PITCH_CONSTANTS
		export
			{NONE} all
		end

	WEL_CHARACTER_SET_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	WEL_FONT_FAMILY_CONSTANTS
		export
			{NONE} all
		end

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		end

creation 
	make,
	make_with_pointer,
	make_by_font

feature {NONE} -- Initialization

	make (a_height: INTEGER; a_face_name: STRING) is
			-- Make a font with `a_height' as `height' and
			-- `a_face_name' as `face_name'.
		require
			a_face_name_not_void: a_face_name /= Void
			valid_count: a_face_name.count <= Max_face_name_length
		do
			structure_make
			set_height (a_height)
			set_width (0)
			set_escapement (0)
			set_weight (0)
			set_not_italic
			set_not_underlined
			set_not_strike_out
			set_default_character_set
			set_default_output_precision
			set_default_clipping_precision
			set_default_quality
			set_default_pitch
			set_dont_care_family
			set_face_name (a_face_name)
		ensure
			height_set: height = a_height
			width_set: width = 0
			escapement_set: escapement = 0
			weight_set: weight = 0
			not_italic: not italic
			not_underlined: not underlined
			not_strike_out: not strike_out
			has_default_character_set: has_default_character_set
			has_default_clipping_precision:
				has_default_clipping_precision
			has_default_quality: has_default_quality
			has_default_pitch: has_default_pitch
			is_dont_care_family: is_dont_care_family
			face_name_set: face_name.is_equal (a_face_name)
		end

	make_by_font (font: WEL_FONT) is
			-- Make a log font using the information of `font'.
		require
			font_not_void: font /= Void
			font_exists: font.exists
		do
			structure_make
			cwin_get_object (font.item, structure_size, item)
		end

	make_with_pointer (a_pointer: POINTER) is
			-- Copy structure pointed by `a_pointer' in
			-- `item'.
		do
			structure_make
			memory_copy (a_pointer, structure_size)
		end

feature -- Re-initialisation

	update_by_font (font: WEL_FONT) is
			-- Update object attributes using the information of `font'.
		require
			font_not_void: font /= Void
			font_exists: font.exists
		do
			cwin_get_object (font.item, structure_size, item)
		end

feature -- Access

	height: INTEGER is
			-- Height of current font.
			-- Specifies the height, in logical units, of the
			-- font. The font height can be specified in one of
			-- three ways. If `height' is greater than zero, it
			-- is transformed into device units and matched 
			-- against the cell height of the available fonts. If 
			-- it is zero, a reasonable default size is used. If
			-- it is less than zero, it is transformed into 
			-- device units and the absolute value is matched 
			-- against the character height of the available 
			-- fonts.
		do
			Result := cwel_log_font_get_height (item)
		end

	height_in_points: INTEGER is
			-- Size of font in points (1 point = 1/72 of an inch)
		local
			screen_dc: WEL_SCREEN_DC
		do
			Result := -height
			create screen_dc
			screen_dc.get
			Result := mul_div (Result, 72,
								get_device_caps (screen_dc.item, logical_pixels_y))
			screen_dc.release
		end


	width: INTEGER is
			-- Width of current font.
			-- Specifies the average width, in logical units, of
			-- characters in the font. If `width' is zero, the
			-- aspect ratio of the device is matched against the
			-- digitization aspect ratio of the available fonts to
			-- find the closest match, determined by the absolute
			-- value of the difference. 
		do
			Result := cwel_log_font_get_width (item)
		end

	escapement: INTEGER is
			-- Escapement of current font.
			-- The angle, in tenths of degrees, of each line of
			-- text written in the font (relative to the
			-- bottom of the page). 
		do
			Result := cwel_log_font_get_escapement (item)
		end

	orientation: INTEGER is
			-- Orientation of current font.
			-- The angle, in tenths of degrees, of each
			-- character's base line (relative to the bottom
			-- of the page).
		do
			Result := cwel_log_font_get_orientation (item)
		end

	weight: INTEGER is
			-- Weight of current font.
			-- In the range 0 through 1000, for example,
			-- 400 is normal and 700 is bold).
		do
			Result := cwel_log_font_get_weight (item)
		end

	italic: BOOLEAN is
			-- Is current font italic?
		do
			Result := cwel_log_font_get_italic (item) /= 0
		end

	underlined: BOOLEAN is
			-- Is current font underlined?
		do
			Result := cwel_log_font_get_underline (item) /= 0
		end

	strike_out: BOOLEAN is
			-- Is current font striked out?
		do
			Result := cwel_log_font_get_strikeout (item) /= 0
		end

	char_set: INTEGER is
			-- Character set of current font
		do
			Result := cwel_log_font_get_charset (item)
		end

	out_precision: INTEGER is
			-- Output precision of current font.
			-- The output precision defines how closely the output
			-- must match the requested font's height, width,
			-- character orientation, escapement, and pitch.
		do
			Result := cwel_log_font_get_outprecision (item)
		end

	clip_precision: INTEGER is
			-- Clipping precision.
			-- Define how to clip characters that are 
			-- partially outside clipping region.
		do
			Result := cwel_log_font_get_clipprecision (item)
		end

	quality: INTEGER is
			-- Quality of current font.
			-- Specifies the output quality. The output quality 
			-- defines how carefully the graphics device interface 
			-- (GDI) must attempt to match the logical-font 
			-- attributes to those of an actual physical font.
		do
			Result := cwel_log_font_get_quality (item)
		end

	pitch: INTEGER is
			-- Pitch of current font
		do
			Result := cwel_log_font_get_pitch (item)
		end

	family: INTEGER is
			-- Family of current font
		do
			Result := cwel_log_font_get_family (item)
		end

	pitch_and_family: INTEGER is
			-- Pitch and family of current font
		do
			Result := cwel_log_font_get_pitchandfamily (item)
		end

	face_name: STRING is
			-- Face name of current font
		do
			create Result.make_from_c (cwel_log_font_get_facename (item))
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	has_default_character_set: BOOLEAN is
			-- Has current font the default character set?
		do
			Result := char_set = Default_charset
		end

	has_ansi_character_set: BOOLEAN is
			-- Has current font the ansi character set?
		do
			Result := char_set = Ansi_charset
		end

	has_oem_character_set: BOOLEAN is
			-- Has current font the OEM character set?
		do
			Result := char_set = Oem_charset
		end

	has_symbol_character_set: BOOLEAN is
			-- Has current font the symbol character set?
		do
			Result := char_set = Symbol_charset
		end

	has_unicode_character_set: BOOLEAN is
			-- Has current font the unicode character set?
		do
			Result := char_set = Unicode_charset
		end

	has_character_output_precision: BOOLEAN is
			-- Has current font the character output precision?
		do
			Result := out_precision = Out_character_precis
		end

	has_default_output_precision: BOOLEAN is
			-- Has current font the default output precision?
		do
			Result := out_precision = Out_default_precis
		end

	has_string_output_precision: BOOLEAN is
			-- Has current font the string output precision?
		do
			Result := out_precision = Out_string_precis
		end

	has_stroke_output_precision: BOOLEAN is
			-- Has current font the stroke output precision?
		do
			Result := out_precision = Out_stroke_precis
		end

	has_character_clipping_precision: BOOLEAN is
			-- Has current font the character clipping precision?
		do
			Result := clip_precision = Clip_character_precis
		end

	has_default_clipping_precision: BOOLEAN is
			-- Has current font the default clipping precision?
		do
			Result := clip_precision = Clip_default_precis
		end

	has_stroke_clipping_precision: BOOLEAN is
			-- Has current font the stroke clipping precision?
		do
			Result := clip_precision = Clip_stroke_precis
		end

	has_default_quality: BOOLEAN is
			-- Has current font the default quality?
		do
			Result := quality = Default_quality
		end

	has_draft_quality: BOOLEAN is
			-- Has current font the draft quality?
		do
			Result := quality = Draft_quality
		end

	has_proof_quality: BOOLEAN is
			-- Has current font the proof quality?
		do
			Result := quality = Proof_quality
		end

	has_default_pitch: BOOLEAN is
			-- Has current font the default pitch?
		do
			Result := pitch = Default_pitch
		end

	has_fixed_pitch: BOOLEAN is
			-- Has current font the fixed pitch?
		do
			Result := pitch = Fixed_pitch
		end

	has_variable_pitch: BOOLEAN is
			-- Has current font the variable pitch?
		do
			Result := pitch = Variable_pitch
		end

	is_dont_care_family: BOOLEAN is
			-- Is current font in the don t care family?
		do
			Result := family = Ff_dontcare
		end

	is_roman_family: BOOLEAN is
			-- Is current font in the roman family?
		do
			Result := family = Ff_roman
		end

	is_swiss_family: BOOLEAN is
			-- Is current font in the swiss family?
		do
			Result := family = Ff_swiss
		end

	is_modern_family: BOOLEAN is
			-- Is current font in the modern family?
		do
			Result := family = Ff_modern
		end

	is_script_family: BOOLEAN is
			-- Is current font in the script family?
		do
			Result := family = Ff_script
		end

	is_decorative_family: BOOLEAN is
			-- Is current font in the decorative family?
		do
			Result := family = Ff_decorative
		end

feature -- Status setting

	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		do
			cwel_log_font_set_height (item, a_height)
		ensure
			height_set: height = a_height
		end

	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		do
			cwel_log_font_set_width (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_escapement (a_escapement: INTEGER) is
			-- Set `escapement' to `a_escapement'.
		do
			cwel_log_font_set_escapement (item, a_escapement)
		ensure
			escapement_set: escapement = a_escapement
		end

	set_orientation (a_orientation: INTEGER) is
			-- Set `orientation' to `a_orientation'.
		do
			cwel_log_font_set_orientation (item, a_orientation)
		ensure
			orientation_set: orientation = a_orientation
		end

	set_weight (a_weight: INTEGER) is
			-- Set `weight' to `a_weight'.
		do
			cwel_log_font_set_weight (item, a_weight)
		ensure
			weight_set: weight = a_weight
		end

	set_italic is
			-- Set current font italic.
		do
			cwel_log_font_set_italic (item, 1)
		ensure
			italic: italic
		end

	set_not_italic is
			-- Set current font not italic.
		do
			cwel_log_font_set_italic (item, 0)
		ensure
			not_italic: not italic
		end

	set_underlined is
			-- Set current font underlined.
		do
			cwel_log_font_set_underline (item, 1)
		ensure
			underlined: underlined
		end

	set_not_underlined is
			-- Set current font not underlined.
		do
			cwel_log_font_set_underline (item, 0)
		ensure
			not_underlined: not underlined
		end

	set_strike_out is
			-- Set current font striked out.
		do
			cwel_log_font_set_strikeout (item, 1)
		ensure
			strike_out: strike_out
		end

	set_not_strike_out is
			-- Set current font not striked out.
		do
			cwel_log_font_set_strikeout (item, 0)
		ensure
			not_strike_out: not strike_out
		end

	set_char_set (a_char_set: INTEGER) is
			-- Set `char_set' to `a_char_set'.
		do
			cwel_log_font_set_charset (item, a_char_set)
		ensure
			char_set_set: char_set = a_char_set
		end

	set_default_character_set is
			-- Set `char_set' to the default value.
		do
			set_char_set (Default_charset)
		ensure
			has_default_character_set: has_default_character_set
		end

	set_ansi_character_set is
			-- Set `char_set' to ansi.
		do
			set_char_set (Ansi_charset)
		ensure
			has_ansi_character_set: has_ansi_character_set
		end

	set_oem_character_set is
			-- Set `char_set' to OEM.
		do
			set_char_set (Oem_charset)
		ensure
			has_oem_character_set: has_oem_character_set
		end

	set_symbol_character_set is
			-- Set `char_set' to symbol.
		do
			set_char_set (Symbol_charset)
		ensure
			has_symbol_character_set: has_symbol_character_set
		end

	set_unicode_character_set is
			-- Set `char_set' to unicode.
		do
			set_char_set (Unicode_charset)
		ensure
			has_unicode_character_set: has_unicode_character_set
		end

	set_out_precision (a_precision: INTEGER) is
			-- Set `out_precision' to `a_out_precision'.
		do
			cwel_log_font_set_outprecision (item, a_precision)
		ensure
			out_precision_set: out_precision = a_precision
		end

	set_character_output_precision is
			-- Set `out_precision' to character precision.
		do
			set_out_precision (Out_character_precis)
		ensure
			has_character_output_precision:
				has_character_output_precision
		end

	set_default_output_precision is
			-- Set `out_precision' to default output precision.
		do
			set_out_precision (Out_default_precis)
		ensure
			has_default_output_precision:
				has_default_output_precision
		end

	set_string_output_precision is
			-- Set `out_precision' to string output precision.
		do
			set_out_precision (Out_string_precis)
		ensure
			has_string_output_precision:
				has_string_output_precision
		end

	set_stroke_output_precision is
			-- Set `out_precision' to stroke output precision.
		do
			set_out_precision (Out_stroke_precis)
		ensure
			has_stroke_output_precision:
				has_stroke_output_precision
		end

	set_character_clipping_precision is
			-- Set `clip_precision' to character clipping precision.
		do
			set_out_precision (Clip_character_precis)
		ensure
			has_character_clipping_precision:
				has_character_clipping_precision
		end

	set_clip_precision (a_precision: INTEGER) is
			-- Set `clip_precision' to `a_precision'.
		do
			cwel_log_font_set_clipprecision (item, a_precision)
		ensure
			clip_precision_set: clip_precision = a_precision
		end

	set_default_clipping_precision is
			-- Set `clip_precision' to the default value.
		do
			set_clip_precision (Clip_default_precis)
		ensure
			has_default_clipping_precision:
				has_default_clipping_precision
		end

	set_stroke_clipping_precision is
			-- Set `clip_precision' to the storke clipping precision.
		do
			set_clip_precision (Clip_stroke_precis)
		ensure
			has_stroke_clipping_precision:
				has_stroke_clipping_precision
		end

	set_quality (a_quality: INTEGER) is
			-- Set `quality' to `a_quality'.
		do
			cwel_log_font_set_quality (item, a_quality)
		ensure
			quality_set: quality = a_quality
		end

	set_default_quality is
			-- Set `quality' to the default value.
		do
			set_quality (Default_quality)
		ensure
			has_default_quality: has_default_quality
		end

	set_draft_quality is
			-- Set `quality' to the draft quality.
		do
			set_quality (Draft_quality)
		ensure
			has_draft_quality: has_draft_quality
		end

	set_proof_quality is
			-- Set `quality' to the proof quality.
		do
			set_quality (Proof_quality)
		ensure
			has_proof_quality: has_proof_quality
		end

	set_pitch (a_pitch: INTEGER) is
			-- Set `pitch' to `a_pitch'.
		do
			--|------------------------------------------------------------------
			--| FIXME ARNAUD: If bitOperations are available from the compiler
			--|               REPLACE the '+' with an OR
			--|------------------------------------------------------------------
			cwel_log_font_set_pitchandfamily (item, a_pitch + cwel_log_font_get_family (item))
		ensure
			pitch_set: pitch = a_pitch
		end

	set_default_pitch is
			-- Set `pitch' to the default value.
		do
			set_pitch (Default_pitch)
		ensure
			has_default_pitch: has_default_pitch
		end

	set_fixed_pitch is
			-- Set `pitch' to fixed pitch.
		do
			set_pitch (Fixed_pitch)
		ensure
			has_fixed_pitch: has_fixed_pitch
		end

	set_variable_pitch is
			-- Set `pitch' to variable pitch.
		do
			set_pitch (Variable_pitch)
		ensure
			has_variable_pitch: has_variable_pitch
		end

	set_family (a_family: INTEGER) is
			-- Set `family' to `a_family'.
		do
			--|------------------------------------------------------------------
			--| FIXME ARNAUD: If bitOperations are available from the compiler
			--|               REPLACE the '+' with an OR
			--|------------------------------------------------------------------
			cwel_log_font_set_pitchandfamily (item,	cwel_log_font_get_pitch (item) +  a_family)
		ensure
			family_set: family = a_family
		end

	set_dont_care_family is
			-- Set `family' to dont care family.
		do
			set_family (Ff_dontcare)
		ensure
			is_dont_care_family: is_dont_care_family
		end

	set_roman_family is
			-- Set `family' to roman family.
		do
			set_family (Ff_roman)
		ensure
			is_roman_family: is_roman_family
		end

	set_swiss_family is
			-- Set `family' to swiss family.
		do
			set_family (Ff_swiss)
		ensure
			is_swiss_family: is_swiss_family
		end

	set_modern_family is
			-- Set `family' to modern family.
		do
			set_family (Ff_modern)
		ensure
			is_modern_family: is_modern_family
		end

	set_script_family is
			-- Set `family' to script family.
		do
			set_family (Ff_script)
		ensure
			is_script_family: is_script_family
		end

	set_decorative_family is
			-- Set `family' to decorative family.
		do
			set_family (Ff_decorative)
		ensure
			is_decorative_family: is_decorative_family
		end

	set_pitch_and_family (a_pitch_and_family: INTEGER) is
			-- Set `pitch_and_family' with `a_pitch_and_family'.
		do
			cwel_log_font_set_pitchandfamily (item,
				a_pitch_and_family)
		ensure
			pitch_and_family_set: pitch_and_family = a_pitch_and_family
		end

	set_face_name (a_face_name: STRING) is
			-- Set `face_name' to `a_face_name'.
		require
			a_face_name_not_void: a_face_name /= Void
			valid_count: a_face_name.count <= Max_face_name_length
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_face_name)
			cwel_log_font_set_facename (item, a_wel_string.item)
		ensure
			face_name_set: face_name.is_equal (a_face_name)
		end

	Max_face_name_length: INTEGER is
			-- Maximum face name length
		once
			Result := Lf_facesize
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_log_font
		end

feature {NONE} -- Implentation

	mul_div (i,j,k: INTEGER): INTEGER is
			-- Does `i * j / k' but in a safe manner where the 64 bits integer
			-- obtained by `i * j' is not truncated.
		external
			"C [macro <windows.h>] (int, int, int): EIF_INTEGER"
		alias
			"MulDiv"
		end

	get_device_caps (p: POINTER; i: INTEGER): INTEGER is
			-- Retrieves device-specific information about a specified device.
		external
			"C [macro <windows.h>] (HDC, int): EIF_INTEGER"
		alias
			"GetDeviceCaps"
		end

feature {NONE} -- Externals

	c_size_of_log_font: INTEGER is
		external
			"C [macro <logfont.h>]"
		alias
			"sizeof (LOGFONT)"
		end

	cwel_log_font_set_height (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_width (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_escapement (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_orientation (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_weight (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_italic (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_underline (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_strikeout (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_charset (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_outprecision (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_clipprecision (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_quality (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_pitchandfamily (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_set_facename (ptr: POINTER; value: POINTER) is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_height (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_width (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_escapement (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_orientation (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_weight (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_italic (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_underline (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_strikeout (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_charset (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_outprecision (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_clipprecision (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_quality (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_pitchandfamily (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_pitch (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_family (ptr: POINTER): INTEGER is
		external
			"C [macro <logfont.h>]"
		end

	cwel_log_font_get_facename (ptr: POINTER): POINTER is
		external
			"C [macro <logfont.h>]"
		end

	cwin_get_object (hgdi_object: POINTER; buffer_size: INTEGER;
			object: POINTER) is
		external
			"C [macro <wel.h>] (HGDIOBJ, int, LPVOID)"
		alias
			"GetObject"
		end

	Lf_facesize: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LF_FACESIZE"
		end

end -- class WEL_LOG_FONT

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

