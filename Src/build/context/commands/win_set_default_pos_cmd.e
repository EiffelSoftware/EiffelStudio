
class WIN_SET_DEFAULT_POS_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end

feature {NONE}

	associated_form: INTEGER is
		do
			if context.is_perm_window then
				Result := Context_const.perm_wind_att_form_nbr
			else
				Result := Context_const.temp_wind_att_form_nbr
			end;
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_win_position_cmd_name
		end;

	context: WINDOW_C;

	old_default_state: BOOLEAN;

	context_work is
		do
			old_default_state := context.default_position;
		end;

	context_undo is
		local
			new_default_state: BOOLEAN;
		do
			new_default_state := context.default_position;
			context.set_default_position (old_default_state);
			old_default_state := new_default_state;
		end;

end
