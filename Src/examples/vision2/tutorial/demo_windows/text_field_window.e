indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TEXT_FIELD_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS
	TEXT_COMPONENT_COMMANDS
	TEXT_FIELD_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'. For efficiency, we first
			-- create the box without parent.
		local
			frame: EV_FRAME
		do
			{EV_VERTICAL_BOX} Precursor (Void)
			!! textfield.make_with_text (Current, "Edit me")
			create event_window.make (textfield)
			add_widget_commands (textfield, event_window, "text field")
			add_text_component_commands (textfield, event_window, "Text field")
			add_text_field_commands (textfield, event_window, "text field")
			set_parent (par)	
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend(text_component_tab)
			tab_list.extend(text_field_tab)
			create action_window.make (textfield, tab_list)
		end

feature -- Access

	TextField: EV_TEXT_FIELD
		-- A text field in the demo

	
end -- class TEXT_FIELD_WINDOW

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

