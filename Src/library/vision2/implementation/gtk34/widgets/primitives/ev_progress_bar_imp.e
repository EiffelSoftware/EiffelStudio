note
	description: "Eiffel Vision Progress bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make, value_changed_handler
		end

feature {NONE} -- Implementation

	make
			-- Create and initialize `Current'
		do
			set_c_object ({GTK}.gtk_progress_bar_new)
			gtk_progress_bar := c_object
			enable_segmentation
			Precursor
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display segmented?

feature -- Status setting

	enable_segmentation
			-- Display bar divided into segments.
		do
			is_segmented := True
		end

	disable_segmentation
			-- Display bar without segments.
		do
			is_segmented := False
		end

feature {EV_INTERMEDIARY_ROUTINES}

	value_changed_handler
			-- <Precursor>
		do
			{GTK}.gtk_progress_bar_set_fraction (gtk_progress_bar, proportion)
			Precursor
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_bar: POINTER

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PROGRESS_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PROGRESS_BAR_IMP
