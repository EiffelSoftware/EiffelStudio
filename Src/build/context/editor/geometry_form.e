
class GEOMETRY_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			form_name
		end


creation

	make

	
feature 

	form_name: STRING is
			-- Name of the form in the menu
		do
			Result := G_eometry_form_name;
		end;

	
feature {NONE}

	text_field_x: INTEGER_TEXT_FIELD;

	text_field_y: INTEGER_TEXT_FIELD;

	text_field_width: INTEGER_TEXT_FIELD;

	text_field_height: INTEGER_TEXT_FIELD;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, geometry_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			label_x: LABEL_G;
			label_y: LABEL_G;
			label_width: LABEL_G;
			label_height: LABEL_G;
		do
			initialize (G_eometry_form_name, a_parent);

			!!label_x.make (X_string, Current);
			!!label_y.make (Y_string, Current);
			!!label_width.make (W_idth, Current);
			!!label_height.make (H_eight, Current);

			!!text_field_x.make (T_extfield, Current, set_position_cmd, a_parent);
			!!text_field_y.make (T_extfield, Current, set_position_cmd, a_parent);
			!!text_field_width.make (T_extfield, Current, set_size_cmd, a_parent);
			!!text_field_height.make (T_extfield, Current, set_size_cmd, a_parent);

			text_field_x.set_width (50);
			text_field_y.set_width (50);
			text_field_width.set_width (50);
			text_field_height.set_width (50);

			attach_left (label_x, 20);
			attach_right (text_field_x, 20);
			attach_left (text_field_x, 200);

			attach_left (label_y, 20);
			attach_right (text_field_y, 20);
			attach_left (text_field_y, 200);

			attach_left (label_width, 20);
			attach_right (text_field_width, 20);
			attach_left (text_field_width, 200);

			attach_left (label_height, 20);
			attach_right (text_field_height, 20);
			attach_left (text_field_height, 200);
	
			attach_top (text_field_x, 10);
			attach_top (label_x, 10);
			attach_top_widget (text_field_x, text_field_y, 10);
			attach_top_widget (text_field_x, label_y, 10);
			attach_top_widget (text_field_y, text_field_width, 10);
			attach_top_widget (text_field_y, label_width, 10);
			attach_top_widget (text_field_width, text_field_height, 10);
			attach_top_widget (text_field_width, label_height, 10);
			detach_bottom (text_field_height);
			detach_bottom (label_height);
		end;

	
feature {NONE}

	reset is
		do
			text_field_x.set_int_value (context.x);
			text_field_y.set_int_value (context.y);
			text_field_width.set_int_value (context.width);
			text_field_height.set_int_value (context.height);
		end;

	
feature 

	apply is
--		local
--			attach: FORM_ATTACHMENTS;
		do
			if not text_field_x.same_value (context.x) or else
				not text_field_y.same_value (context.y) then
				context.set_x_y (text_field_x.int_value, text_field_y.int_value);
			end;
			if not text_field_width.same_value (context.width) or else
				not text_field_height.same_value (context.height) then
				context.set_size (text_field_width.int_value, text_field_height.int_value);
			end;
--			attach := context.attachments;
--			if not attach.Void then
--				attach.attach_top (attach.top_context, attach.top_offset);
--			end;
		end;

end
