
class ARROW_B_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			A_rrow_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := arrow_b_form_number
		end;

	context: ARROW_B_C;

	old_direction: INTEGER;

	context_work is
		do
			old_direction := context.direction;
		end;

	context_undo is
		local
			new_direction: INTEGER;
		do
			new_direction := context.direction;
			context.set_direction (old_direction);
			old_direction := new_direction
		end;

end
