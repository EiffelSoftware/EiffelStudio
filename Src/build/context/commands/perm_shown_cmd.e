
class PERM_SHOWN_CMD 

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
			Result := Command_names.cont_perm_shown_cmd_name
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
