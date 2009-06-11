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
			old_make,
			make
		end

feature {NONE} -- Implementation

	old_make (an_interface: like interface)
			-- Create the progress bar.
		do
			Precursor {EV_GAUGE_IMP} (an_interface)
		end

	make
			-- Create and initialize `Current'
		do
			set_c_object ({EV_GTK_EXTERNALS}.gtk_progress_bar_new_with_adjustment (adjustment))
			gtk_progress_bar := c_object
			enable_segmentation
			Precursor
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display segmented?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_progress_bar_struct_bar_style (gtk_progress_bar) =
				gtk_progress_discrete_enum
		end

feature -- Status setting

	enable_segmentation
			-- Display bar divided into segments.
		do
			{EV_GTK_EXTERNALS}.gtk_progress_bar_set_bar_style (
				gtk_progress_bar,
				gtk_progress_discrete_enum
			)
		end

	disable_segmentation
			-- Display bar without segments.
		do
			{EV_GTK_EXTERNALS}.gtk_progress_bar_set_bar_style (
				gtk_progress_bar,
			 	gtk_progress_continuous_enum
			)
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_discrete_enum: INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_PROGRESS_DISCRETE"
		end

	gtk_progress_continuous_enum: INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_PROGRESS_CONTINUOUS"
		end

	gtk_progress_bar: POINTER

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PROGRESS_BAR note option: stable attribute end;

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

end -- class EV_PROGRESS_BAR_IMP
