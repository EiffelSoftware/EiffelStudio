
class SCALE_SHOW_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.scale_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_scale_show_cmd_name
		end;

	context: SCALE_C;

	old_is_value_shown: BOOLEAN;

	context_work is
		do
			old_is_value_shown := context.is_value_shown;
		end;

	context_undo is
		local
			new_is_value_shown: BOOLEAN;
		do
			new_is_value_shown := context.is_value_shown;
			context.show_value (old_is_value_shown);
			old_is_value_shown := new_is_value_shown;
		end;

end
