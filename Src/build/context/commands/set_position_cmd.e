
class SET_POSITION_CMD 

inherit

	CONTEXT_CMD
	
		
feature {NONE} --Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_set_position_cmd_name
		end;

	old_x: INTEGER;

	old_y: INTEGER;

	context_work is
		do
			old_x := context.x;
			old_y := context.y;
		end;

	context_undo is
		local
			new_x, new_y: INTEGER
		do
			new_x := context.x;
			new_y := context.y;
			context.set_x_y (old_x, old_y);
			old_x := new_x;
			old_y := new_y;
		end;

end
