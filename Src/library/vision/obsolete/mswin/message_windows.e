indexing 
	status: "See notice at end of class"; 
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
 
creation
	make

feature {NONE} -- Initialization

	make (a_message: MESSAGE; man: BOOLEAN; oui_parent: COMPOSITE) is
		do
			managed := man
		end

feature -- Status setting

	hide_cancel_button is
			-- Make cancel button invisible.
			-- Always visible
		do
		end

	hide_filter_button is
			-- Make filter button invisible.
			-- Always invisible
		do
		end

	hide_help_button is
			-- Make help button invisible.
			-- Always invisible
		do
		end

	hide_ok_button is
			-- Make ok button invisible.
			-- Always visible
		do
		end

	show_cancel_button is
			-- Make cancel button visible.
			-- Always visible
		do
		end

	show_help_button is
			-- Make help button visible.
			-- Always invisible
		do
		end

	show_ok_button is
			-- Make ok button visible.
			-- Always visible
		do
		end

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		do
		end

	set_center_alignment is
			-- Set message alignment to center.
		do
		end

	set_right_alignment is
			-- Set message alignment to right.
		do
		end

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		do
		end

	set_left_alignment is
			-- Set message alignment to beginning.
		do
		end

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		do
		end

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		do
		end

feature -- Element change

	add_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
		end

	add_help_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		do
		end

	add_ok_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
		end

	add_filter_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		do
		end

feature -- Removal

	remove_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
		end

	remove_filter_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		do
		end

	remove_help_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
		end

 	remove_ok_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
		end
	
feature {NONE} -- Implementation

	ok_button_shown: BOOLEAN

	cancel_button_shown: BOOLEAN

	help_button_shown: BOOLEAN

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionMessage"
		end

end -- class MESSAGE_WINDOWS
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

