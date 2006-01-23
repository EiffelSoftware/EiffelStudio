indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

create
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
		-- Create the tab and initalise the objects.
			local
				l1: EV_LABEL			
			do
				Precursor {ANY_TAB} (Void)
					-- Creates the objects and their commands.
				create l1.make_with_text(Current,"EV_TOOLBAR has no new features which are%N interactive in this demo.")
			set_child_position (l1, 0, 0, 1, 1)
			set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Tool Bar"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_LIST;
		-- The current demo.

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


end -- class TOOL_BAR_TAB

