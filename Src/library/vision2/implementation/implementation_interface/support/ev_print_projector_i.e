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

