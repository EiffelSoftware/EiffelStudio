indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		do
			{ANY_TAB} Precursor (par)

			create cmd2.make (~rows)
			create f1.make (Current, "Rows", Void, cmd2)
			create cmd2.make (~columns)
			create f2.make (Current, "Columns", Void, cmd2)
			create cmd1.make (~set_left_alignment)
			create f3.make (Current, "Set Left Alignment", cmd1, cmd1)
			create cmd1.make (~set_center_alignment)
			create f4.make (Current, "Set Center Alignment", cmd1, cmd1)
			create cmd1.make (~set_right_alignment)
			create f5.make (Current, "Set Right Alignment", cmd1, cmd1)
			

			create cmd1.make (~multiple_or_single)
			create b1.make_with_text (Current,"Currently Single Selection. Click to change.")
			b1.add_click_command (cmd1, Void)
			b1.set_vertical_Resize (False)
			create cmd1.make (~clear_selection)
			create b2.make_with_text (Current, "Clear Selection")
			b2.add_click_command (cmd1, Void)
			b2.set_vertical_resize (False)
			create cmd1.make (~toggle_title_row)
			create b3.make_with_text (Current, "Hide Title Row")
			b3.add_click_command (cmd1, Void)
			b3.set_vertical_resize (False)
				
		end

feature -- Access

	name: STRING is
			-- Returns the name of the tab.
		do
			Result:="Multi Column List"
		end

	current_widget: EV_MULTI_COLUMN_LIST
			-- The current widget.

	f1,f2,f3,f4,f5 : TEXT_FEATURE_MODIFIER
		-- feature modifiers.

	b1,b2,b3: EV_BUTTON
		-- Buttons used for modifying demo attributes.

feature -- Execution Feature


	rows (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the number of rows in the list.
		do
			f1.set_text (current_widget.rows.out)
		end

	columns (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the number of columns in the list.
		do
			f2.set_text (current_widget.columns.out)
		end

	multiple_or_single (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggles the selection mode between single and multiple.
		do
			if current_widget.is_multiple_selection then
				current_widget.set_single_selection
				b1.set_text ("Currently Single Selection. Click to change.")
			else
				current_widget.set_multiple_selection
				b1.set_text ("Currently Multiple selection. Click to change.")

			end
		end

	clear_selection (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Clears the current selection.
		do
			current_widget.clear_selection
		end

	toggle_title_row (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggles the title row between hidden and shown.
		do
			if current_widget.title_shown then
				current_widget.hide_title_row
				b3.set_text("Show Title Row")
			else
				current_widget.show_title_row
				b3.set_text("Hide Title Row")
			end
		end

	set_left_alignment (arg: EV_ARGUMENT; data: EV_eVENT_DATA) is
			-- Sets the alignment of the indexed row
			-- to left aligned.
		do
			if f3.get_text.is_integer and 
			f3.get_text.to_integer <= current_widget.columns and
			f3.get_text.to_integer >1 then
				current_widget.set_left_alignment (f3.get_text.to_integer)
				f3.set_text(" ")				
			end
		end

	set_center_alignment (arg: EV_ARGUMENT; data: EV_eVENT_DATA) is
			-- Sets the alignment of the indexed row
			-- to center aligned.
		do
			if f4.get_text.is_integer and 
			f4.get_text.to_integer <= current_widget.columns and
			f4.get_text.to_integer >1 then
				current_widget.set_center_alignment (f4.get_text.to_integer)
				f4.set_text(" ")
			end
		end


	set_right_alignment (arg: EV_ARGUMENT; data: EV_eVENT_DATA) is
			-- Sets the alignment of the indexed row
			-- to right aligned.
		do
			if f5.get_text.is_integer and 
			f5.get_text.to_integer <= current_widget.columns and
			f5.get_text.to_integer >1 then
				current_widget.set_right_alignment (f5.get_text.to_integer)
				f5.set_text(" ")
			end
		end

end -- class MULTI_COLUMN_LIST_TAB
