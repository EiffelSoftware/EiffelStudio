indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNTABLE_WINDOW

inherit
	EV_DYNAMIC_TABLE
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
			-- We create the table first without parent because
			-- it is faster.
		do
			Precursor {EV_DYNAMIC_TABLE} (Void)
			set_row_layout
			set_finite_dimension (2)

			create button.make_with_text (Current, "Element 1")
			create button.make_with_text (Current, "Element 2")
			create button.make_with_text (Current, "Element 3")
			create button.make_with_text (Current, "Element 4")
			create button.make_with_text (Current, "Element 5")
			create button.make_with_text (Current, "Element 6")
			create button.make_with_text (Current, "Element 7")
			create button.make_with_text (Current, "Element 8")
			create button.make_with_text (Current, "Element 9")
			create button.make_with_text (Current, "Element 10")
			create button.make_with_text (Current, "Element 11")

			set_homogeneous (True)
			set_row_spacing (5)
			set_column_spacing (5)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "dynamic table")
			create button_list.make
			set_parent (par)
			end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			tab_list.extend(table_tab)
			tab_list.extend(dyntable_tab)
			create action_window.make(Current,tab_list)
		end


feature -- Execution

	remove_button is
			-- Removes a button from the table
		do
			if not button_list.empty then
				button_list.finish
	--			button_list.item.destroy
				button_list.remove
			end
		end


	add_to_list(current_button:EV_BUTTON) is
			-- Adds the created button to the list of created buttons
		do
			button_list.extend(current_button)
		end


feature -- Access

	button: EV_BUTTON
		-- A button for the demo
	
	button_list:LINKED_LIST[EV_BUTTON];

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


end -- class DYNTABLE_WINDOW

