
class ERROR_BOX 

inherit

	COMMAND;
	CONSTANTS;
	WINDOWS
	
feature {NONE}

	caller: ERROR_POPUPER;
	
feature 

	is_popped_up: BOOLEAN is
		do
			Result := error_d /= Void
		end;

	popup (c: ERROR_POPUPER; s: STRING; extra_message: STRING) is
		require
			valid_c: c /= Void;
			valid_parent_comp: c.popuper_parent /= Void;
			valid_s: s /= Void;
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
		local
			tmp: STRING
		do
			make (c.popuper_parent);
			caller := c;
			if extra_message = Void then
		   		tmp := s;
			else
		   		tmp := clone (s);
				tmp.replace_substring_all ("%%X", extra_message)
			end;
			error_d.set_message (tmp);
			error_d.popup
		end;

	error_d: ERROR_D;

	make (a_parent: COMPOSITE) is
		local
			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			!! error_d.make (Widget_names.error_window, a_parent);
			error_d.set_title (Widget_names.error_window);
			error_d.hide_help_button;
			error_d.hide_cancel_button;
			error_d.set_exclusive_grab;
			error_d.add_ok_action (Current, Current);
			!! set_dialog_att;
			set_dialog_att.execute (error_d);
			error_d.set_action ("<Unmap>", Current, Void);
		end;

	popdown is
		do
			if error_d /= Void then 
				error_d.popdown
			end
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

	display_error_message (c: ERROR_POPUPER) is
		require
			valid_c: c /= Void;
			valid_parent_comp: c.popuper_parent /= Void;
		do
			make (c.popuper_parent);
			error_d.set_message (clone (error_string));
			error_string.wipe_out;
			caller := Void;
			error_d.popup
		end;

feature {NONE}

	execute (argument: ANY) is
		do
			if error_d /= Void then
				error_d.popdown;
				error_d.destroy;
				error_d := Void;
			end
			if caller /= Void then
				caller.continue_after_error_popdown;
			end;
		end

end

