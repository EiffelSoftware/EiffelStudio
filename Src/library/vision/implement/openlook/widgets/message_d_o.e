indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MESSAGE_D_O

inherit

	MESSAGE_O
		undefine
			make, set_managed, real_x, real_y, action_target,
			undefine_cursor_if_shell, define_cursor_if_shell
		redefine
			set_x, set_y, set_x_y,
			message_form
		end;

	MESSAGE_D_I
		export
			{NONE} all
		end;

	DIALOG_O
		redefine
			set_x, set_y, set_x_y
		end;

creation

	make

feature -- Creation

	make (a_message: MESSAGE_D) is
			-- Create a motif dialog message box.
		local
			ext_name: ANY
		do
			!!is_poped_up_ref;
			screen_object :=
				create_message_box (a_message.identifier, a_message.parent);
			a_message.set_dialog_imp (Current);
			initialize (a_message)
			action_target := screen_object;
		end;

feature 

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		do
			message_form.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		do
			message_form.set_y (new_y);
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		do
			message_form.set_x_y (new_x, new_y)
		end;

feature {NONE} -- EiffelVision implemetation

	
	message_form: FORM_D;

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
