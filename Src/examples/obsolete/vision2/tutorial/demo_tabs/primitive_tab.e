indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	
PRIMITIVE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end


create
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			l1: EV_LABEL
		do
			Precursor {ANY_TAB} (par)
				-- Creates the objects and their commands
			create l1.make_with_text(Current,"EV_PRIMITIVE is a deferred class and therefore,%N there are no features that can be modified.")
			set_child_position (l1, 0, 0, 1, 1)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Primitive"
		end

	current_widget: EV_PRIMITIVE;
			-- Current widget we are working on.

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


end -- class BOX_TAB


