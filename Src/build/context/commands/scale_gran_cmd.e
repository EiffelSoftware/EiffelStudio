
class SCALE_GRAN_CMD 

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
			Result := Command_names.cont_scale_gran_cmd_name
		end;

	context: SCALE_C;

	old_granularity: INTEGER;

	context_work is
		do
			old_granularity := context.granularity;
		end;

	context_undo is
		local
			new_granularity: INTEGER;
		do
			new_granularity := context.granularity;
			context.set_granularity (old_granularity);
			old_granularity := new_granularity;
		end;

end
