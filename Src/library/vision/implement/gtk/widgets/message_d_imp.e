indexing

	description: 
		"EiffelVision message dialog, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class 
	MESSAGE_D_IMP

inherit

	MESSAGE_D_I
		redefine
			build
		end
	
	DIALOG_IMP
	TERMINAL_IMP
		rename
			make as terminal_make
		undefine
			is_stackable 
			-- message_d is not stackable, terminal is,
			-- using is_stackable from DIALOG_IMP, where
			-- it is defined as false
		redefine
			build
		end

	
creation

	make

feature {NONE} -- Initialization

	make (a_message_dialog: MESSAGE_D; oui_parent: COMPOSITE) is
			-- Create a motif dialog message box.
		local
			mc: MEL_COMPOSITE
		do
			widget := gtk_dialog_new 
			
			common_widget_make (False, oui_parent)			
		end
	

feature -- Status setting (from MESSAGE_D_I)

	set_left_alignment is
			-- Set message alignment to beginning.
		do
			check
				not_yet_implemented: False
			end
		end

	set_center_alignment is
			-- Set message alignment to center.
		do
			check
				not_yet_implemented: False
			end
		end

	set_right_alignment is
			-- Set message alignment to right.
		do
			check
				not_yet_implemented: False
			end
		end

	show_cancel_button is
			-- Make cancel button visible.
		do
			cancel_button.manage
			cancel_button.realize
		end

	show_help_button is
			-- Make help button visible.
		do
			help_button.show
		end

	show_ok_button is
			-- Make ok button visible.
		do
			ok_button.show
		end

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			cancel_button.unrealize
			cancel_button.unmanage
		end

	hide_help_button is
			-- Make help button invisible.
		do
			help_button.unrealize
			help_button.unmanage
		end
		
	hide_ok_button is
			-- Make ok button invisible.
		do
			help_button.unrealize
			help_button.unmanage
		end

	
	manage is
			-- manage dialog
		do
			set_managed (True)
			show
		end
	
	unmanage is
			-- unmanage dialog
		do
			hide
			set_managed (False)
		end
	
feature -- Element change

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		do
			message.set_text (a_message)
		end

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		do
			check
				not_yet_implemented: False
			end
		end

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		local
			a: ANY
		do
			-- at the moment only 1 action possible

			-- XXX change the manifest constant
			a := ("clicked").to_c			
			
			gtk_command_id := c_gtk_signal_connect (c_widget_of_button (cancel_button),
								$a,
								a_command.execute_address,
								$a_command,
								$argument)			end

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		local
			a: ANY
		do
			-- at the moment only 1 action possible

			-- XXX change the manifest constant
			a := ("clicked").to_c			
			
			gtk_command_id := c_gtk_signal_connect (c_widget_of_button (help_button),
								$a,
								a_command.execute_address,
								$a_command,
								$argument)			end

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		local
			a: ANY
		do
			-- at the moment only 1 action possible

			-- XXX change the manifest constant
			a := ("clicked").to_c			
			
			gtk_command_id := c_gtk_signal_connect (c_widget_of_button (ok_button),
								$a,
								a_command.execute_address,
								$a_command,
								$argument)			end

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			check
				not_yet_implemented: False
			end
		end
	
	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
			check
				not_yet_implemented: False
			end
		end

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Display update

	update_display is
			-- Updates the display of all the windows in
			-- the application Windows implementation does
			-- not do anything
		do
			check
				not_yet_implemented: False
			end
		end
	
feature {NONE} -- Implementation attributes
	
	ok_button: PUSH_B
	cancel_button: PUSH_B
	help_button: PUSH_B
	message: LABEL
	
	
feature {NONE} -- Implementation
	
	oui_message_d: MESSAGE_D is
			-- Object User Interface of this message_d
		local
			m: MESSAGE_D
		do
			m ?= widget_oui
			Result := m
		ensure
			valid_message_dialog: Result /= Void
		end

	
	create_buttons is
		local
			o: PUSH_B_IMP
			c: PUSH_B_IMP
			h: PUSH_B_IMP
		do
			!!ok_button.make ("Ok", oui_message_d)
			!!cancel_button.make ("Cancel", oui_message_d)
			!!help_button.make ("Help", oui_message_d)
			
			c_gtk_create_message_d_buttons (widget, 
							c_widget_of_button (ok_button),
							c_widget_of_button (cancel_button),
							c_widget_of_button (help_button))
							
-- 			ok_button.realize
-- 			cancel_button.realize
-- 			help_button.realize
			
-- 			ok_button.hide
		--	cancel_button.show
	--		help_button.show
		end
	
	create_label is
		do
			!!message.make (oui_message_d.identifier, oui_message_d)
			
			c_gtk_create_message_d_label (widget, 
						      c_widget_of_label (message))
--			message.realize
--			message.show
		end
	
	
feature {WIDGET} 

	build is
		do
			{TERMINAL_IMP} Precursor
			create_buttons
			create_label
		end

			
feature {NONE} -- Implementation
	
	gtk_command_id: INTEGER
			-- Id of the command handler	
end

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
