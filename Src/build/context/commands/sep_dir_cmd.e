
class SEP_DIR_CMD 

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
			S_ep_dir_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := separator_form_number
		end;

	context: SEPARATOR_C;

	old_is_vertical: BOOLEAN;

	context_work is
		do
			old_is_vertical := context.is_vertical;
		end;

	context_undo is
		local
			new_is_vertical: BOOLEAN;
		do
			new_is_vertical := context.is_vertical;
			context.set_vertical (old_is_vertical);
			old_is_vertical := new_is_vertical;
		end;

end
