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
			h1: EV_HORIZONTAL_SEPARATOR
		do
			{ANY_TAB} Precursor (par)

			create cmd2.make (~get_rows)
			create f1.make (Current, 0, 0, "Rows", Void, cmd2)

			create cmd2.make (~get_columns)
			create f2.make (Current, 1, 0, "Columns", Void, cmd2)

			create cmd1.make (~set_left_alignment)
			create f3.make (Current, 2, 0, "Set Left Alignment", cmd1, cmd1)

			create cmd1.make (~set_center_alignment)
			create f4.make (Current, 3, 0, "Set Center Alignment", cmd1, cmd1)

			create cmd1.make (~set_right_alignment)
			create f5.make (Current, 4, 0, "Set Right Alignment", cmd1, cmd1)
			create h1.make (Current)
			set_child_position (h1, 5, 0, 6, 3)

			create cmd1.make (~multiple_or_single)
			create b1.make_with_text (Current,"Multiple Selection")
			b1.add_click_command (cmd1, Void)
			b1.set_vertical_Resize (False)
			set_child_position (b1, 6, 0, 7, 1)
			create cmd1.make (~clear_selection)
			create b2.make_with_text (Current, "Clear Selection")
			b2.add_click_command (cmd1, Void)
			b2.set_vertical_resize (False)
			set_child_position (b2, 6, 1, 7, 2)
			create cmd1.make (~toggle_title_row)
			create b3.make_with_text (Current, "Hide Title Row")
			b3.add_click_command (cmd1, Void)
			b3.set_vertical_resize (False)
			set_child_position (b3, 6, 2, 7, 3)
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


	get_rows (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the number of rows in the list.
		do
			f1.set_text (current_widget.count.out)
		end

	get_columns (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the number of columns in the list.
		do
			f2.set_text (current_widget.columns.out)
		end

	multiple_or_single (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggles the selection mode between single and multiple.
		do
			if current_widget.is_multiple_selection then
				current_widget.set_single_selection
				b1.set_text ("Multiple Selection")
			else
				current_widget.set_multiple_selection
				b1.set_text ("Single Selection")

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

