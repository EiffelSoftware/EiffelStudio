note
	description: "Contains information about character formatting in a %
		%rich edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_FORMAT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_CFM_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_CFE_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end
		
	WEL_UNIT_CONVERSION
		export
			{NONE} all
		undefine
			copy, is_equal
		end
		
create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
			-- Make a char format structure.
		do
			structure_make
			cwel_charformat_set_cbsize (item, structure_size)
		end

feature -- Access

	char_set: INTEGER
			-- Character set value. Can be one of the values
			-- specified for the `char_set' function of the
			-- WEL_LOG_FONT structure.
		do
			Result := cwel_charformat_get_bcharset (item)
		end

	face_name: STRING_32
			-- Font face name
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer (cwel_charformat_get_szfacename (item))
			Result := l_str.string
		ensure
			result_not_void: Result /= Void
		end

	height: INTEGER
			-- Character height
		obsolete "Use height in twips instead."
		do
			Result := cwel_charformat_get_yheight (item)
		end
		
	height_in_points: INTEGER
			-- Character height in points.
		do
			Result := height_in_twips // 20
		end
		
	height_in_pixels: INTEGER
			-- Character height in pixels
		local
			logical_pixels: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			logical_pixels := get_device_caps (screen_dc.item, logical_pixels_y)
			screen_dc.release
				-- 1440 is twips per inch.
			Result := mul_div (logical_pixels, height_in_twips, 1440)
		end
		
	height_in_twips: INTEGER
			-- Character height in twips.
		do
			Result := cwel_charformat_get_yheight (item)
		end

	offset: INTEGER
			-- Character offset from the baseline. If the value
			-- is positive, the character is a superscript; if it
			-- is negative, the character is a subscript.
		do
			Result := cwel_charformat_get_yoffset (item)
		end

	pitch_and_family: INTEGER
			-- Font pitch and family. This value is the same as
			-- `pitch_and_family' of the WEL_LOG_FONT structure.
		do
			Result := cwel_charformat_get_bpitchandfamily (item)
		end

	text_color: WEL_COLOR_REF
			-- Text color
		do
			create Result.make_by_color (
				cwel_charformat_get_crtextcolor (item))
		ensure
			result_not_void: Result /= Void
		end

	Max_face_name_length: INTEGER
			-- Maximum face name length
		once
			Result := Lf_facesize
		end
		
	log_font: WEL_LOG_FONT
			-- Log font representing `Current'.
		local
			logical_pixels: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			logical_pixels := get_device_caps (screen_dc.item, logical_pixels_y)
			screen_dc.release
				-- 1440 is twips per inch.
			create Result.make (- mul_div (logical_pixels, height_in_twips, 1440), face_name)
			Result.set_pitch_and_family (pitch_and_family)
			if flag_set (effects, Cfm_bold) then
				Result.set_weight (700)
			else
				Result.set_weight (400)
			end
		ensure
			Result_not_void: Result /= Void
		end

	mask: INTEGER
			-- Valid information or attributes to set.
			-- See class WEL_CFM_CONSTANTS for values.
			-- This attribut is automatically set by the
			-- features set_*.
		do
			Result := cwel_charformat_get_dwmask (item)
		end

	effects: INTEGER
			-- Character effects.
			-- See class WEL_CFE_CONSTANTS for values.
		do
			Result := cwel_charformat_get_dweffects (item)
		end

feature -- Element change

	set_default_format
			-- Set Current to default formatting.
		do
			unset_bold
			unset_italic
			unset_strike_out
			unset_underline
		end

	set_char_set (a_char_set: INTEGER)
			-- Set `char_set' with `a_char_set'.
		do
			add_mask (Cfm_charset)
			cwel_charformat_set_bcharset (item, a_char_set)
		ensure
			char_set_set: char_set = a_char_set
		end

	set_face_name (a_face_name: STRING_GENERAL)
			-- Set `face_name' with `a_face_name'.
		require
			a_face_name_not_void: a_face_name /= Void
			valid_count: a_face_name.count <= Max_face_name_length
		local
			a_wel_string: WEL_STRING
		do
			add_mask (Cfm_face)
			create a_wel_string.make_empty (Max_face_name_length + 1)
			a_wel_string.set_string (a_face_name)
			cwel_charformat_set_szfacename (item, a_wel_string.item)
		ensure
			face_name_set: face_name.is_equal (a_face_name)
		end

	set_height (a_height: INTEGER)
			-- Set `height' with `a_height' (height specified in points).
			Obsolete "Use `set_height_in_points' instead"
		do
			add_mask (Cfm_size)
				-- Set `yHeight' with `a_height * 20' since the expected
				-- value is expressed in 1/20 of points.
			cwel_charformat_set_yheight (item, a_height * 20)
		ensure
			height_set: height = a_height * 20
		end

	set_height_in_pixels (a_height: INTEGER)
			-- Set `height_in_pixels' to `a_height' in pixels.
		local
			logical_pixels: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			logical_pixels := get_device_caps (screen_dc.item, logical_pixels_y)
			screen_dc.release
			set_height_in_twips ((a_height * 1440) // logical_pixels)
		ensure
			height_set: height_in_pixels = a_height
		end
		
	set_height_in_points (a_height: INTEGER)
			-- Set `height_in_points' to `a_height' in points.
		do
			set_height_in_twips (a_height * 20)
		ensure
			height_set: height_in_points = a_height
		end
		
	set_height_in_twips (a_height: INTEGER)
			-- Set `height_in_twips' to `a_height' twips.
		do
			add_mask (Cfm_size)
			cwel_charformat_set_yheight (item, a_height)
		ensure
			height_set: height_in_twips = a_height	
		end

	set_offset (an_offset: INTEGER)
			-- Set `offset' with `an_offset'.
		do
			add_mask (Cfm_offset)
			cwel_charformat_set_yoffset (item, an_offset)
		ensure
			offset_set: offset = an_offset
		end

	set_pitch_and_family (a_pitch_and_family: INTEGER)
			-- Set `pitch_and_family' with `a_pitch_and_family'.
		do
			cwel_charformat_set_bpitchandfamily (item,
				a_pitch_and_family)
		ensure
			pitch_and_family_set: pitch_and_family = a_pitch_and_family
		end

	set_text_color (a_color: WEL_COLOR_REF)
			-- Set `text_color' with `a_text_color'.
		do
			add_mask (Cfm_color)
			cwel_charformat_set_crtextcolor (item, a_color.item)
		ensure
			text_color_set: text_color.item = a_color.item
		end

	set_bold
			-- Set bold characters.
		do
			add_mask (Cfm_bold)
			add_effects (Cfe_bold)
		end

	unset_bold
			-- Unset bold characters.
		do
			add_mask (Cfm_bold)
			remove_effects (Cfe_bold)
		end

	set_italic
			-- Set italic characters.
		do
			add_mask (Cfm_italic)
			add_effects (Cfe_italic)
		end

	unset_italic
			-- Unset italic characters.
		do
			add_mask (Cfm_italic)
			remove_effects (Cfe_italic)
		end

	set_strike_out
			-- Set strike out characters.
		do
			add_mask (Cfm_strikeout)
			add_effects (Cfe_strikeout)
		end

	unset_strike_out
			-- Unset strike out characters.
		do
			add_mask (Cfm_strikeout)
			remove_effects (Cfe_strikeout)
		end

	set_underline
			-- Set underline characters.
		do
			add_mask (Cfm_underline)
			add_effects (Cfe_underline)
		end

	unset_underline
			-- Unset underline characters.
		do
			add_mask (Cfm_underline)
			remove_effects (Cfe_underline)
		end

	set_protected
			-- Set protected characters.
		do
			add_mask (Cfm_protected)
			add_effects (Cfe_protected)
		end

	unset_protected
			-- Unset protected characters.
		do
			add_mask (Cfm_protected)
			remove_effects (Cfe_protected)
		end

	set_mask (a_mask: INTEGER)
			-- Set `mask' with `a_mask'.
			-- See class WEL_CFM_CONSTANTS for `a_mask' values.
		do
			cwel_charformat_set_dwmask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

	add_mask (a_mask: INTEGER)
			-- Add `a_mask' to `mask'.
			-- See class WEL_CFM_CONSTANTS for `a_mask' values.
		do
			set_mask (set_flag (mask, a_mask))
		ensure
			has_mask: has_mask (a_mask)
		end

	remove_mask (a_mask: INTEGER)
			-- Remove `a_mask' from `mask'.
			-- See class WEL_CFM_CONSTANTS for `a_mask' values.
		do
			set_mask (clear_flag (mask, a_mask))
		ensure
			has_not_mask: not has_mask (a_mask)
		end

	set_effects (an_effects: INTEGER)
			-- Set `effects' with `an_effects'.
			-- See class WEL_CFE_CONSTANTS for `a_mask' values.
		do
			cwel_charformat_set_dweffects (item, an_effects)
		ensure
			effects_set: effects = an_effects
		end

	add_effects (an_effects: INTEGER)
			-- Add `an_effects' to `effects'.
			-- See class WEL_CFE_CONSTANTS for `a_mask' values.
		do
			set_effects (set_flag (effects, an_effects))
		ensure
			has_effects: has_effects (an_effects)
		end

	remove_effects (an_effects: INTEGER)
			-- Remove `an_effects' from `effects'.
			-- See class WEL_CFE_CONSTANTS for `a_mask' values.
		do
			set_effects (clear_flag (effects, an_effects))
		ensure
			has_not_effects: not has_effects (an_effects)
		end

	set_all_masks
			-- Set `mask' with all possible values.
		do
			set_mask (Cfm_bold + Cfm_color + Cfm_face +
				Cfm_italic + Cfm_offset + Cfm_protected +
				Cfm_size + Cfm_strikeout + Cfm_underline +
				Cfm_charset)
		end

feature -- Status report

	has_mask (a_mask: INTEGER): BOOLEAN
			-- Is `a_mask' set in `mask'?
			-- See class WEL_CFM_CONSTANTS for `a_mask' values.
		do
			Result := flag_set (mask, a_mask)
		end

	has_effects (an_effects: INTEGER): BOOLEAN
			-- Is `an_effects' set in `effects'?
			-- See class WEL_CFE_CONSTANTS for `an_effects' values.
		do
			Result := flag_set (effects, an_effects)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_charformat
		end

feature {NONE} -- Externals

	c_size_of_charformat: INTEGER
		external
			"C [macro <charfmt.h>]"
		alias
			"sizeof (CHARFORMAT)"
		end

	cwel_charformat_set_cbsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_dwmask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_dweffects (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_yheight (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_yoffset (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_crtextcolor (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_bcharset (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_bpitchandfamily (ptr: POINTER; value: INTEGER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_set_szfacename (ptr: POINTER; value: POINTER)
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_dwmask (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_dweffects (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_yheight (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_yoffset (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_crtextcolor (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_bcharset (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_bpitchandfamily (ptr: POINTER): INTEGER
		external
			"C [macro <charfmt.h>]"
		end

	cwel_charformat_get_szfacename (ptr: POINTER): POINTER
		external
			"C [macro <charfmt.h>] (CHARFORMAT*): EIF_POINTER"
		end

	Lf_facesize: INTEGER
		external
			"C [macro <wel.h>]"
		alias
			"LF_FACESIZE"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
