--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision character format, winodws implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I

	WEL_CHARACTER_FORMAT
		rename
			set_bold as wel_set_bold,
			set_italic as wel_set_italic,
			set_underline as wel_set_underline
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_CFM_CONSTANTS
		export
			{NONE} all
		end

	WEL_CFE_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	font: EV_FONT is
			-- Font of the current format
		local
			wel_log_font: WEL_LOG_FONT
			wel_font: WEL_FONT
			imp: EV_FONT_IMP
		do
			create wel_log_font.make (height, face_name)
			create wel_font.make_indirect (wel_log_font)
			create imp.make_with_wel (wel_font)
			create Result.make
			Result.set_implementation (imp)
		end
	

	color: EV_COLOR is
			-- Color of the current format
		local
			imp: EV_COLOR_IMP
		do
			create Result.make_rgb (text_color.red, text_color.green, text_color.blue)
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not exists
		end

	is_bold: BOOLEAN is
			-- Is the character bold?
		do
			Result := flag_set (effects, Cfe_bold)
		end

	is_italic: BOOLEAN is
			-- Is the character in italic?
		do
			Result := flag_set (effects, Cfe_italic)
		end

	is_underline: BOOLEAN is
			-- Is the character underline?
		do
			Result := flag_set (effects, Cfe_underline)
		end

feature -- Status setting

	destroy is
			-- destroy the current item
		do
			destroy_item
		end

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		do
			if flag then
				wel_set_bold
			else
				unset_bold
			end
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		do
			if flag then
				wel_set_italic
			else
				unset_italic
			end
		end

	set_underline (flag: BOOLEAN) is
			-- Set underline characters if `flag', unset otherwise.
		do
			if flag then
				wel_set_underline
			else
				unset_underline
			end
		end

feature -- Element change

	set_font (value: EV_FONT) is
			-- Make `value' the new font.
		local
			imp: EV_FONT_IMP
		do
			imp ?= value.implementation
			set_face_name (imp.wel_log_font.face_name)
			set_height (imp.wel_log_font.height)
			set_char_set (imp.wel_log_font.char_set)
		end


	set_color (value: EV_COLOR) is
			-- Make `value' the new color.
		local
			wel: WEL_COLOR_REF
		do
			create wel.make_rgb (value.red, value.green, value.blue)
			set_text_color (wel)
		end

end -- class EV_CHARACTER_FORMAT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:30:10  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
