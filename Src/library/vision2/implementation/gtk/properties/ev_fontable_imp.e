indexing
	description: "EiffelVision fontable, gtk implementation.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
deferred class
	EV_FONTABLE_IMP
	
inherit
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end
	
feature -- Access

	font: EV_FONT is
			-- Character appearance for `Current'.
		do
			if private_font = void then
				create Result
				-- Default create is standard gtk font
			else
				Result := clone (private_font)
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		local
			a_style: POINTER
			font_imp: EV_FONT_IMP
		do
			private_font := clone (a_font)
			font_imp ?= private_font.implementation
			a_style := C.gtk_style_copy (C.gtk_widget_struct_style (visual_widget))
			C.set_gtk_style_struct_font (a_style, font_imp.c_object)
			C.gtk_widget_set_style (visual_widget, a_style)
			C.gtk_style_unref (a_style)
		end

feature {NONE} -- Implementation

	private_font: EV_FONT

	interface: EV_FONTABLE

end -- class EV_FONTABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/06/29 22:19:29  king
--| Now setting using private font
--|
--| Revision 1.6  2001/06/07 23:08:04  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.8  2001/06/05 22:43:39  king
--| Using clone instead of copy
--|
--| Revision 1.3.4.7  2001/06/04 17:21:23  rogers
--| We now use copy instead of ev_clone.
--|
--| Revision 1.3.4.6  2000/09/20 17:31:29  oconnor
--| Fixed leaking copied style with an unref.
--| Get the widgets current style then modify it to set the font.
--| Before the default style was used, this hosed any prior style
--| settings.
--|
--| Revision 1.3.4.5  2000/09/06 23:18:41  king
--| Reviewed
--|
--| Revision 1.3.4.4  2000/08/09 20:57:09  oconnor
--| use ev_clone instead of clone as per instructions of manus
--|
--| Revision 1.3.4.3  2000/08/08 20:57:52  king
--| Changed ev_clone calls to clone
--|
--| Revision 1.3.4.2  2000/07/28 00:28:19  king
--| Simplified implementation
--|
--| Revision 1.3.4.1  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.6  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.3.6.5  2000/01/27 19:29:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.4  1999/12/18 02:15:58  king
--| Implemented font and set_font routines
--|
--| Revision 1.3.6.3  1999/12/15 19:25:00  king
--| Removed inheritence from ev_any_imp
--|
--| Revision 1.3.6.2  1999/12/06 17:56:51  brendel
--| Changed so that it only has `font' and `set_font'.
--|
--| Revision 1.3.6.1  1999/11/24 17:29:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
