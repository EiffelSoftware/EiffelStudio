
class SCALE_MIN_CMD 

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
			Result := Command_names.cont_scale_min_cmd_name
		end;

	context: SCALE_C;

	old_minimum: INTEGER;

	context_work is
		do
			old_minimum := context.minimum;
		end;

	context_undo is
		local
			new_minimum: INTEGER;
		do
			new_minimum := context.minimum;
			context.set_minimum (old_minimum);
			old_minimum := new_minimum;
		end;

end
