note
	description: "EiffelV ision horizontal progress bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_PROGRESS_BAR_IMP

inherit
	EV_HORIZONTAL_PROGRESS_BAR_I
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
			{EV_GTK_EXTERNALS}.gtk_progress_bar_set_orientation (gtk_progress_bar, gtk_progress_left_to_right_enum)
			set_minimum_height (16)
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_left_to_right_enum: INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_PROGRESS_LEFT_TO_RIGHT"
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_PROGRESS_BAR note option: stable attribute end;

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

end -- class EV_HORIZONTAL_PROGRESS_BAR_IMP
