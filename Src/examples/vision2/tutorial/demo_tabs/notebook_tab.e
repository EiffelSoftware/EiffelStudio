indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_TAB

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
			cmd1, cmd2: EV_ROUTINE_COMMAND
			h1: EV_HORIZONTAL_SEPARATOR
		do
			{ANY_TAB} Precursor (Void)
		
				-- Create the objects and their commands
			create cmd1.make (~set_cp)
			create cmd2.make (~get_cp)
			create f1.make (Current, 0, 0, "Current Page", cmd1, cmd2)			

			create cmd2.make (~get_count)
			create f2.make (Current, 1, 0, "Pages", cmd1, cmd2)
			create h1.make (Current)
			set_child_position (h1, 2, 0, 3, 3)

			create b1.make_with_text(Current,"Add New Page")
			create cmd1.make (~add_page)
			b1.add_click_command(cmd1, Void)
			b1.set_vertical_resize(False)
			set_child_position (b1, 3, 0, 4, 1)	
			create b2.make_with_text(Current,"Move Tabs")
			create cmd1.make (~move_tabs)
			b2.add_click_command(cmd1, Void)
			b2.set_vertical_resize(False)
			set_child_position (b2, 3, 1, 4, 2)
			f2.disable_text
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Notebook"
		end

	current_widget: EV_NOTEBOOK
			-- Current widget we are working on.

	b1, b2: EV_BUTTON
			-- Buttons.

	f1, f2: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

feature -- Execution feature

	set_cp (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the current page of the notebook
		do
			if f1.get_text.is_integer and f1.get_text.to_integer>0
			and f1.get_text.to_integer<=current_widget.count then
				current_widget.set_current_page(f1.get_text.to_integer)
			end
		end

	get_cp (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the current page of the notebook
		do
			f1.set_text(current_widget.current_page.out)	
		end

	get_count (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the number of pages in the notebook
		do
			f2.set_text(current_widget.count.out)
		end

	add_page (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Adds a new page to the notebook
		local
			temp_string: STRING
			new_page:EV_VERTICAL_BOX
		do
			temp_string:="Page "
			temp_string.append_string((current_widget.count+1).out)
			create new_page.make(current_widget)
			current_widget.append_page(new_page,temp_string)
		end

	move_tabs (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Moves the position of the notebooks tabs
		do
			inspect current_widget.tab_position
			when 1 then current_widget.set_tab_right
			when 2 then current_widget.set_tab_bottom
			when 3 then current_widget.set_tab_left
			when 4 then current_widget.set_tab_top
		end
		end

end -- class NOTEBOOK_TAB

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

