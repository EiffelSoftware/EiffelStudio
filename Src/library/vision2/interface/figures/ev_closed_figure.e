indexing
	description: "Closed figures like ellipse and polygon.%
		%May be filled with a color."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CLOSED_FIGURE

inherit
	EV_ATOMIC_FIGURE

feature -- Access

	fill_color: EV_COLOR
			-- The background color of the figure.
			-- If it is Void do not fill the figure.

	fill_style: INTEGER
			-- There is something like fill-style too...
			--| FIXME To be implemented

feature -- Status report

	is_filled: BOOLEAN is
			-- Is this figure filled with a color?
		do
			Result := fill_color /= Void
		end

feature -- Status setting

	set_fill_color (color: EV_COLOR) is
			-- Set fill-color to `color'.
		require
			color_exists: color /= Void
		do
			fill_color := color
		end

	remove_fill_color is
			-- Do not fill this figure.
		do
			fill_color := Void
		end

end -- class EV_CLOSED_FIGURE

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:46  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.4.3.2.3  2000/01/28 22:32:33  brendel
--| Removed "Not for release".
--|
--| Revision 1.2.4.3.2.2  2000/01/27 19:30:33  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.4.3.2.1  1999/11/24 17:30:37  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
