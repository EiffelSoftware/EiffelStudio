indexing
	description:
		"Projection to a Printer."
	status: "See notice at end of class"
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRINT_PROJECTOR_I

inherit

	EV_ANY_I
		redefine
			interface
		end

feature -- Basic operations

	project is
			-- Make a standard projection of the world on the device.
		deferred
		end

	draw_grid is
			-- Draw the grid on the canvas.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_PRINT_PROJECTOR

end -- class EV_PRINT_PROJECTOR_I

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
--| Revision 1.2  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.6  2001/04/26 19:13:23  king
--| Made releasable
--|
--| Revision 1.1.2.5  2000/11/20 19:08:48  andrew
--| Removed make_with_filename
--|
--| Revision 1.1.2.4  2000/11/14 22:26:58  king
--| Restructured
--|
--| Revision 1.1.2.3  2000/11/08 22:47:46  andrew
--| implementation/implementation_interface/support/ev_print_projector_i.e
--|
--| Revision 1.1.2.2  2000/11/08 17:58:44  andrew
--| Not for release
--|
--| Revision 1.1.2.1  2000/11/08 17:52:16  andrew
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

