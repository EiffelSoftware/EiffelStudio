
class TEXT_READ_CMD 

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
			T_ext_read_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
		end;

	context: TEXT_C;

	old_is_read_only: BOOLEAN;

	context_work is
		do
			old_is_read_only := context.is_read_only;
		end;

	context_undo is
		local
			new_is_read_only: BOOLEAN;
		do
			new_is_read_only := context.is_read_only;
			context.set_read_only (old_is_read_only);
			old_is_read_only := new_is_read_only;
		end;

end
