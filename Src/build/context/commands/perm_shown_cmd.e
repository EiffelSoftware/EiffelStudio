
class PERM_SHOWN_CMD 

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
			P_erm_shown_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := perm_wind_form_number
		end;

	context: PERM_WIND_C;

	old_hidden: BOOLEAN;

	context_work is
		do
			old_hidden := context.start_hidden;
		end;

	context_undo is
		local
			new_hidden: BOOLEAN;
		do
			new_hidden := context.start_hidden;
			context.set_start_hidden (old_hidden);
			old_hidden := new_hidden;
		end;

end
