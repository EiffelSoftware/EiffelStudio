indexing
	description: "Page representing the properties of a SCROLLED_T."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEXT_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature {NONE}

	width_text_field: INTEGER_TEXT_FIELD

	height_text_field: INTEGER_TEXT_FIELD

	maximum_size: INTEGER_TEXT_FIELD

	read_only: EB_TOGGLE_B

	enable_word_wrap: EB_TOGGLE_B

	--enable_width_resize: EB_TOGGLE_B

	--enable_height_resize: EB_TOGGLE_B

	form_number: INTEGER is
		do
			Result := Context_const.text_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	context: TEXT_C is
		do
			Result ?= editor.edited_context
		end

	text_h_resize_cmd: TEXT_H_RESIZE_CMD is
		once
			!!Result
		end

	text_height_cmd: TEXT_HEIGHT_CMD is
		once
			!!Result
		end

	text_max_cmd: TEXT_MAX_CMD is
		once
			!!Result
		end

	text_read_cmd: TEXT_READ_CMD is
		once
			!!Result
		end

	text_w_resize_cmd: TEXT_W_RESIZE_CMD is
		once
			!!Result
		end

	text_width_cmd: TEXT_WIDTH_CMD is
		once
			!!Result
		end

	text_wrap_cmd: TEXT_WRAP_CMD is
		once
			!!Result
		end

feature

	make_visible (a_parent: COMPOSITE) is
		local
			size_l: LABEL
			width_l, height_l: LABEL
		do
			initialize (Widget_names.text_form_name, a_parent)

				--| Create widgets
			!!width_l.make (Widget_names.margin_width_name, Current)
			!!height_l.make (Widget_names.margin_height_name, Current)
			!!width_text_field.make (Widget_names.textfield, Current, 
				Text_width_cmd, editor)
			!!height_text_field.make (Widget_names.textfield, Current, 
				Text_height_cmd, editor)
			!!maximum_size.make (Widget_names.maximum_size_name, 
					Current, Text_max_cmd, editor)
			!!size_l.make (Widget_names.maximum_size_name, Current)
			!!read_only.make (Widget_names.read_only_name, 
					Current, Text_read_cmd, editor)

			!!enable_word_wrap.make (Widget_names.enable_word_wrap_name, 
					Current, Text_wrap_cmd, editor)

				--| Set values
			maximum_size.set_width (50)
			width_text_field.set_width (50)
			height_text_field.set_width (50)


				--| Perform attachments
			attach_left (size_l, 10)
			attach_right_widget (maximum_size, size_l, 5)
			attach_right (maximum_size, 10)

			attach_left (read_only, 10)
			attach_left (enable_word_wrap, 10)

			attach_left (width_l, 10)
			attach_right_widget (width_text_field, width_l, 5)
			attach_right (width_text_field, 10)

			attach_left (height_l, 10)
			attach_right_widget (height_text_field, height_l, 5)
			attach_right (height_text_field, 10)

			attach_top (size_l, 15)
			attach_top (maximum_size, 10)
			attach_top_widget (maximum_size, width_l, 15)
			attach_top_widget (maximum_size, width_text_field, 10)
			attach_top_widget (width_text_field, height_l, 15)
			attach_top_widget (width_text_field, height_text_field, 10)
			attach_top_widget (height_l, read_only, 10)
			attach_top_widget (height_text_field, read_only, 10)
			attach_top_widget (read_only, enable_word_wrap, 10)
--			attach_bottom (enable_word_wrap, 0)
			show_current
		end


feature

	reset is
			-- reset the content of the form
		do
			maximum_size.set_int_value (context.maximum_size)
			read_only.set_state (context.is_read_only)
			enable_word_wrap.set_state (context.is_word_wrap_enable)
			--enable_width_resize.set_state (context.is_width_resizable)
			--enable_height_resize.set_state (context.is_height_resizable)
			width_text_field.set_int_value (context.margin_width)
			height_text_field.set_int_value (context.margin_height)
		end

	apply is
			-- update the context according to the content of the form
		do
			if not maximum_size.same_value (context.maximum_size) then
				context.set_maximum_size (maximum_size.int_value)
			end
			if context.is_read_only /= read_only.state then
				context.set_read_only (read_only.state)
			end
			if context.is_word_wrap_enable /= enable_word_wrap.state then
				context.enable_word_wrap (enable_word_wrap.state)
			end
			--if context.is_width_resizable /= enable_width_resize.state then
			--	context.enable_resize_height (enable_height_resize.state)
			--end
			--if context.is_height_resizable /= enable_height_resize.state then
			--	context.enable_resize_width (enable_width_resize.state)
			--end
			if not width_text_field.same_value (context.margin_width) then
				context.set_margin_width (width_text_field.int_value)
			end
			if not height_text_field.same_value (context.margin_height) then
				context.set_margin_height (height_text_field.int_value)
			end
		end

end
