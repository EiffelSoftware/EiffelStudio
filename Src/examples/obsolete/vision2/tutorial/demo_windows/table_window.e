indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TABLE_WINDOW

inherit
	EV_TABLE
		redefine
			make
		end
	DEMO_WINDOW
	WIDGET_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- First, we put a Void parent because it is faster
		do
			Precursor {EV_TABLE} (Void)
			
			create button.make_with_text (Current, "OK")
			set_child_position (button, 0, 0, 1, 1)
			create button.make_with_text (Current, "KO")
			set_child_position (button, 1, 0, 3, 1)
			create note.make (Current)
			create button.make_with_text (note, "Press me")
			note.append_page (button, "Page 1")
			create button.make_with_text (note, "Me too")
			note.append_page (button, "Page 2")
			set_child_position (note, 1, 1, 3, 5)
			create text.make (Current)
			set_child_position (text, 0, 1, 1, 5)

			set_homogeneous (false)
			set_row_spacing (5)
			set_column_spacing (5)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "table")
			create button_list.make
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			tab_list.extend(table_tab)
			create action_window.make(Current,tab_list)
		end
	
feature -- Execution

	remove_row is
			-- Removes three of the buttons
		local
			counter:INTEGER
		do
			from
				counter:=button_list.count
			until
				counter=button_list.count-3
			loop
				button_list.go_i_th(counter)
				button_list.item.destroy
				counter:=counter-1
			end 
		end

	remove_button is
			-- Removes all of the added buttons
		do
			button_list.wipe_out
		end

	add_to_list(current_button:EV_BUTTON) is
			-- Adds the created button to the list of created buttons
		do
			button_list.extend(current_button)
		end


feature -- Access

	note: EV_NOTEBOOK
		-- A notebook for the demo

	text: EV_TEXT_FIELD
		-- A text field for the demo

	button: EV_BUTTON
		-- A button for the demo

	button_list:LINKED_LIST[EV_BUTTON];
		-- A list to hold all the buttons that are added to the table

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


end -- class TABLE_WINDOW

