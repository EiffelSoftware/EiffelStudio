indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXTABLE_TAB

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
		once
			{ANY_TAB} Precursor (Void)
		
				-- Creates the objects and their commands
			create cmd1.make (~set_text_val)
			create cmd2.make (~get_text_val)
			create f1.make (Current, 0, 0, "Text", cmd1, cmd2)
			create h1.make (Current)
			set_child_position (h1, 1, 0, 2, 3)
			
			create cmd1.make (~center_alignment)
			create b1.make_with_text (Current, "Center Alignment")
			b1.set_vertical_resize (False)
			b1.add_click_command (cmd1, Void)
			set_child_position (b1, 2, 0, 3, 1)
			create cmd1.make (~left_alignment)
			create b2.make_with_text (Current, "Left Alignment")
			b2.add_click_command (cmd1, Void)
			b2.set_vertical_resize(False)
			set_child_position (b2, 2, 1, 3, 2)
			create cmd1.make (~right_alignment)
			create b3.make_with_text (Current, "Right Alignment")
			b3.set_vertical_resize(False)
			b3.add_click_command (cmd1, Void)
			set_child_position (b3, 2, 2, 3, 3)
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Textable"
		end


feature -- Execution feature  

	get_text_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the text of the demo.
		do
			f1.set_text(current_widget.text)
		end

	set_text_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Gets the text of the demo.
		do
			current_widget.set_text(f1.get_text)
		end

	center_alignment (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the text to center alignment
		do
			current_widget.set_center_alignment
		end

	right_alignment (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the text to right alignment
		do
			current_widget.set_right_alignment
		end

	left_alignment (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the text to left alignment
		do
			current_widget.set_left_alignment
		end

feature -- Access

	current_widget: EV_TEXTABLE
	f1: TEXT_FEATURE_MODIFIER	
	b1,b2,b3: EV_BUTTON
end -- class BOX_TAB

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

