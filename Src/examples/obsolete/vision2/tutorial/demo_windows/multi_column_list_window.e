indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_WINDOW

inherit
	DEMO_WINDOW

	EV_MULTI_COLUMN_LIST
		redefine
			make
		end
	DEMO_WINDOW
	WIDGET_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo window in `par'.
		local
			type: EV_PND_TYPE
			cmd: EV_ROUTINE_COMMAND
		do
			--{EV_MULTI_COLUMN_LIST} Precursor (Void)
			make_with_text (par, <<"Part 1", "Part 2", "Part 3", "Part 4", "Part 5">>)
			set_multiple_selection
			set_columns_width (<<80, 80, 80, 80, 80>>)		
			set_right_alignment (2)
			set_center_alignment (3)
			set_left_alignment (4)

			create row1.make_with_text (Current, <<"Ceci","est","un","objet","row">>)
			row1.set_selected (True)
			row1.set_data (1)
			row1.activate_pick_and_drop (Void, Void)
			create type.make
			row1.set_data_type (type)
			row1.set_transported_data ("Bonjour")

			create row2.make (Current)
			row2.set_text (<<"This","is", "2nd", "Created","Row">>)
			row2.set_data (2)
			create row3.make_with_text (Current, <<"This","is","2nd","created","row">>)
			row3.set_data (3)
			create row4.make_with_all (Current, <<"This","is","Last","created","row">>, 2)
			row4.set_selected (True)
			row4.set_data (4)
			--set_parent (par)
			set_single_selection
		--	create cmd.make (~select_command)
		--	add_select_command (cmd, Void)
		--	create cmd.make (~unselect_command)
		--	add_unselect_command (cmd, Void)
			create cmd.make (agent column_click_command)
			add_column_click_command (cmd, Void)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "multi column list")
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend (multi_column_list_tab)
			create action_window.make (Current, tab_list)
		end

feature -- Access

	row1, row2, row3, row4: EV_MULTI_COLUMN_LIST_ROW
		-- Rows

feature -- Execution Feature

	select_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When a row is selected, inform user in `event_window'.
		do
			event_window.display ("Row selected in multi column list.")
		end

	unselect_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When a row is unselected, inform user in `event_window'.
		do
			event_window.display ("Row unselected in multi column list.")
		end

	column_click_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When a column is clicked, inform user in `event_window'.
		do
			event_window.display ("Column clicked in multi column list.")
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


end -- class MULTI_COLUMN_LIST_WINDOW

