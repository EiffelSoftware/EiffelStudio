indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIELD_TAB

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
				--Commands used by the tab.
		do
		Precursor {ANY_TAB} (Void)
			
		create cmd1.make (agent set_maximum_text_length)
		create cmd2.make (agent get_maximum_text_length)
		create f1.make (Current, 0, 0, "Maximum Text Length", cmd1, cmd2)	

		set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Text Field"
		end

	current_widget: EV_TEXT_FIELD
			-- Current feature we are working on.
	
	f1: TEXT_FEATURE_MODIFIER
		-- A feature for viewing and modifying values.

feature -- Execution Feature

	set_maximum_text_length (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the maximum text length allowed.
		do
			if f1.get_text.is_integer and
			f1.get_text.to_integer>=1 then
				current_widget.set_maximum_text_length (f1.get_text.to_integer)
			end
		end

	get_maximum_text_length (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the maximum text length allowed.
		do
			f1.set_text(current_widget.get_maximum_text_length.out)
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


end -- class TEXT_FIELD_TAB

