
class SCALE_MIN_CMD 

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
			S_cale_min_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scale_form_number
		end;

	context: SCALE_C;

	old_minimum: INTEGER;

	context_work is
		do
			old_minimum := context.minimum;
		end;

	context_undo is
		local
			new_minimum: INTEGER;
		do
			new_minimum := context.minimum;
			context.set_minimum (old_minimum);
			old_minimum := new_minimum;
		end;

end
