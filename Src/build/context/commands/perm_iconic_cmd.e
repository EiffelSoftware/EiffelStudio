
class PERM_ICONIC_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.perm_wind_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_perm_iconic_cmd_name
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
