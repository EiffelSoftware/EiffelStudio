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

