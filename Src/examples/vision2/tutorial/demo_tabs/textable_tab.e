indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


create
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
			h1: EV_HORIZONTAL_SEPARATOR
		once
			Precursor {ANY_TAB} (Void)
		
				-- Creates the objects and their commands
			create cmd1.make (agent set_text_val)
			create cmd2.make (agent get_text_val)
			create f1.make (Current, 0, 0, "Text", cmd1, cmd2)
			create h1.make (Current)
			set_child_position (h1, 1, 0, 2, 3)
			
			create cmd1.make (agent center_alignment)
			create b1.make_with_text (Current, "Center Alignment")
			b1.set_vertical_resize (False)
			b1.add_click_command (cmd1, Void)
			set_child_position (b1, 2, 0, 3, 1)
			create cmd1.make (agent left_alignment)
			create b2.make_with_text (Current, "Left Alignment")
			b2.add_click_command (cmd1, Void)
			b2.set_vertical_resize(False)
			set_child_position (b2, 2, 1, 3, 2)
			create cmd1.make (agent right_alignment)
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
	b1,b2,b3: EV_BUTTON;
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


end -- class BOX_TAB

