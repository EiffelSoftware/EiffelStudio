
class TEXT_MAX_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.text_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_text_max_cmd_name
		end;

	context: TEXT_C;

	old_maximum_size: INTEGER;

	context_work is
		do
			old_maximum_size := context.maximum_size;
		end;

	context_undo is
		local
			new_maximum_size: INTEGER;
		do
			new_maximum_size := context.maximum_size;
			context.set_maximum_size (old_maximum_size);
			old_maximum_size := new_maximum_size;
		end;

end
