
class DRAWING_BOX_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature 

	make_visible (a_parent: COMPOSITE) is
		local
			label_width: LABEL_G;
			label_height: LABEL_G;
		do
			initialize (Widget_names.drawing_box_form_name, a_parent);

			!!label_width.make (Widget_names.drawing_area_width_name, Current);
			!!label_height.make (Widget_names.drawing_area_height_name, Current);

			!!text_field_width.make (Widget_names.textfield, 
					Current, Drawing_box_cmd, editor);
			!!text_field_height.make (Widget_names.textfield, 
					Current, Drawing_box_cmd, editor);
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
			show_current
		end;

	
feature {NONE}

	text_field_width: INTEGER_TEXT_FIELD;

	text_field_height: INTEGER_TEXT_FIELD;

	context: DR_AREA_C is
		do
			Result ?= editor.edited_context
		end;

	form_number: INTEGER is
		do
			Result := Context_const.drawing_box_att_form_nbr
		end;

	drawing_box_cmd: DR_BOX_CMD is
		once
			!! Result
		end;

	reset is
		do
			text_field_width.set_int_value (context.drawing_area_width);
			text_field_height.set_int_value (context.drawing_area_height);
		end;

	apply is
		do
			if not text_field_width.same_value (context.drawing_area_width) or else
				not text_field_height.same_value (context.drawing_area_height) then
				context.set_drawing_area_size (text_field_width.int_value, 
					text_field_height.int_value);
			end;
		end;

end
