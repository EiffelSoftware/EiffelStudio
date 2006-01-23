indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMBO_TAB

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
			-- Create the tab and initialise objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			Precursor {ANY_TAB} (Void)
				
				-- Creates the objects and their commands
			create cmd1.make (agent set_extended_height)
			create cmd2.make (agent get_extended_height)
			create f1.make(Current, 0, 0,"Extended Height", cmd1, cmd2)
			set_parent(par)
		end


	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Combo"
		end

	set_extended_height (arg:EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the level of the progress bar
		do
			current_widget.set_extended_height(f1.get_text.to_integer)
		end

	get_extended_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the level of the progress bar
		do
			f1.set_text(current_widget.extended_height.out)
		end

	current_widget: EV_COMBO_BOX

	f1: TEXT_FEATURE_MODIFIER;

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


end -- class COMBO_TAB

