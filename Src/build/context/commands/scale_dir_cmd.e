
class SCALE_DIR_CMD 

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
			Result := Context_const.scale_dir_cmd_name
		end;

	context: SCALE_C;

	old_is_vertical: BOOLEAN;

	context_work is
		do
			old_is_vertical := context.is_vertical;
		end;

	context_undo is
		local
			new_is_vertical: BOOLEAN;
		do
			new_is_vertical := context.is_vertical;
			context.set_vertical (old_is_vertical);
			old_is_vertical := new_is_vertical;
		end;

end
