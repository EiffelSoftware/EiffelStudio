class WINDOW1

inherit

	BASE
		rename
			make as base_make
		undefine
			init_toolkit
		end;
	WINDOWS

creation

	make

feature

	button1, button2: PUSH_B;
			-- Push buttons

	form: FORM;
			-- Form: widget which manages relative
			-- positions of children widgets.

	make (a_name: STRING; a_s: SCREEN) is
		do
			base_make (a_name, a_s);
			!!form.make ("Form", Current);
			!!button1.make ("Button1", form);
			!!button2.make ("Button2", form);
			set_values;
			set_attachments;	
			set_callbacks;
		end;

	set_values is
		do
			button1.set_text ("Popup message");
			button2.set_text ("Create window");
		end;

	set_attachments is
			-- Perform relative attachments
			-- of the push button in the form.
		do
			form.attach_top (button1, 5);
			form.attach_left (button1, 5);
			form.attach_right (button1, 5);
			form.attach_bottom (button2, 5);
			form.attach_left (button2, 5);
			form.attach_right (button2, 5);
			form.attach_top_widget (button1, button2, 5);
		end;

	set_callbacks is
		local
			popup_command: POPUP_COMMAND;
			realize_command: REALIZE_COMMAND;
		do
			!!popup_command;
			!!realize_command;
			button1.add_activate_action (popup_command, message_box);
			button2.add_activate_action (realize_command, other_window);
		end;
	
end

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

