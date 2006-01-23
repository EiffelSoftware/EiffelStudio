indexing
	description: "Eiffel Vision dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP
	
inherit
	EV_DIALOG_IMP
		redefine
			interface,
			set_size,
			has_wm_decorations,
			initialize
		end

create
	make

feature {NONE} -- Initialization
		
	initialize is
			-- Initialize `Current'
		do
			Precursor {EV_DIALOG_IMP}
			{EV_GTK_EXTERNALS}.gdk_window_set_decorations ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), 0)
				-- We don't want any decorations at all
		end

feature -- Status setting	
		
	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			Precursor {EV_DIALOG_IMP} (a_width, a_height)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, default_width.max (minimum_width), default_height.max (minimum_height))
		end

feature {NONE} -- Implementation

	has_wm_decorations: BOOLEAN is
			-- Does the current window object have window decorations.
		do
			Result := False
		end

	interface: EV_UNTITLED_DIALOG;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_DIALOG_IMP

