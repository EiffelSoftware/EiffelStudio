--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class PROMPT_D_O

inherit

	PROMPT_D_I;

	PROMPT_O
		undefine
			make, set_managed, real_x, real_y,
			undefine_cursor_if_shell, define_cursor_if_shell
		redefine
			set_x, set_y, set_x_y,
			message_form
		end;

	DIALOG_O
		redefine
			set_x, set_y, set_x_y
		end;

creation

	make

feature -- Creation

	make (a_prompt_dialog: PROMPT_D) is
			-- Create a motif prompt dialog.
		do
			!!is_poped_up_ref;
			screen_object := create_prompt (a_prompt_dialog.identifier,
							a_prompt_dialog.parent);
			a_prompt_dialog.set_dialog_imp (Current);
			initialize (a_prompt_dialog)
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

