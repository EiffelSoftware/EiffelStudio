note
	description: "Eiffel Vision range. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_IMP

inherit
	EV_RANGE_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			Precursor {EV_GAUGE_IMP}
			{GTK}.gtk_scale_set_digits (c_object, 0)
			{GTK}.gtk_scale_set_draw_value (c_object, False)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RANGE note option: stable attribute end;

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

end -- class EV_RANGE_IMP
