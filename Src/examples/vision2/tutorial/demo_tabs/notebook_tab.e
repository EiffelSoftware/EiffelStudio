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
		do
			{ANY_TAB} Precursor (Void)
		
				-- Create the objects and their commands
			create cmd1.make (~set_cp)
			create cmd2.make (~get_cp)
			create f1.make (Current, 0, 0, "Current Page", cmd1, cmd2)			

			create cmd2.make (~get_count)
			create f2.make (Current, 1, 0, "Pages", cmd1, cmd2)

			create b1.make_with_text(Current,"Add New Page")
			create cmd1.make (~add_page)
			b1.add_click_command(cmd1, Void)
			b1.set_vertical_resize(False)	
			create b2.make_with_text(Current,"Move Tabs")
			create cmd1.make (~move_tabs)
			b2.add_click_command(cmd1, Void)
			b2.set_vertical_resize(False)
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
			if (current_widget.tab_position = current_widget.Tab_right) then
				current_widget.set_tab_right
			elseif (current_widget.tab_position = current_widget.Tab_bottom) then
				current_widget.set_tab_bottom
			elseif (current_widget.tab_position = current_widget.Tab_left) then
				current_widget.set_tab_left
			elseif (current_widget.tab_position = current_widget.Tab_top) then
				current_widget.set_tab_top
			end
		end

end -- class NOTEBOOK_TAB
