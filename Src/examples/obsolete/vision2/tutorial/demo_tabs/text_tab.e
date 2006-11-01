indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_TAB

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
			cmd1,cmd2: EV_ROUTINE_COMMAND
				-- Commands used by the tab.
			h1: EV_HORIZONTAL_SEPARATOR
			
		do
		Precursor {ANY_TAB} (Void)

		create cmd1.make (agent search)
		create f1.make (Current, 0, 0, "Find Text", cmd1, cmd1)
		create cmd1.make (agent put_new_line)
		create h1.make (Current)
		set_child_position (h1, 1, 0, 2, 3)
		create b1.make_with_text (Current, "Put New Line")
		b1.set_vertical_resize (False)
		b1.add_click_command (cmd1, Void)
		set_child_position (b1, 2, 1, 3, 2)

		set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Text"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_TEXT
		-- The current demo.

	f1: TEXT_FEATURE_MODIFIER
		--  A feature modifier for the action window.

	b1: EV_BUTTON
		-- A button for the action window.

feature -- Execution Feature

	search (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Search for the text. Return the position
			-- of the text if found, otherwise returns void.
		local
			search_result: INTEGER
		do
			if f1.get_text.count>0 then
				search_result := current_widget.search (f1.get_text, 1)
				if search_result < 0 then
					f1.set_text ("Void - No match was found")
				else
					f1.set_text (search_result.out)
				end
			end
		end

	put_new_line (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Go to the beginning of the following line.
		do
			current_widget.put_new_line
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


end -- class TEXT_TAB

