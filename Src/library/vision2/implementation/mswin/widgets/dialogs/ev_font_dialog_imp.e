--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision font selection dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I

	EV_SELECTION_DIALOG_IMP

	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		end

creation
	make

feature -- Access
	
	font: EV_FONT is
			-- Current selected font.
		local
			font_imp: EV_FONT_IMP
			wel_font: WEL_FONT
			ev_font_imp: EV_FONT_IMP
		do
			create wel_font.make_indirect (log_font)	
			create Result.make
			create ev_font_imp.make_with_wel (wel_font)
			Result.set_implementation (ev_font_imp)
		end

	character_format: EV_CHARACTER_FORMAT is
			-- Current selected format.
		local
			col: EV_COLOR
		do
			create Result.make
			Result.set_font (font)
			create col.make_rgb (color.red, color.green, color.blue)
			Result.set_color (col)
			if log_font.weight <= 550 then
				-- 400 signifies standard.
				-- 700 signifies bold.
				-- 550 is half way between the two.
				Result.set_bold (False)
			else
				Result.set_bold (True)
			end
			Result.set_italic (log_font.italic)
		end

feature -- Element change

	select_font (a_font: EV_FONT) is
			-- Select `a_font'.
		local
			font_imp: EV_FONT_IMP
			wel_font: WEL_LOG_FONT
		do
			font_imp ?= a_font.implementation
			wel_font := font_imp.wel_log_font
			set_log_font (wel_font)
		end

end -- class EV_FONT_DIALOG_IMP

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
--| Revision 1.8  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.2  2000/01/27 19:30:18  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
