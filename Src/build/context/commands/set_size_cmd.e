
class SET_SIZE_CMD 

inherit

	CONTEXT_CMD

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.set_size_cmd_name
		end;

	old_width: INTEGER;

	old_height: INTEGER;

	context_work is
		do
			old_width := context.width;
			old_height := context.height;
		end;

	context_undo is
		local
			new_w, new_h: INTEGER
		do
			new_w := context.width;
			new_h := context.height;
			context.set_size (old_width, old_height);
			old_width := new_w;
			old_height := new_h;
		end;

end
