note 
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	MESSAGE_WINDOWS 
  
inherit
	TERMINAL_IMP
		rename
			make as message_dialog_make
		redefine
			class_name
		end

	MESSAGE_I
 
create
	make

feature {NONE} -- Initialization

	make (a_message: MESSAGE; man: BOOLEAN; oui_parent: COMPOSITE)
		do
			managed := man
		end

feature -- Status setting

	hide_cancel_button
			-- Make cancel button invisible.
			-- Always visible
		do
		end

	hide_filter_button
			-- Make filter button invisible.
			-- Always invisible
		do
		end

	hide_help_button
			-- Make help button invisible.
			-- Always invisible
		do
		end

	hide_ok_button
			-- Make ok button invisible.
			-- Always visible
		do
		end

	show_cancel_button
			-- Make cancel button visible.
			-- Always visible
		do
		end

	show_help_button
			-- Make help button visible.
			-- Always invisible
		do
		end

	show_ok_button
			-- Make ok button visible.
			-- Always visible
		do
		end

	set_cancel_label (a_label: STRING)
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		do
		end

	set_center_alignment
			-- Set message alignment to center.
		do
		end

	set_right_alignment
			-- Set message alignment to right.
		do
		end

	set_help_label (a_label: STRING)
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		do
		end

	set_left_alignment
			-- Set message alignment to beginning.
		do
		end

	set_message (a_message: STRING)
			-- Set `a_message' as message.
		do
		end

	set_ok_label (a_label: STRING)
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		do
		end

feature -- Element change

	add_cancel_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
		end

	add_help_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		do
		end

	add_ok_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
		end

	add_filter_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		do
		end

feature -- Removal

	remove_cancel_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
		end

	remove_filter_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		do
		end

	remove_help_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
		end

 	remove_ok_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
		end
	
feature {NONE} -- Implementation

	ok_button_shown: BOOLEAN

	cancel_button_shown: BOOLEAN

	help_button_shown: BOOLEAN

	class_name: STRING
			-- Class name
		once
			Result := "EvisionMessage"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MESSAGE_WINDOWS

