
class GEOMETRY_FORM 

inherit

	EDITOR_FORM

creation

	make

feature {NONE}

	text_field_x: INTEGER_TEXT_FIELD

	text_field_y: INTEGER_TEXT_FIELD

	text_field_width: INTEGER_TEXT_FIELD

	text_field_height: INTEGER_TEXT_FIELD

	form_number: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.geometry_format_nbr
		end

	Set_position_cmd: SET_POSITION_CMD is
		once
			!! Result
		end

	Set_size_cmd: SET_SIZE_CMD is
		once
			!! Result
		end

feature 

	context_width: INTEGER is
		do
			Result := text_field_width.int_value
		end

	context_height: INTEGER is
		do
			Result := text_field_height.int_value
		end

	context_x: INTEGER is
		do
			Result := text_field_x.int_value
		end

	context_y: INTEGER is
		do
			Result := text_field_y.int_value
		end

	label_height: LABEL

	label_width: LABEL

	label_x: LABEL

	label_y: LABEL

	make_visible (a_parent: COMPOSITE) is
		do
			initialize (Widget_names.geometry_form_name, a_parent)

			!! label_x.make (Widget_names.X_string_name, Current)
			!! label_y.make (Widget_names.Y_string_name, Current)
			!! label_width.make (Widget_names.width_name, Current)
			!! label_height.make (Widget_names.height_name, Current)

			!! text_field_x.make (Widget_names.textfield, 
					Current, Set_position_cmd, editor)
			!! text_field_y.make (Widget_names.textfield, 
					Current, Set_position_cmd, editor)
			!! text_field_width.make (Widget_names.textfield, 
					Current, Set_size_cmd, editor)
			!! text_field_height.make (Widget_names.textfield, 
					Current, Set_size_cmd, editor)

			text_field_x.set_width (50)
			text_field_y.set_width (50)
			text_field_width.set_width (50)
			text_field_height.set_width (50)

			attach_left (label_x, 2)
			attach_left (label_width, 2)

			attach_right_widget (text_field_x, label_x, 5)
			attach_right_widget (label_y, text_field_x, 10)
			attach_right_widget (text_field_y, label_y,5)
			attach_right_widget (text_field_width, label_width,5)
			attach_right_widget (label_height, text_field_x, 10)
			attach_right_widget (label_height, text_field_width, 10)
			attach_right_widget (text_field_height, label_height,5)

			attach_right (text_field_height, 20)	
			attach_right (text_field_y, 20)

			attach_top (text_field_x, 10)
			attach_top (label_x, 10)
			attach_top (text_field_y, 10)
			attach_top (label_y, 10)

			attach_top_widget (text_field_x, text_field_width, 10)
			attach_top_widget (text_field_x, label_width, 10)
			attach_top_widget (text_field_y, text_field_height, 10)
			attach_top_widget (text_field_y, label_height, 10)
			detach_bottom (text_field_height)
			detach_bottom (label_height)
			show_current
		end

feature

	reset is
		do
			if context.is_movable then
				if text_field_x.int_value /= context.x then
					text_field_x.set_int_value (context.x)
				end
				if not text_field_x.managed then
					label_x.manage
					text_field_x.manage
				end
				if text_field_y.int_value /= context.y then
					text_field_y.set_int_value (context.y)
				end
				if not text_field_y.managed then
					text_field_y.manage
					label_y.manage
				end
			else
				if text_field_x.managed then
					text_field_x.unmanage
					label_x.unmanage
				end
				if text_field_y.managed then
					text_field_y.unmanage
					label_y.unmanage
				end
			end
			if context.is_resizable then
				if text_field_width.int_value /= context.width then
					text_field_width.set_int_value (context.width)
				end
				if not text_field_width.managed then
					text_field_width.manage
					label_width.manage
				end
				if text_field_height.int_value /= context.height then
					text_field_height.set_int_value (context.height)
				end
				if not text_field_height.managed then
					text_field_height.manage
					label_height.manage
				end
			else
				if text_field_width.managed then
					text_field_width.unmanage
					label_width.unmanage
				end
				if text_field_height.managed then
					text_field_height.unmanage
					label_height.unmanage
				end
			end
		end

	
feature 

	apply is
		do
			if not text_field_x.same_value (context.x) or else
				not text_field_y.same_value (context.y) then
				context.set_x_y (text_field_x.int_value, text_field_y.int_value)
			end
			if (text_field_width.int_value > 0 and then text_field_height.int_value > 0) and then
				(not text_field_width.same_value (context.width) or else
				not text_field_height.same_value (context.height))
			then
				context.set_size (text_field_width.int_value, text_field_height.int_value)
			end
		end

end
