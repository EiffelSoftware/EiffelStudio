indexing
	description:
		"[
			MsWindows Implementation  of Character format containing color,
			font and effects information for text formatting.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I
	
	WEL_CHARACTER_FORMAT
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
			set_effects as wel_set_effects
		undefine
			default_create, copy, is_equal
		end
		
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end
		
	EV_FONT_CONSTANTS
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			--
		do
			base_make (an_interface)
			wel_make
			set_default_format
		end
		
	initialize is
			-- Initialize `Current'.
		do
			is_initialized := True
		end

feature -- Access

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
		
	color: EV_COLOR is
			-- Color of the current format.
		do
			if color_imp /= Void then
				Result ?= color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).black
			end
		end
		
	font: EV_FONT is
			-- Font of the current format.
		local
			a_font_imp: EV_FONT_IMP
		do
			if font_imp /= Void then
				Result := font_imp.interface
			else
				create Result
				a_font_imp ?= Result.implementation
				a_font_imp.set_by_wel_font ((create {WEL_SHARED_FONTS}).gui_font)
			end
		end
		
	effects: EV_CHARACTER_FORMAT_EFFECTS is
			-- Character format effects applicable to `font'.
		do
			if internal_effects /= Void then
				Result := internal_effects.twin
			else
				create Result
			end
		end

	font_imp: EV_FONT_IMP
		-- Font of `Current'. Void if not set by user.
		
	color_imp: EV_COLOR_IMP
		-- Color applied to characters. Void if None.
		
	internal_effects: EV_CHARACTER_FORMAT_EFFECTS
		-- Internal effects applicable to `Current'.

feature -- Status setting
		
	set_font (a_font: EV_FONT) is
			-- Make `value' the new font.
		do
			font_imp ?= a_font.implementation
			if font_imp.internal_face_name /= Void then
				set_face_name (font_imp.internal_face_name)
			end
			set_pitch_and_family (font_imp.wel_log_font.pitch_and_family)
			set_height_in_pixels (font_imp.height)
			set_char_set (font_imp.wel_log_font.char_set)			
			if font_imp.wel_font.log_font.weight >= 700 then
				enable_bold
			else
				disable_bold
			end
			if font_imp.shape = shape_italic then
				enable_italic
			else
				disable_italic
			end
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color.
		do
			color_imp ?= a_color.implementation
			set_text_color (color_imp)
		end
		
	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'.
		do
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
			internal_effects := an_effect.twin
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
		end

end -- class EV_CHARACTER_FORMAT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

