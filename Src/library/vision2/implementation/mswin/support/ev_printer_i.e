indexing 
	description: "EiffelVision printer. Implementation interface."
	status: "See notice at end of class"
	keywords: "printer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRINTER_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature -- Status setting

	set_printer_dc (a_dc: WEL_PRINTER_DC) is
			-- Set `printer_dc' to `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		deferred
		end

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.
		deferred
		ensure
			positive: Result > 0
		end

	height: INTEGER is
			-- Vertical size in pixels.
		deferred
		ensure
			positive: Result > 0
		end

feature -- Status setting

	start_document is
		deferred
		end

	end_document is
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_PRINTER

end -- class EV_PRINTER_I

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
--| Revision 1.2  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.2  2000/12/13 23:31:18  king
--| Added deferred gc init routines
--|
--| Revision 1.1.2.1  2000/11/21 17:52:19  andrew
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

