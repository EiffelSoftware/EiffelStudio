
class SET_POSITION_CMD 

inherit

	CONTEXT_CMD
		;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			S_et_position_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := geometry_form_number
		end;

	old_x: INTEGER;

	old_y: INTEGER;

	context_work is
		do
			old_x := context.x;
			old_y := context.y;
		end;

	context_undo is
		local
			new_x, new_y: INTEGER
		do
			new_x := context.x;
			new_y := context.y;
			context.set_x_y (old_x, old_y);
			old_x := new_x;
			old_y := new_y;
		end;

end
