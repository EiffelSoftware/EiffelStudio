class TOGGLE_ARM_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;

feature {NONE}

	associated_form: INTEGER is
		do
			Result :=  Context_const.toggle_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_toggle_arm_cmd_name
		end;

	context: TOGGLE_B_C;

	old_armed: BOOLEAN;

	context_work is
		do
			old_armed := context.is_armed;
		end;

	context_undo is
		local
			new_armed: BOOLEAN;
		do
			new_armed := context.is_armed;
			context.set_is_armed (old_armed);
			old_armed := new_armed;
		end;

end
