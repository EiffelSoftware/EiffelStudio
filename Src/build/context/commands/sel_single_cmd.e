
class SEL_SINGLE_CMD 

inherit

	CONTEXT_CMD
		redefine
			work
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			G_eometry_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := geometry_form_number
		end;

	old_x: INTEGER;

	old_y: INTEGER;

	old_width: INTEGER;

	old_height: INTEGER;

	
feature 

	work (argument: CONTEXT) is
		do
			context := argument;
			old_x := context.x;
			old_y := context.y;
			old_width := context.width;
			old_height := context.height;
		end;

	
feature {NONE}

	context_work is
		do
		end;

	context_undo is
		local
			new_x, new_y, new_w, new_h: INTEGER
		do
			new_x := context.x;
			new_y := context.y;
			new_w := context.width;
			new_h := context.height;
			if new_x /=old_x or new_y /= old_y then
				context.set_x_y (old_x, old_y);
				old_x := new_x;
				old_y := new_y;
			end;
			if new_w /= old_width or new_h /= old_height then
				context.set_size (old_width, old_height);
				old_width := new_w;
				old_height := new_h;
			end;
		end;

end
