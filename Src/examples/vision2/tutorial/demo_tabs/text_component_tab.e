indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_COMPONENT_TAB

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
			but: EV_BUTTON
			item: EV_LIST_ITEM
			h1 : EV_HORIZONTAL_SEPARATOR
				-- The vertical seperator.
		do
			{ANY_TAB} Precursor (Void)

			-- Creates the objects and their commands
			create cmd1.make (~set_text)
			create cmd2.make (~get_text)	
			create f1.make (Current, 0, 0, "Text", cmd1, cmd2)
			create h1.make (Current)
			set_child_position (h1, 1, 0, 2, 3)
			create b1.make_with_text (Current,"Copy Selection")
			b1.set_vertical_resize (False)
			create cmd1.make (~copy_text)
			b1.add_click_command (cmd1, Void)
			set_child_position (b1, 2, 0, 3, 1)
			create b2.make_with_text (Current, "Cut Selection")
			b2.set_vertical_resize (False)
			create cmd1.make (~cut_text)
			b2.add_click_command (cmd1, Void)
			set_child_position (b2, 2, 1, 3, 2)
			create b3.make_with_text (Current, "Delete Selection")
			b3.set_vertical_resize (False)
			create cmd1.make (~delete_text)
			b3.add_click_command (cmd1, Void)
			set_child_position (b3, 2, 2, 3, 3)
			create b4.make_with_text (Current, "Paste Selection")
			b4.set_vertical_resize (False)
			create cmd1.make (~paste_text)
			b4.add_click_command (cmd1, Void)
			set_child_position (b4, 3, 0, 4, 1)
			create b5.make_with_text (Current, "Select All")
			b5.set_vertical_resize (False)
			create cmd1.make (~select_all)
			b5.add_click_command (cmd1, Void)
			set_child_position (b5, 3, 1, 4, 2)
			create b6.make_with_text (Current, "Deselect All")
			b6.set_vertical_resize (False)
			create cmd1.make (~deselect_all)
			b6.add_click_command (cmd1, Void)
			set_child_position (b6, 3, 2, 4, 3)
			create b7.make_with_text (Current, "Set Editable")
			b7.set_vertical_resize (False)
			create cmd1.make (~set_editable)
			b7.add_click_command (cmd1, Void)
			set_child_position (b7, 4, 0, 5, 1)
			create b8.make_with_text (Current, "Set Non Editable")
			b8.set_vertical_resize (False)
			create cmd1.make (~set_not_editable)
			b8.add_click_command (cmd1, Void)
			set_child_position (b8, 4, 1, 5, 2)

			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Text Component"
		end

	current_widget: EV_TEXT_COMPONENT
			-- Current feature we are working on.

	f1: TEXT_FEATURE_MODIFIER
			-- Feature modifier for the demo.

	b1,b2,b3,b4,b5,b6,b7,b8 :EV_BUTTON
			-- Buttons used by the action window.

feature -- Execution feature  

	set_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the text of the component
		do
		if current_widget.is_editable then
			current_widget.set_text (f1.get_text)
		end
		end

	get_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the text of the component
		do
			f1.set_text (current_widget.text)
		end

	copy_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- If text is selected then copy it.
		do
			if current_widget.has_selection then
				current_widget.copy_selection
			end
		end

	cut_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- If text is selected then cut it.
		do
			if current_widget.has_selection and
			current_widget.is_editable then
				current_widget.cut_selection
			end
		end

	delete_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- If text is selected then delete it.
		do
			if current_widget.has_selection and
			current_widget.is_editable then
				current_widget.delete_selection
			end
		end

	paste_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- If text is held then paste it.
		do
			if current_widget.is_editable then
				current_widget.paste(current_widget.position)
			end
		end

	select_all (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Select all of the text.
		do
			current_widget.select_all
		end
	
	deselect_all (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Deselect all of the text.
		do
			if current_widget.has_selection then
				current_widget.deselect_all
			end
		end

	select_region (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Select a region of the text.
		do
		end

	append_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Append text into the text component.
		do
		end
	
	prepend_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Preprend text into the text component.
		do
		end

	insert_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Insert text into the text component
		do
		end

	set_editable (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the text component to read-write.
		do
			current_widget.set_editable (True)
		end
	
	set_not_editable (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the text component to read only.
		do
			current_widget.set_editable (False)
		end

	selection_start (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the index of the first character selected.
		do
		end

	selection_end (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the index of the last character selected.
		do
		end

	position (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the current position of the caret.
		do
		end

end -- class TEXT_COMPONENT_TAB



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

