
class SCALE_OUTPUT_CMD 

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
			Result := Command_names.cont_scale_output_cmd_name
		end;

	context: SCALE_C;

	old_is_output_only: BOOLEAN;

	context_work is
		do
			old_is_output_only := context.is_output_only;
		end;

	context_undo is
		local
			new_is_output_only: BOOLEAN;
		do
			new_is_output_only := context.is_output_only;
			context.set_output_only (old_is_output_only);
			old_is_output_only := new_is_output_only;
		end;

end
