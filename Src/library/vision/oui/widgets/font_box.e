indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	FONT_BOX 

inherit

	TERMINAL_OUI
		redefine
			make, create_ev_widget, make_unmanaged,
			implementation
		end

creation

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a font box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True);
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged font box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False);
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a font box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!FONT_BOX_IMP! implementation.make (Current, man, a_parent);
			set_default
			implementation.set_widget_default;
		end;

feature -- Access

	font: FONT is
			-- Font currently selected by the user
		require
			exists: not destroyed;
		do
			Result := implementation.font
		ensure
			valid_result: Result /= Void
		end;

feature -- Status report

	show_apply_button is
			-- Make apply button visible.
		require
			exists: not destroyed
		do
			implementation.show_apply_button
		end;

	show_cancel_button is
			-- Make cancel button visible.
		require
			exists: not destroyed
		do
			implementation.show_cancel_button
		end;

	show_ok_button is
			-- Make ok button visible.
		require
			exists: not destroyed
		do
			implementation.show_ok_button
		end 

	hide_apply_button is
			-- Make apply button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_apply_button
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_cancel_button
		end;

	hide_ok_button is
			-- Make ok button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_ok_button
		end; 

feature -- Element change

	set_font (a_font: FONT) is
			-- Edit `a_font'.
		require
			exists: not destroyed;
			a_font_exists: a_font /= Void
		do
			implementation.set_font (a_font)
		end;

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_apply_action (a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_cancel_action (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_ok_action (a_command, argument)
		end; 

feature -- Remocal

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_apply_action (a_command, argument)
		end; 

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_cancel_action (a_command, argument)
		end; 

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			valid_command: a_command /= Void
		do
			implementation.remove_ok_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: FONT_BOX_I;
			-- Implementation of current font box
	
end -- class FONT_BOX



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

