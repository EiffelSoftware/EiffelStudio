
class ERROR_BOX 

inherit

	ERROR_D
		rename
			popup as old_popup,
			make as error_d_create
		end;
	COMMAND;
	CONSTANTS;

creation

	make

	
feature {NONE}

	caller: ERROR_POPUPER;
	
feature 

	popup (c: ERROR_POPUPER; s: STRING; extra_message: STRING) is
		require
			valid_c: c /= Void;
			valid_s: s /= Void;
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
		local
			tmp: STRING
		do
			caller := c;
			if extra_message = Void then
		   		tmp := s;
			else
		   		tmp := clone (s);
				tmp.replace_substring_all ("%%X", extra_message)
			end;
			set_message (tmp);
			old_popup
		end;

	make (a_parent: COMPOSITE) is
		local
			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			error_d_create (Widget_names.error_window, a_parent);
			set_title (Widget_names.error_window);
			hide_help_button;
			hide_cancel_button;
			set_exclusive_grab;
			add_ok_action (Current, Void);
			!! set_dialog_att;
			set_dialog_att.execute (Current);
		end;

feature 

	error_string: STRING is
		once
			!! Result.make (0);
		end;

	put_string (an_error: STRING) is
		do
			error_string.append (an_error);
		end;

	put_clickable_string (a: ANY; s: STRING) is
		do
			error_string.append (s)
		end;

	new_line is
		do
			error_string.extend ('%N')
		end;

	put_char (c: CHARACTER) is
		do
			error_string.extend (c)
		end;

	put_int (i: INTEGER) is
		do
			error_string.append_integer (i);
		end;

	clear is
		do
			error_string.wipe_out
		end;

	display_error_message is
		do
			caller := Void;
			set_message (clone (error_string));
			error_string.wipe_out;
			old_popup;
		end;

feature {NONE}

	execute (argument: ANY) is
		do
			popdown;
			if caller /= Void then
				caller.continue_after_popdown (Current, True)		
			end
		end

end

