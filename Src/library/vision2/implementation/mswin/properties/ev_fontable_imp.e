--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			-- font of current primitive
		local
			font_windows: EV_FONT_IMP
			default_font: WEL_FONT
		do
			if private_font = Void then
				create private_font
			end
			Result := private_font	
		end
	
feature -- Status setting

	set_font (ft: EV_FONT) is
			-- Make `ft' the new font.
		local
			local_font_windows: EV_FONT_IMP
		do
			private_font := ft
			local_font_windows ?= private_font.implementation
			check
				valid_font: local_font_windows /= Void
			end
			wel_set_font (local_font_windows.wel_font)
		end

	private_font: EV_FONT
			-- font used for the implementation

feature {NONE} -- Implementation : the wel values, are deferred here, but
			   -- they need to be define by the heir

	wel_font: WEL_FONT is
			-- The wel_font
		deferred
		end

	wel_set_font (a_font: WEL_FONT) is
			-- Make `a_font' the new font of the widget.
		deferred
		end

end -- class EV_FONTABLE_IMP

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
