indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_TAB

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
			-- Create the tab and initialise objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
			h1: EV_HORIZONTAL_SEPARATOR
		do
			{ANY_TAB} Precursor (Void)
				
				-- Creates the objects and their commands
			create cmd2.make (~get_rows)
			create f1.make (Current, 0, 0, "Rows", Void, cmd2)
			create cmd2.make (~get_columns)
			create f2.make (Current, 1, 0, "Columns", Void, cmd2)
			create cmd1.make (~aset_row_spacing)
			create cmd2.make (~get_row_spacing)
			create f3.make (Current, 2, 0, "Row Spacing", cmd1, cmd2)
			create cmd1.make (~aset_column_spacing)
			create cmd2.make (~get_column_spacing)
			create f4.make (Current, 3, 0, "Column Spacing", cmd1, cmd2)
			create h1.make (Current)
			set_child_position (h1, 4, 0, 5, 3)
			create b2.make_with_text (Current,"Add Buttons")
			create cmd1.make (~add_buttons)
			b2.add_click_command(cmd1, Void)
			b2.set_vertical_resize(False)
			set_child_position (b2, 5, 0, 6, 1)
			create b1.make_with_text (Current, "Reset Table")
			create cmd1.make (~reset_table)
			b1.add_click_command(cmd1, Void)
			b1.set_vertical_resize(False)
			set_child_position (b1, 5, 1, 6, 2)
			set_parent(par)
		end

feature -- Access
	
	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Table"
		end

	current_widget: EV_TABLE
			-- Current widget we are working on.

	b1, b2: EV_BUTTON
			-- Buttons.

	f1, f2, f3, f4: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

feature -- Execution feature

	get_columns (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the number of columns in the table.
		do
			f2.set_text(current_widget.columns.out)
		end			

	get_rows (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the number of rows in the table.
		do
			f1.set_text(current_widget.rows.out)
		end

	aset_row_spacing (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the row spacing between two table objects.
		do
			if f3.get_text.is_integer then
				current_widget.set_row_spacing(f3.get_text.to_integer) 
			end
		end

	get_row_spacing (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the row spacing between two table objects.
		do
			f3.set_text(current_widget.row_spacing.out)
		end

	aset_column_spacing (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the column spacing between two table objects.
		do
			if f4.get_text.is_integer then
				current_widget.set_column_spacing(f4.get_text.to_integer) 
			end
		end

	get_column_spacing (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the column spacing between two table objects.
		do
			f4.set_text(current_widget.column_spacing.out)
		end

	add_buttons (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Add buttons to the table
		local
			counter,temp_column: INTEGER
			temp_table: TABLE_WINDOW
			temp_table1: DYNTABLE_WINDOW
		do
			temp_table1?=current_widget
			if temp_table1 = Void then
				temp_table?=current_widget
				from
					counter:=0
					temp_column:=current_widget.columns
				until
					counter=current_widget.rows
				loop
					create b2.make(current_widget)
					temp_table.add_to_list(b2)
					current_widget.set_child_position(b2,counter,temp_column,counter+1,temp_column+1)
					counter:=counter+1
				end
			else
				create b2.make (current_widget)
				temp_table1.add_to_list(b2)
			end
		end

	reset_table (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Resets the table back to its original form
		local
			temp_table:TABLE_WINDOW
			temp_table1:DYNTABLE_WINDOW
		do
			temp_table ?= current_widget
			if temp_table = Void then
				temp_table1 ?= current_widget
				temp_table1.remove_button
			else
				temp_table.remove_row
			end
		end

end -- class TABLE_TAB

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

