indexing

	description: 
		"EiffelVision push button, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class
	PUSH_B_IMP
	
inherit
	PUSH_B_I
	
	BUTTON_IMP

	TEXT_CONTAINER
	
creation

	make

feature {NONE} -- Initialization

	make (a_push_b: PUSH_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif push button.
		local
			a: ANY
		do
			a ?= a_push_b.identifier
			widget := gtk_button_new_with_label ($a)
			
			common_widget_make (man, oui_parent)

--			a_push_b.set_font_imp (Current);	
--			set_mnemonic_from_text (a_push_b.identifier, False)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add activate action for the button
		local
			a: ANY
		do
			-- at the moment only 1 action possible
			-- XXX change the manifest constant
			a := ("clicked").to_c			
			
			gtk_command_id := c_gtk_signal_connect (widget,
								$a,
								a_command.execute_address,
								$a_command,
								$argument)	
			
-- 			list := vision_command_list (activate_command);
-- 			if list = Void then
-- 				!! list.make;
-- 				set_activate_callback (list, Void)
-- 			end;
-- 			list.add_command (a_command, argument)
		end;

-- 	add_arm_action (a_command: COMMAND; argument: ANY) is
-- 			-- Add `a_command' to the list of action to execute when
-- 			-- current push button is armed.
-- 		local
-- 			list: VISION_COMMAND_LIST
-- 		do
-- 			list := vision_command_list (arm_command);
-- 			if list = Void then
-- 				!! list.make;
-- 				set_arm_callback (list, Void)
-- 			end;
-- 			list.add_command (a_command, argument)
-- 		end;

-- 	add_release_action (a_command: COMMAND; argument: ANY) is
-- 			-- Add `a_command' to the list of action to execute when
-- 			-- current push button is released.
-- 		local
-- 			list: VISION_COMMAND_LIST
-- 		do
-- 			list := vision_command_list (disarm_command);
-- 			if list = Void then
-- 				!! list.make;
-- 				set_disarm_callback (list, Void)
-- 			end;
-- 			list.add_command (a_command, argument)
-- 		end;

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and
			-- key to use as a shortcut in selecting a
			-- button) to `a_translation'.
			-- `a_translation' must be specified with the
			-- X toolkit conventions.
		do
			check
				not_be_called: False
			end
		end
	
feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when current push button is
			-- activated.
		do
			
			gtk_signal_disconnect (widget, gtk_command_id)
			--			c_gtk_signal_disconnect (widget, a_command.execute_address, 
--						 Current, argument);
--			remove_command (activate_command, a_command, argument)
		end; 

-- 	remove_arm_action (a_command: COMMAND; argument: ANY) is
-- 			-- Remove `a_command' from the list of action to execute when
-- 			-- current push button is armed.
-- 		do
-- 			remove_command (arm_command, a_command, argument)
-- 		end;

-- 	remove_release_action (a_command: COMMAND; argument: ANY) is
-- 			-- Remove `a_command' from the list of action to execute when
-- 			-- current push button is released.
-- 		do
-- 			remove_command (disarm_command, a_command, argument)
-- 		end;

 	remove_accelerator_action is
 			-- Remove the accelerator action.
 		do
			check
				not_be_called: False
			end
-- 			set_accelerator (Void)
 		end;
	
	
feature {WIDGET} -- build widget components
	

feature {NONE} -- Implementation
	
	gtk_command_id: INTEGER
			-- Id of the command handler
	
	
	label_widget: POINTER is
			-- gtk widget of the label inside the button
		do
			Result := c_gtk_get_label_widget (widget)
		end
	
	
	
end -- class PUSH_B_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
