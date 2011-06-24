note
	description: "Eiffel Vision vertical progress bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			Precursor {EV_PROGRESS_BAR_IMP}
			{GTK}.gtk_progress_bar_set_orientation (gtk_progress_bar, gtk_progress_bottom_to_top_enum)
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_bottom_to_top_enum: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_PROGRESS_BOTTOM_TO_TOP"
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_PROGRESS_BAR note option: stable attribute end;

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

end -- class EV_VERTICAL_PROGRESS_BAR_IMP
