indexing
	description:
		"The demo that goes with the button demo";
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

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the table first without parent because
			-- it is faster.
		do
			{EV_DYNAMIC_TABLE} Precursor (Void)
			set_row_layout
			set_finite_dimension (2)

			!!button.make_with_text (Current, "Element 1")
			!!button.make_with_text (Current, "Element 2")
			!!button.make_with_text (Current, "Element 3")
			!!button.make_with_text (Current, "Element 4")
			!!button.make_with_text (Current, "Element 5")
			!!button.make_with_text (Current, "Element 6")
			!!button.make_with_text (Current, "Element 7")
			!!button.make_with_text (Current, "Element 8")
			!!button.make_with_text (Current, "Element 9")
			!!button.make_with_text (Current, "Element 10")
			!!button.make_with_text (Current, "Element 11")

			set_homogeneous (True)
			set_row_spacing (5)
			set_column_spacing (5)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "dynamic table")
			!!button_list.make
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
	
	button_list:LINKED_LIST[EV_BUTTON]

end -- class DYNTABLE_WINDOW

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

