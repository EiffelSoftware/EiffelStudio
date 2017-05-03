note
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRINT_PROJECTOR_I

obsolete
	"Use EV_MODEL_PRINT_PROJECTOR_I instead. [2017-05-31]"

inherit

	EV_ANY_I
		redefine
			interface
		end

feature -- Basic operations

	project
			-- Make a standard projection of the world on the device.
		deferred
		end

	draw_grid
			-- Draw the grid on the canvas.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PRINT_PROJECTOR note option: stable attribute end;

note
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





