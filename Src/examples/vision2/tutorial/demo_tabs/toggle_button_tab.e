indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_TAB

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
		

			create cmd1.make (agent set_state_val)		
			create cmd2.make (agent get_state_val)

			create f1.make (Current, 0, 0, "Toggle On", cmd1, cmd2)
			create iTrue.make_with_text (f1.combo, "True")
			create iFalse.make_with_text (f1.combo, "False")
			create h1.make (Current)
			set_child_position (h1, 1, 0, 2, 3)
			create cmd1.make (agent toggle_button)			create b1.make_with_text(Current,"Toggle")
			b1.add_click_command(cmd1, Void)
			b1.set_vertical_resize(False)
			set_child_position (b1, 2, 1, 3, 2)
	
				-- Creates the objects and their commands
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Toggle Button"
		end


feature -- Execution feature  

	get_state_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) IS
			-- Get the state of the toggle button.
		do
			if current_widget.state then
				iTrue.set_selected (True)
			else
				iFalse.set_selected (True)
			end

		end
	
	set_state_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the state of the toggle button.
		do
			-- We test if there is a selected item
			-- in the combo box.
			if f1.combo.selected then
				if f1.combo.selected_item = iTrue then
					current_widget.set_state(True)
				else
					current_widget.set_state(False)
				end
			end					
		end

	toggle_button (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggle the state of the button.
		do
			current_widget.toggle
		end
feature -- Access

	current_widget: EV_TOGGLE_BUTTON
	f1: COMBO_FEATURE_MODIFIER	
	b1: EV_BUTTON

	iTrue, iFalse: EV_LIST_ITEM;
			-- 
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


end -- class TOGGLE_BUTTON_TAB
