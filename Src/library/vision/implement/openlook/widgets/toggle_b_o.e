
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_B_O 

inherit

	TOGGLE_B_I
		export
			{NONE} all
		end;

	TOGGLE_R_O
		export
			{NONE} all
		end;

	BUTTON_O;

	FONTABLE_O
		rename
			resource_name as OfontList
		
		end

creation

	make
	
feature {NONE}

	arm is
			-- Assign True to `state'.
		
		local
			ext_name: ANY;
		do
			ext_name := Oset.to_c;		
			set_boolean  (screen_object, True, $ext_name)
		ensure then
			state_is_true: state
		end; 

	
feature 

	make (a_toggle_b: TOGGLE_B) is
			-- Create a openlook toggle button.
		
		local
			ext_name: ANY;
		do
			ext_name := a_toggle_b.identifier.to_c;		
			screen_object := create_toggle_b ($ext_name, a_toggle_b.parent.implementation.screen_object);
			a_toggle_b.set_font_imp (Current);
		end;

	
feature {NONE}

	disarm is
			-- Assign False to `state'.
		
		local
			ext_name: ANY;
		do
			ext_name := Oset.to_c;		
			set_boolean  (screen_object, False, $ext_name)
		ensure then
			state_is_false: not state
		end; 

	state : BOOLEAN is
			-- State of current toggle button.
		do
			Result := xt_boolean (screen_object, Oset)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (arm_actions = Void) then
				!!arm_actions.make (screen_object, Oarm, widget_oui)
			end;
			arm_actions.add (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (release_actions = Void) then
				!!release_actions.make (screen_object, Odisarm, widget_oui)
			end;
			release_actions.add (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			add_arm_action (a_command, argument);
			add_release_action (a_command, argument);
		end;

	
feature {NONE}

	arm_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when current toggle button
			-- is armed

	release_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when current toggle button
			-- is released

	
feature 

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			arm_actions.remove (a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			release_actions.remove (a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			arm_actions.remove (a_command, argument);
			release_actions.remove (a_command, argument)
		end; 
	
feature {NONE} -- External features

	create_toggle_b (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
