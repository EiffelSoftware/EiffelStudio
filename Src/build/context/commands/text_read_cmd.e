
class TEXT_READ_CMD 

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
			Result := Command_names.cont_text_read_cmd_name
		end;

	context: TEXT_C;

	old_is_read_only: BOOLEAN;

	context_work is
		do
			old_is_read_only := context.is_read_only;
		end;

	context_undo is
		local
			new_is_read_only: BOOLEAN;
		do
			new_is_read_only := context.is_read_only;
			context.set_read_only (old_is_read_only);
			old_is_read_only := new_is_read_only;
		end;

end
