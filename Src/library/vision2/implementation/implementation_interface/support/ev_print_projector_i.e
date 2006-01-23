indexing
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	interface: EV_PRINT_PROJECTOR;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_PROJECTOR_I

