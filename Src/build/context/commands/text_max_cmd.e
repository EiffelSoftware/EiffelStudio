
class TEXT_MAX_CMD 

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
			T_ext_max_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
		end;

	context: TEXT_C;

	old_maximum_size: INTEGER;

	context_work is
		do
			old_maximum_size := context.maximum_size;
		end;

	context_undo is
		local
			new_maximum_size: INTEGER;
		do
			new_maximum_size := context.maximum_size;
			context.set_maximum_size (old_maximum_size);
			old_maximum_size := new_maximum_size;
		end;

end
