
class DR_BOX_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			D_rawing_box_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := drawing_box_form_number
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
