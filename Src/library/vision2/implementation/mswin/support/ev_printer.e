indexing 
	description:
		"Facilities for direct drawing to a printer."
	status: "See notice at end of class"
	keywords: "printer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINTER

inherit
	EV_DRAWABLE
		redefine
			implementation,
			create_implementation
		end

create {EV_PRINT_PROJECTOR_IMP}
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_dc: WEL_PRINTER_DC) is
			-- Set `printer_dc' to `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		do
			-- default_create not being called as initialization relies on `a_dc'.
			default_create_called := True
			create_implementation
			implementation.set_printer_dc (a_dc)
			implementation.initialize
			initialize
		end

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PRINTER_IMP} implementation.make (Current)
		end

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		ensure then
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure then
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end

feature -- Status setting

	start_document is
		do
			implementation.start_document
		end

	end_document is
		do
			implementation.end_document
		end
	
feature {EV_ANY_I} -- Implementation

	implementation: EV_PRINTER_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_PRINTER

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.3  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.2  2000/12/13 23:30:36  king
--| Added dc initialization routines
--|
--| Revision 1.1.2.1  2000/11/21 17:48:20  andrew
--| Initial
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

