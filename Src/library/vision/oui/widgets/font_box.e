
-- 

indexing

	date: "$Date$";
	revision: "$Revision$"

class FONT_BOX 

inherit

	TERMINAL
		rename
			make as terminal_make
		redefine
			implementation
		end


creation

	make

	
feature 

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_apply_action (a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_cancel_action (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_ok_action (a_command, argument)
		end; 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a font box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.font_box (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end;

	font: FONT is
			-- Font currently selected by the user
		do
			Result := implementation.font
		ensure
			not (Result = Void)
		end;

	hide_apply_button is
			-- Make apply button invisible.
		do
			implementation.hide_apply_button
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			implementation.hide_cancel_button
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			implementation.hide_ok_button
		end; 

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FONT_BOX_I;
			-- Implementation of current font box

	
feature 

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_apply_action (a_command, argument)
		end; 

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_cancel_action (a_command, argument)
		end; 

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_ok_action (a_command, argument)
		end;

	set_font (a_font: FONT) is
			-- Edit `a_font'.
		require
			a_font_exists: not (a_font = Void)
		do
			implementation.set_font (a_font)
		end;

	show_apply_button is
			-- Make apply button visible.
		do
			implementation.show_apply_button
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			implementation.show_cancel_button
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			implementation.show_ok_button
		end 

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
