indexing
	description:
		"EiffelVision horizontal separator, gtk implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
				-- Create a horizontal gtk separator.
		local
			p: POINTER
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
			p := {EV_GTK_EXTERNALS}.gtk_hseparator_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (p)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, p)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, -1, 1)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SEPARATOR;

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




end -- class EV_HORIZONTAL_SEPARATOR_IMP

