class TEXT_FORM 

inherit

	CONTEXT_CMDS;
	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature

	width_text_field: INTEGER_TEXT_FIELD;

	height_text_field: INTEGER_TEXT_FIELD;

	maximum_size: INTEGER_TEXT_FIELD;

	read_only: EB_TOGGLE_B;

	enable_word_wrap: EB_TOGGLE_B;

	--enable_width_resize: EB_TOGGLE_B;

	--enable_height_resize: EB_TOGGLE_B;

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, text_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			size_l: LABEL_G;
			width_l, height_l: LABEL_G;
		do
			initialize (Text_form_name, a_parent);

			!!width_l.make (M_argin_width, Current);
			!!height_l.make (M_argin_height, Current);
			!!width_text_field.make (T_extfield, Current, text_width_cmd, a_parent);
			!!height_text_field.make (T_extfield, Current, text_height_cmd, a_parent);

			width_text_field.set_width (50);
			height_text_field.set_width (50);

			!!maximum_size.make (M_aximum_size, Current, text_max_cmd, a_parent);
			!!size_l.make (M_aximum_size, Current);
			maximum_size.set_width (50);

			!!read_only.make (R_ead_only, Current, text_read_cmd, a_parent);

			!!enable_word_wrap.make (E_nable_word_wrap, Current, text_wrap_cmd, a_parent);
			--!!enable_width_resize.make (W_idth_resizable, Current, text_w_resize_cmd, a_parent);
			--!!enable_height_resize.make (H_eight_resizable, Current, text_h_resize_cmd, a_parent);

			attach_left (size_l, 10);
			attach_left (maximum_size, 200);
			attach_right (maximum_size, 10);
			attach_left (read_only, 10);

			attach_left (enable_word_wrap, 10);
			--attach_left (enable_width_resize, 10);
			--attach_left (enable_height_resize, 10);

			attach_left (width_l, 10);
			attach_left (width_text_field, 200);
			attach_right (width_text_field, 10);
			attach_left (height_l, 10);
			attach_left (height_text_field, 200);
			attach_right (height_text_field, 10);

			attach_top (size_l, 15);
			attach_top (maximum_size, 10);
			--attach_top_widget (read_only, size_l, 10);
			--attach_top_widget (read_only, maximum_size, 10);
			attach_top_widget (maximum_size, width_l, 10);
			attach_top_widget (maximum_size, width_text_field, 10);
			attach_top_widget (width_text_field, height_l, 10);
			attach_top_widget (width_text_field, height_text_field, 10);
			attach_top_widget (height_text_field, read_only, 10);
			attach_top_widget (read_only, enable_word_wrap, 10);
			--attach_top_widget (enable_word_wrap, enable_width_resize, 10);
			--attach_top_widget (enable_width_resize, enable_height_resize, 10);
			--detach_bottom (enable_height_resize);
			detach_bottom (enable_word_wrap);
		end;

	context: TEXT_C;

	reset is
			-- reset the content of the form
		do
			maximum_size.set_int_value (context.maximum_size);
			read_only.set_state (context.is_read_only);
			enable_word_wrap.set_state (context.is_word_wrap_enable);
			--enable_width_resize.set_state (context.is_width_resizable);
			--enable_height_resize.set_state (context.is_height_resizable);
			width_text_field.set_int_value (context.margin_width);
			height_text_field.set_int_value (context.margin_height);
		end;

	apply is
			-- update the context according to the content of the form
		do
			if not maximum_size.same_value (context.maximum_size) then
				context.set_maximum_size (maximum_size.int_value);
			end;
			if context.is_read_only /= read_only.state then
				context.set_read_only (read_only.state);
			end;
			if context.is_word_wrap_enable /= enable_word_wrap.state then
				context.enable_word_wrap (enable_word_wrap.state);
			end;
			--if context.is_width_resizable /= enable_width_resize.state then
			--	context.enable_resize_height (enable_height_resize.state);
			--end;
			--if context.is_height_resizable /= enable_height_resize.state then
			--	context.enable_resize_width (enable_width_resize.state);
			--end;
			if not width_text_field.same_value (context.margin_width) then
				context.set_margin_width (width_text_field.int_value);
			end;
			if not height_text_field.same_value (context.margin_height) then
				context.set_margin_height (height_text_field.int_value);
			end;
		end;

end
