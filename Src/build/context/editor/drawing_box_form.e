
class DRAWING_BOX_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			context
		end


creation

	make

	
feature {NONE}

	context: DR_AREA_C;

	text_field_width: INTEGER_TEXT_FIELD;

	text_field_height: INTEGER_TEXT_FIELD;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, drawing_box_form_number);
		end;

	
feature {NONE}

	drawing_box_cmd: DR_BOX_CMD is
		once
			!!Result
		end;

	
feature 

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			label_width: LABEL_G;
			label_height: LABEL_G;
		do
			initialize (G_eometry_form_name, a_parent);

			!!label_width.make (D_rawing_area_width, Current);
			!!label_height.make (D_rawing_area_height, Current);

			!!text_field_width.make (T_extfield, Current, drawing_box_cmd, a_parent);
			!!text_field_height.make (T_extfield, Current, drawing_box_cmd, a_parent);

			text_field_width.set_width (50);
			text_field_height.set_width (50);

			attach_left (label_width, 20);
			attach_right (text_field_width, 20);
			attach_left (text_field_width, 200);

			attach_left (label_height, 20);
			attach_right (text_field_height, 20);
			attach_left (text_field_height, 200);
	
			attach_top (text_field_width, 10);
			attach_top (label_width, 10);
			attach_top_widget (text_field_width, text_field_height, 10);
			attach_top_widget (text_field_width, label_height, 10);
			detach_bottom (text_field_height);
			detach_bottom (label_height);
		end;

	
feature {NONE}

	reset is
		do
			text_field_width.set_int_value (context.drawing_area_width);
			text_field_height.set_int_value (context.drawing_area_height);
		end;

	
feature 

	apply is
		do
			if not text_field_width.same_value (context.drawing_area_width) or else
				not text_field_height.same_value (context.drawing_area_height) then
				context.set_drawing_area_size (text_field_width.int_value, text_field_height.int_value);
			end;
		end;

end
