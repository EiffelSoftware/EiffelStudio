
class SCALE_SHOW_CMD 

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
			S_cale_show_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scale_form_number
		end;

	context: SCALE_C;

	old_is_value_shown: BOOLEAN;

	context_work is
		do
			old_is_value_shown := context.is_value_shown;
		end;

	context_undo is
		local
			new_is_value_shown: BOOLEAN;
		do
			new_is_value_shown := context.is_value_shown;
			context.show_value (old_is_value_shown);
			old_is_value_shown := new_is_value_shown;
		end;

end
