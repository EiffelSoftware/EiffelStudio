indexing
	description:"EiffelVision fontable, mswindows implementation."
	note : "When a heir of this class inherits from a WEL object,%
			% it needs to rename `font' as `wel_font' and%
			% `set_font' as `wel_set_font'"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I

feature -- Access

	font: EV_FONT is
			-- Font of `Current'.
		local
			font_imp: EV_FONT_IMP
		do
			if private_font = Void then
				create Result
				font_imp ?= Result.implementation
				font_imp.set_by_wel_font (clone (private_wel_font))
				private_font := Result
				private_wel_font := Void
			else
				Result := private_font	
			end
		end
	
feature -- Status setting

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		local
			local_font_windows: EV_FONT_IMP
		do
			private_font := ft
			local_font_windows ?= private_font.implementation
			check
				valid_font: local_font_windows /= Void
			end
			wel_set_font (local_font_windows.wel_font)

				-- We don't need the WEL private font anymore since it is set by user.
			private_wel_font := Void
		end

	set_default_font is
			-- Make system to use default font.
		do
			private_wel_font := wel_default_font
			wel_set_font (wel_default_font)
		end

feature {EV_ANY_I} -- Implementation

	private_font: EV_FONT
			-- font used for implementation

	private_wel_font: WEL_FONT
			-- WEL font used for implementation

feature {NONE} -- Implementation : The wel values, are deferred here, but
			   -- they need to be defined by their heirs.

	wel_default_font: WEL_FONT is
			-- Default font of system.
		once
			Result := (create {WEL_SHARED_FONTS}).gui_font
		end

	wel_font: WEL_FONT is
			-- The wel_font
		deferred
		end

	wel_set_font (a_font: WEL_FONT) is
			-- Make `a_font' the new font of the widget.
		deferred
		end

end -- class EV_FONTABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.12  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.8.9  2000/12/13 08:39:07  pichery
--| Reverted back to version 1.7.8.6
--|
--| Revision 1.7.8.6  2000/10/31 18:51:15  manus
--| Fixed a problem when invariant are turned on. Do a clone of the WEL object before passing
--| it around.
--|
--| Revision 1.7.8.5  2000/10/28 01:14:27  manus
--| New implementation which minimizes the creation of EV_FONT object when not needed.
--| In EiffelBench it saved us about 100 GDI objects alltogether.
--|
--| Revision 1.7.8.4  2000/09/13 15:43:41  manus
--| Cosmetics on `the' in comments.
--| Added `set_default_font' which will set font to a shared version of the WEL_DEFAULT_GUI_FONT
--| in order to reduce GDI resources consumption. This can be called only during initialization or
--| before the user makes a call to `set_font'.
--|
--| Revision 1.7.8.3  2000/08/11 19:13:36  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.7.8.2  2000/05/30 16:16:34  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.7.8.1  2000/05/03 19:09:16  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/04/05 19:26:57  rogers
--| Review work. Comments, formatting.
--|
--| Revision 1.9  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.8  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.10.6  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.10.5  2000/01/19 23:44:24  rogers
--| Removed redundent code in font, when the private_font is void.
--|
--| Revision 1.7.10.4  2000/01/19 22:00:27  king
--| Added function `set_by_wel_font'.
--| This does not set the variables of EV_FONT!
--|
--| Revision 1.7.10.3  2000/01/10 19:19:59  king
--| Commented out make_with_wel.
--|
--| Revision 1.7.10.2  1999/12/17 17:19:03  rogers
--| Altered to fit in with the review branch. create replaces a !!.
--|
--| Revision 1.7.10.1  1999/11/24 17:30:19  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.6.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
