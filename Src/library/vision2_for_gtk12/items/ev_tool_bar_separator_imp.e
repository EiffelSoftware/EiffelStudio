indexing
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create implementation for `an_interface'
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_vseparator_new)
		end
	
	initialize is
			-- Initialize some stuff useless to separators.
		do
			Precursor {EV_ITEM_IMP}
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, 10, -1)
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR;

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




end -- class EV_TOOL_BAR_SEPARATOR_I

