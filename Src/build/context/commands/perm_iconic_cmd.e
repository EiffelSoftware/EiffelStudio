
class PERM_ICONIC_CMD 

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
			P_erm_iconic_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := perm_wind_form_number
		end;

	context: PERM_WIND_C;

	old_iconic_state: BOOLEAN;

	context_work is
		do
			old_iconic_state := context.is_iconic_state;
		end;

	context_undo is
		local
			new_iconic_state: BOOLEAN;
		do
			new_iconic_state := context.is_iconic_state;
			context.set_iconic_state (old_iconic_state);
			old_iconic_state := new_iconic_state;
		end;

end
