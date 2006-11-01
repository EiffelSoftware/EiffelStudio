indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPLIT_AREA_TAB

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
			cmd1, cmd2: EV_ROUTINE_COMMAND
		do
			Precursor {ANY_TAB} (Void)
		
				-- Creates the objects and their commands
			create cmd1.make (agent set_split_position)
			create cmd2.make (agent get_split_position)
			create f1.make (Current, 0, 0, "Split Position", cmd1, cmd2)
--			create cmd1.make (~set_minimum_position)
--			create cmd2.make (~get_minimum_position)
--			create f2.make (Current, "Minimum Position", Void, cmd2)
--			create cmd1.make (~set_maximum_position)
--			create cmd2.make (~get_maximum_position)
--			create f3.make (Current, "Maximum Position", Void, cmd2)
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Split Area"
		end

	current_widget: EV_SPLIT_AREA
			-- Current widget we are working on.

	f1, f2, f3: TEXT_FEATURE_MODIFIER	
			-- Some modifiers.

feature -- Execution feature  

	set_split_position (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the position of the split in the demo
		do
			if f1.get_text.is_integer then
				current_widget.set_position(f1.get_text.to_integer)
			end
		end

	get_split_position (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the position of the split in the demo
		do
			f1.set_text(current_widget.position.out)
		end

	get_minimum_position (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the minimum position of the split in the demo
		do
			--f2.set_text(current_widget.minimum_position.out)
		end

	get_maximum_position (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the maximum position of the split in the demo
		do
			--f3.set_text(current_widget.maximum_position.out)
		end
	
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


end -- class SPLIT_AREA_TAB



