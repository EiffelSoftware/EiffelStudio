
class SCALE_MAX_CMD 

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
			Result := Context_const.scale_max_cmd_name
		end;

	context: SCALE_C;

	old_maximum: INTEGER;

	context_work is
		do
			old_maximum := context.maximum;
		end;

	context_undo is
		local
			new_maximum: INTEGER;
		do
			new_maximum := context.maximum;
			context.set_maximum (old_maximum);
			old_maximum := new_maximum;
		end;

end
