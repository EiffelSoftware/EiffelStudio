
class SEP_LINE_CMD 

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
			S_ep_line_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := separator_form_number
		end;

	context: SEPARATOR_C;

	old_line_mode: INTEGER;

	context_work is
		do
			old_line_mode := context.line_mode;
		end;

	context_undo is
		local
			new_mode: INTEGER;
		do
			new_mode := context.line_mode;
			context.set_line (old_line_mode);
			old_line_mode := new_mode;
		end;

end
