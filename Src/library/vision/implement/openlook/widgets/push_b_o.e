indexing

	description: "Implementation of push button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PUSH_B_O 

inherit

	PUSH_B_I
		export
			{NONE} all
		end;

	PUSH_B_R_O
		export
			{NONE} all
		end;

	BUTTON_O;

	FONTABLE_O
		rename
			resource_name as OfontList
		
		end;

creation

	make

feature 

	make (a_push_b: PUSH_B) is
			-- Create an openlook push button.
		
		local
			ext_name: ANY;
		do
			ext_name := a_push_b.identifier.to_c;		
			screen_object := create_push_b ($ext_name, a_push_b.parent.implementation.screen_object);
			a_push_b.set_font_imp (Current);
			allow_recompute_size;
		end

feature {NONE}

	activate_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when current push button
			-- is activated

feature 

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- push button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (activate_actions = Void) then
				!!activate_actions.make (screen_object, Oactivate, widget_oui)
			end;
			activate_actions.add (a_command, argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- push button is armed.
			-- This action is not provided by OpenLook
		require else
			not_a_command_void: not (a_command = Void)
		do
			add_button_press_action (1, a_command, argument);
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- push button is released.
			-- This action is not provided by OpenLook
		require else
			not_a_command_void: not (a_command = Void)
		do
			add_button_release_action (1, a_command, argument);
		end;

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			activate_actions.remove (a_command, argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
			-- This action is not provided by OpenLook
		require else
			not_a_command_void: not (a_command = Void)
		do
			remove_button_press_action (1, a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
			-- This action is not provided by OpenLook
		require else
			not_a_command_void: not (a_command = Void)
		do
			remove_button_release_action (1, a_command, argument)
		end

feature {NONE} -- External features

	create_push_b (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
