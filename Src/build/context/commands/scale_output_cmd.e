
class SCALE_OUTPUT_CMD 

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
			S_cale_output_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scale_form_number
		end;

	context: SCALE_C;

	old_is_output_only: BOOLEAN;

	context_work is
		do
			old_is_output_only := context.is_output_only;
		end;

	context_undo is
		local
			new_is_output_only: BOOLEAN;
		do
			new_is_output_only := context.is_output_only;
			context.set_output_only (old_is_output_only);
			old_is_output_only := new_is_output_only;
		end;

end
