
class SET_SIZE_CMD 

inherit

	CONTEXT_CMD
		;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			S_et_size_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := geometry_form_number
		end;

	old_width: INTEGER;

	old_height: INTEGER;

	context_work is
		do
			old_width := context.width;
			old_height := context.height;
		end;

	context_undo is
		local
			new_w, new_h: INTEGER
		do
			new_w := context.width;
			new_h := context.height;
			context.set_size (old_width, old_height);
			old_width := new_w;
			old_height := new_h;
		end;

end
