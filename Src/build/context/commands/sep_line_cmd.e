
class SEP_LINE_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.separator_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.sep_line_cmd_name
		end;

	context: SEPARATOR_C;

	old_line_mode: INTEGER;

	context_work is
		do
			old_line_mode := context.line_mode;
		end;

	context_undo is
		local
			new_mode: INTEGER;
		do
			new_mode := context.line_mode;
			context.set_line (old_line_mode);
			old_line_mode := new_mode;
		end;

end
