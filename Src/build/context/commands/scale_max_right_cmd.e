
class SCALE_MAX_RIGHT_CMD 

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
			S_cale_max_right_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scale_form_number
		end;

	context: SCALE_C;

	old_is_maximum_right_bottom: BOOLEAN;

	context_work is
		do
			old_is_maximum_right_bottom := context.is_maximum_right_bottom;
		end;

	context_undo is
		local
			new_is_maximum_right_bottom: BOOLEAN;
		do
			new_is_maximum_right_bottom := context.is_maximum_right_bottom;
			context.set_maximum_right_bottom (old_is_maximum_right_bottom);
			old_is_maximum_right_bottom := new_is_maximum_right_bottom;
		end;

end
