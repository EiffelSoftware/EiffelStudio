indexing
	description: "Page representing the PRIMITIVE widgets."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PRIMITIVE_PAGE 

inherit

	CONTEXT_CAT_PAGE
	CONSTANTS

creation

	make

feature 

	push_b_type: CONTEXT_TYPE
	toggle_b_type: CONTEXT_TYPE
	text_field_type: CONTEXT_TYPE
	label_type: CONTEXT_TYPE
	separator_type: CONTEXT_TYPE
	separator_c: SEPARATOR_C
	pict_color_b_type: CONTEXT_TYPE
	arrow_b_type: CONTEXT_TYPE
	scroll_list_type: CONTEXT_TYPE
	scale_type: CONTEXT_TYPE

feature {NONE}

	build_interface is
		local
			push_b_c: PUSH_B_C
			text_field_c: TEXT_FIELD_C
			label_c: LABEL_C
			toggle_b_c: TOGGLE_B_C
			pict_color_c: PICT_COLOR_C
			arrow_b_c: ARROW_B_C
			scale_c: SCALE_C

			push_b: FOCUSABLE_PUSH_B
			text_field: FOCUSABLE_TEXT_FIELD
			label: FOCUSABLE_LABEL
			toggle_b: FOCUSABLE_TOGGLE_B
			pict_color_b: CONTEXT_TYPE_BUTTON
			arrow_up: FOCUSABLE_ARROW_B
			arrow_down: FOCUSABLE_ARROW_B
			arrow_left: FOCUSABLE_ARROW_B
			arrow_right: FOCUSABLE_ARROW_B
			scale: FOCUSABLE_SCALE

			sep_single: FOCUSABLE_SEPARATOR
			sep_double: FOCUSABLE_SEPARATOR
			sep_single_dashed: FOCUSABLE_SEPARATOR
			sep_double_dashed: FOCUSABLE_SEPARATOR
			v_sep_single: FOCUSABLE_SEPARATOR
			v_sep_double: FOCUSABLE_SEPARATOR
			v_sep_single_dashed: FOCUSABLE_SEPARATOR
			v_sep_double_dashed: FOCUSABLE_SEPARATOR
			vertical_separator_type: CONTEXT_TYPE
		do
			!! push_b_c
			!! push_b.make (push_b_c.eiffel_type, Current)
			push_b.set_focus_string (push_b_c.full_type_name)
			!! push_b_type.make (Widget_names.push_b_name, push_b_c)
			push_b_type.initialize_callbacks (push_b)

			!! label_c
			!! label.make (label_c.eiffel_type, Current)
			label.set_left_alignment
			label.set_text (label_c.eiffel_type)
			label.set_focus_string (label_c.full_type_name)
			!! label_type.make (Widget_names.label_name, label_c)
			label_type.initialize_callbacks (label)

			!! text_field_c
			!! text_field.make (text_field_c.eiffel_type, Current)
			text_field.set_text ("TEXT_FIELD")
			text_field.set_focus_string (text_field_c.full_type_name)
			!! text_field_type.make (Widget_names.text_field_name, text_field_c)
			text_field.set_focus_string (text_field_c.full_type_name)
			text_field_type.initialize_callbacks (text_field)

			!! toggle_b_c
			!! toggle_b.make (toggle_b_c.eiffel_type, Current)
			toggle_b.set_focus_string (toggle_b_c.full_type_name)
			!! toggle_b_type.make (Widget_names.toggle_b_name, toggle_b_c)
			toggle_b_type.initialize_callbacks (toggle_b)

			!! pict_color_c
			!! pict_color_b.make (pict_color_c.eiffel_type, Current)
			pict_color_b.set_pixmap (Pixmaps.pict_color_b_pixmap)
			pict_color_b.set_focus_string (pict_color_c.full_type_name)
			!! pict_color_b_type.make (Widget_names.pict_color_name, pict_color_c)
			pict_color_b_type.initialize_callbacks (pict_color_b)

			!! arrow_b_c
			!! arrow_up.make (arrow_b_c.eiffel_type, Current)
			arrow_up.set_up
			arrow_up.set_focus_string (arrow_b_c.full_type_name)
			arrow_b_c.set_direction (Context_const.up_arrow_direction)
			!! arrow_b_type.make (Widget_names.arrow_b_name, arrow_b_c)
			arrow_b_type.initialize_callbacks (arrow_up)

			!! arrow_b_c
			!! arrow_down.make (arrow_b_c.eiffel_type, Current)
			arrow_down.set_down
			arrow_down.set_focus_string (arrow_b_c.full_type_name)
			arrow_b_c.set_direction (Context_const.down_arrow_direction)
			!! arrow_b_type.make (Widget_names.arrow_b_name, arrow_b_c)
			arrow_b_type.initialize_callbacks (arrow_down)

			!! arrow_b_c
			!! arrow_left.make (arrow_b_c.eiffel_type, Current)
			arrow_left.set_left
			arrow_b_c.set_direction (Context_const.left_arrow_direction)
			arrow_left.set_focus_string (arrow_b_c.full_type_name)
			!! arrow_b_type.make (Widget_names.arrow_b_name, arrow_b_c)
			arrow_b_type.initialize_callbacks (arrow_left)

			!! arrow_b_c
			!! arrow_right.make (arrow_b_c.eiffel_type, Current)
			arrow_right.set_right
			arrow_right.set_focus_string (arrow_b_c.full_type_name)
			arrow_b_c.set_direction (Context_const.right_arrow_direction)
			!! arrow_b_type.make (Widget_names.arrow_b_name, arrow_b_c)
			arrow_b_type.initialize_callbacks (arrow_right)

			sep_single := create_separator (False, Context_const.single_line)
			sep_double := create_separator (False, Context_const.double_line)
			sep_single_dashed := create_separator (False, Context_const.single_dashed_line)
			sep_double_dashed := create_separator (False, Context_const.double_dashed_line)
			v_sep_single := create_separator (True, Context_const.single_line)
			v_sep_double := create_separator (True, Context_const.double_line)
			v_sep_single_dashed := create_separator (True, Context_const.single_dashed_line)
			v_sep_double_dashed := create_separator (True, Context_const.double_dashed_line)

			!! scale_c
			!! scale.make (scale_c.eiffel_type, Current)
			scale.show_value (true)
			scale.set_size (15, 80)
			scale.set_text (scale_c.eiffel_type)
			scale.set_focus_string (scale_c.full_type_name)
			!! scale_type.make (Widget_names.scale_name, scale_c)
			scale_type.initialize_callbacks (scale)

			-- ***************
			-- * Attachments *
			-- ***************

			attach_left (push_b_type.source, 1)
			attach_left_widget (push_b_type.source, label, 10)
			attach_left_widget (label, text_field, 10)
			attach_right (text_field, 1)

			attach_left (toggle_b, 1)
			attach_left_widget (toggle_b, pict_color_b, 10)

			attach_left (arrow_up, 1)
			attach_left (arrow_left, 1)
			attach_left_widget (arrow_up, arrow_right, 0)
			attach_left_widget (arrow_down, arrow_left, 0)

			attach_left_widget (arrow_right, sep_single, 10)
			attach_left_widget (arrow_right, sep_double, 10)
			attach_left_widget (arrow_right, sep_single_dashed, 10)
			attach_left_widget (arrow_right, sep_double_dashed, 10)
			attach_left_widget (sep_single, v_sep_single, 10)
			attach_left_widget (v_sep_single, v_sep_double, 8)
			attach_left_widget (v_sep_double, v_sep_single_dashed, 8)
			attach_left_widget (v_sep_single_dashed, v_sep_double_dashed, 8)
			attach_left_widget (v_sep_double_dashed, scale, 10)
			attach_right (scale, 10)

			attach_top (push_b_type.source, 1)
			attach_top (label, 1)
			attach_top (text_field, 1)

			attach_top_widget (push_b_type.source, toggle_b, 10)
			attach_top_widget (push_b_type.source, pict_color_b, 10)
			attach_top_widget (text_field, scale, 10)

			attach_top_widget (toggle_b, arrow_up, 15)
			attach_top_widget (toggle_b, arrow_right, 15)
			attach_top_widget (arrow_up, arrow_down, 0)
			attach_top_widget (arrow_right, arrow_left, 0)

			attach_top_widget (toggle_b, sep_single, 15)
			attach_top_widget (sep_single, sep_double, 6)
			attach_top_widget (sep_double, sep_single_dashed, 6)
			attach_top_widget (sep_single_dashed, sep_double_dashed, 6)
			attach_top_widget (toggle_b, v_sep_single, 15)
			attach_top_widget (toggle_b, v_sep_double, 15)
			attach_top_widget (toggle_b, v_sep_single_dashed, 15)
			attach_top_widget (toggle_b, v_sep_double_dashed, 15)

			button.set_focus_string (Focus_labels.primitives_label)
		end

	create_separator (vertical: BOOLEAN line_mode: INTEGER): FOCUSABLE_SEPARATOR is
		do
			!! separator_c
			!! Result.make (separator_c.eiffel_type, Current)
			Result.set_focus_string (separator_c.full_type_name)
			if vertical then
				separator_c.set_vertical (true)
				Result.set_size (5, 40)
				Result.set_horizontal (false)
			else
				Result.set_size (40, 5)
			end
			if (line_mode = Context_const.double_line) then 
				Result.set_double_line	
				separator_c.set_line (Context_const.double_line)
			elseif (line_mode = Context_const.single_dashed_line) then
				Result.set_single_dashed_line	
				separator_c.set_line (Context_const.single_dashed_line)
			elseif (line_mode = Context_const.double_dashed_line) then
				Result.set_double_dashed_line	
				separator_c.set_line (Context_const.double_dashed_line)
			end
			!! separator_type.make (Widget_names.separator_name, separator_c)
			separator_type.initialize_callbacks (Result)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.primitives_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.Selected_primitives_pixmap
		end
end
