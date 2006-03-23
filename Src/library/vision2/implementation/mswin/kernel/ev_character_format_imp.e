indexing
	description:
		"[
			MsWindows Implementation  of Character format containing color,
			font and effects information for text formatting.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I

	WEL_CHARACTER_FORMAT2
		rename
			make as wel_make,
			initialize as wel_initialize,
			set_bold as enable_bold,
			set_italic as enable_italic,
			set_underline as enable_underlined,
			set_strike_out as enable_striked_out,
			unset_bold as disable_bold,
			unset_italic as disable_italic,
			unset_underline as disable_underlined,
			unset_strike_out as disable_striked_out,
			effects as wel_effects,
			set_effects as wel_set_effects,
			set_background_color as wel_set_background_color,
			background_color as wel_background_color,
			height as wel_height
		undefine
			default_create, copy, is_equal, out
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			out
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		undefine
			out
		end

	WEL_FONT_FAMILY_CONSTANTS
		export
			{NONE} all
		undefine
			out
		end

	WEL_FONT_PITCH_CONSTANTS
		export
			{NONE} all
		undefine
			out
		end

	WEL_SHARED_FONTS
		export
			{NONE} all
		undefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' and assign `an_interface' to `interface'.
		local
			l_font: WEL_LOG_FONT
		do
			base_make (an_interface)
			wel_make
			set_default_format
			set_text_color (create {WEL_COLOR_REF}.make_rgb (0, 0, 0))
			wel_set_background_color (create {WEL_COLOR_REF}.make_rgb (255, 255, 255))
				-- Retreive default font into `log_font' to ensure  `wel_screen_font_family'
				-- is set correctly.
			l_font := default_wel_log_font
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Access

	color: EV_COLOR is
			-- Color of the current format.
		local
			color_ref: WEL_COLOR_REF
		do
			color_ref := text_color
			create Result.make_with_8_bit_rgb (color_ref.red, color_ref.green, color_ref.blue)
		end

	background_color: EV_COLOR is
			-- Background color of the current format.
		local
			color_ref: WEL_COLOR_REF
		do
			color_ref := wel_background_color
			create Result.make_with_8_bit_rgb (color_ref.red, color_ref.green, color_ref.blue)
		end

	font: EV_FONT is
			-- Font of the current format.
		local
			font_imp: EV_FONT_IMP
			a_wel_font: WEL_FONT
		do
			create Result
			font_imp ?= Result.implementation
			create a_wel_font.make_indirect (log_font)
			font_imp.set_by_wel_font (a_wel_font)

			if shape = shape_italic then
				font_imp.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
			end
			if is_bold then
				font_imp.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			end
		end

	effects: EV_CHARACTER_FORMAT_EFFECTS is
			-- Character format effects applicable to `font'.
		local
			effects_flag: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			create Result
			effects_flag := wel_effects
			if flag_set (effects_flag, cfm_strikeout) then
				Result.enable_striked_out
			end
			if flag_set (effects_flag, Cfm_underline) then
				Result.enable_underlined
			end
			Result.set_vertical_offset (vertical_offset)
			screen_dc.release
		end

feature -- Status setting

	set_font (a_font: EV_FONT) is
			-- Make `value' the new font.
		local
			font_imp: EV_FONT_IMP
			l_log_font: WEL_LOG_FONT
		do
			font_imp ?= a_font.implementation
			if font_imp.internal_face_name /= Void then
				set_face_name (font_imp.internal_face_name)
			end

				-- It is important to note the the following code will not work here:
				--
				--			set_pitch_and_family (font_imp.wel_log_font.pitch_and_family)
				--
				-- This is because `wel_log_font' is defined as a once in EV_FONT_IMP and therefore
				-- may not be in snych with the current settings of a paticular font.
				-- `wel_log_font' is used as a temporary go between when modifying a font
				-- and its properties including `wel_font'.
				-- Therefore, we must query the `log_font' from `wel_font' directly to ensure
				-- that it is the correct version. Julian.
			l_log_font := font_imp.wel_font.log_font
			set_pitch_and_family (l_log_font.pitch_and_family)

			set_height_in_points (font_imp.height_in_points)
			set_char_set (l_log_font.char_set)
			if l_log_font.weight >= 700 then
				enable_bold
			else
				disable_bold
			end
			if font_imp.shape = shape_italic then
				enable_italic
			else
				disable_italic
			end
				-- Now dispose of the temporary log font as
				-- querying it creates a new one each time.
			l_log_font.dispose
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color.
		local
			color_imp: EV_COLOR_IMP
		do
			color_imp ?= a_color.implementation
			set_text_color (color_imp)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Make `value' the new background color.
		local
			color_imp: EV_COLOR_IMP
		do
			color_imp ?= a_color.implementation
			wel_set_background_color (color_imp)
			bcolor_set := True
		end

	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get

			if an_effect.is_underlined then
				enable_underlined
			else
				disable_underlined
			end
			if an_effect.is_striked_out then
				enable_striked_out
			else
				disable_striked_out
			end
			set_offset (pixel_to_point (screen_dc, an_effect.vertical_offset * 20))

			screen_dc.release
		end

feature {EV_RICH_TEXT_BUFFERING_STRUCTURES_I} -- Implementation

	name: STRING_32 is
			-- Face name used by `Current'.
		do
			Result := face_name
		end

	family: INTEGER is
			-- Family used by `Current'.
		local
			l_font: WEL_LOG_FONT
			l_family: INTEGER
			l_pitch: INTEGER
		do
			l_font := log_font
			l_family := l_font.family
			l_pitch := l_font.pitch
			if l_family = wel_screen_font_family then
				Result := family_screen
			elseif l_family = ff_roman then
				Result := family_roman
			elseif l_family = ff_swiss then
				Result := family_sans
			elseif l_family = ff_modern then
				if l_pitch = variable_pitch then
					Result := family_modern
				else
					Result := family_typewriter
				end
			else
				Result := family_sans
			end
		end

	wel_screen_font_family: INTEGER
		-- Font family of the wel screen font.

	Default_wel_log_font: WEL_LOG_FONT is
			-- Structure used to initialize fonts.
		once
			create Result.make_by_font (gui_font)

				-- set the WEL family associated to Vision2 Screen fonts.
			wel_screen_font_family := Result.family
		end

	italic: BOOLEAN is
			-- Is `Current' italic?
		do
			Result := flag_set (wel_effects, cfm_italic)
		end

	is_bold: BOOLEAN is
			-- Is `Current' bold?
		do
			Result := flag_set (wel_effects, cfm_bold)
		end

	shape: INTEGER is
			-- Shape of `Current'.
		do
			if flag_set (wel_effects, cfm_italic) then
				Result := shape_italic
			else
				Result := shape_regular
			end
		end

	vertical_offset: INTEGER is
			-- Vertical offset of `Current' in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			Result := point_to_pixel (screen_dc, offset, 20)
			screen_dc.release
		end

	height: INTEGER is
			--  Height of `Current'.
		do
			Result := height_in_pixels
		end

	fcolor: INTEGER is
			-- foreground color RGB packed into 24 bit.
			-- Blue is the high part of the 24bits, with each color taking 8 bytes.
			-- Blue, Green, Red
		do
			Result := text_color.item
		end

	bcolor: INTEGER is
			-- background color RGB packed into 24 bit.
			-- Blue is the high part of the 24bits, with each color taking 8 bytes.
			-- Blue, Green, Red
		do
			Result := wel_background_color.item
		end

	is_striked_out: BOOLEAN is
			-- Is the character striked out?
		do
			Result := flag_set (wel_effects, Cfm_strikeout)
		end

	is_underlined: BOOLEAN is
			-- Is the character underlined?
		do
			Result := flag_set (wel_effects, Cfm_underline)
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CHARACTER_FORMAT_IMP

