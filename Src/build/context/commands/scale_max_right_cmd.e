
class SCALE_MAX_RIGHT_CMD 

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
			Result := Command_names.cont_scale_max_right_cmd_name
		end;

	context: SCALE_C;

	old_is_maximum_right_bottom: BOOLEAN;

	context_work is
		do
			old_is_maximum_right_bottom := context.is_maximum_right_bottom;
		end;

	context_undo is
		local
			new_is_maximum_right_bottom: BOOLEAN;
		do
			new_is_maximum_right_bottom := context.is_maximum_right_bottom;
			context.set_maximum_right_bottom (old_is_maximum_right_bottom);
			old_is_maximum_right_bottom := new_is_maximum_right_bottom;
		end;

end
