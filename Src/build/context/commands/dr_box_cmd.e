
class DR_BOX_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.drawing_box_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_drawing_box_cmd_name
		end;

	context: DR_AREA_C;

	old_width: INTEGER;

	old_height: INTEGER;

	context_work is
		do
			old_width := context.drawing_area_width;
			old_height := context.drawing_area_height;
		end;

	context_undo is
		local
			new_width: INTEGER;
			new_height: INTEGER;
		do
			new_width := context.drawing_area_width;
			new_height := context.drawing_area_height;
			context.set_drawing_area_size (old_width, old_height);
			old_width := new_width;
			old_height := new_height;
		end;

end
