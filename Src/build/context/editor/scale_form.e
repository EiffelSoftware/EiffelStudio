indexing
	description: "Page representing the properties of a SCALE."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SCALE_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make
	
feature {NONE}

	text: EB_TEXT_FIELD

	is_value_shown: EB_TOGGLE_B

	is_output_only: EB_TOGGLE_B

	granularity: INTEGER_TEXT_FIELD

	minimum: INTEGER_TEXT_FIELD

	maximum: INTEGER_TEXT_FIELD

	is_maximum_right_bottom: EB_TOGGLE_B

	is_vertical: EB_TOGGLE_B

	context: SCALE_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.scale_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	Scale_dir_cmd: SCALE_DIR_CMD is
		once
			!! Result
		end

	Scale_gran_cmd: SCALE_GRAN_CMD is
		once
			!! Result
		end

	Scale_max_cmd: SCALE_MAX_CMD is
		once
			!! Result
		end

	Scale_max_right_cmd: SCALE_MAX_RIGHT_CMD is
		once
			!! Result
		end

	Scale_min_cmd: SCALE_MIN_CMD is
		once
			!! Result
		end

	Scale_output_cmd: SCALE_OUTPUT_CMD is
		once
			!! Result
		end

	Scale_show_cmd: SCALE_SHOW_CMD is
		once
			!! Result
		end

	Scale_text_cmd: SCALE_TEXT_CMD is
		once
			!! Result
		end

feature 

	make_visible (a_parent: COMPOSITE) is
		local
			text_l, granularity_l, min_l, max_l: LABEL
		do
			initialize (Widget_names.scale_form_name, a_parent)

			!! text.make (Widget_names.textfield, Current, 
					Scale_text_cmd, editor)
			!! granularity.make (Widget_names.textfield, 
					Current, Scale_gran_cmd, editor)
			!! maximum.make (Widget_names.textfield, Current, 
					Scale_max_cmd, editor)
			!! minimum.make (Widget_names.textfield, Current, 
					Scale_min_cmd, editor)
			!! is_value_shown.make (Widget_names.show_value_name, 
					Current, Scale_show_cmd, editor)
			!! is_output_only.make (Widget_names.output_only_name, Current, 
					Scale_output_cmd, editor)
			!! is_maximum_right_bottom.make 
					(Widget_names.maximum_right_bottom_name, 
					Current, Scale_max_right_cmd, editor)
			!! is_vertical.make (Widget_names.vertical_name, Current, 
					Scale_dir_cmd, editor)

			text.set_width (50)
			granularity.set_width (50)
			maximum.set_width (50)
			minimum.set_width (50)

			!! text_l.make (Widget_names.text_label_name, Current)
			!! granularity_l.make (Widget_names.granularity_name, Current)
			!! min_l.make (Widget_names.minimum_name, Current)
			!! max_l.make (Widget_names.maximum_name, Current)

			attach_left (is_vertical, 10)

			attach_left (text_l, 10)
			attach_right_widget (text, text_l, 5)
			attach_right (text, 10)

			attach_left (min_l, 10)
			attach_right_widget (minimum, min_l, 5)
			attach_right (minimum, 10)

			attach_left (max_l, 10)
			attach_right_widget (maximum, max_l, 5)
			attach_right (maximum, 10)

			attach_left (granularity_l, 10)
			attach_right_widget (granularity, granularity_l, 5)
			attach_right (granularity, 10)

			attach_left (is_maximum_right_bottom, 10)
			attach_left (is_value_shown, 10)
			attach_left (is_output_only, 10)

			attach_top (is_vertical, 10)
			attach_top_widget (is_vertical, text, 10)
			attach_top_widget (is_vertical, text_l, 15)
			attach_top_widget (text, minimum, 10)
			attach_top_widget (text, min_l, 15)
			attach_top_widget (minimum, maximum, 10)
			attach_top_widget (minimum, max_l, 15)
			attach_top_widget (maximum, granularity, 10)
			attach_top_widget (maximum, granularity_l, 15)
			attach_top_widget (granularity, is_maximum_right_bottom, 0)
			attach_top_widget (is_maximum_right_bottom, is_value_shown, 0)
			attach_top_widget (is_value_shown, is_output_only, 0)
--			detach_bottom (is_output_only)
			show_current
		end

	
feature {NONE}

	reset is
			-- reset the content of the form
		do
			is_vertical.set_state (context.is_vertical)
			is_maximum_right_bottom.set_state (context.is_maximum_right_bottom)
			is_value_shown.set_state (context.is_value_shown)
			is_output_only.set_state (context.is_output_only)
			if not (context.text = Void) then
				text.set_text (context.text)
			else
				text.set_text ("")
			end
			minimum.set_int_value (context.minimum)
			maximum.set_int_value (context.maximum)
			granularity.set_int_value (context.granularity)
		end

	
feature 

	apply is
			-- update the context according to the content of the form
		do
			if context.is_vertical /= is_vertical.state then
				context.set_vertical (is_vertical.state)
			end
			if context.is_maximum_right_bottom /= is_maximum_right_bottom.state then
				context.set_maximum_right_bottom (is_maximum_right_bottom.state)
			end
			if context.is_value_shown /= is_value_shown.state then
				context.show_value (is_value_shown.state)
			end
			if context.is_output_only /= is_output_only.state then
				context.set_output_only (is_output_only.state)
			end
			if not equal (text.text, context.text) then
				context.set_text (text.text)
			end
			if not minimum.same_value (context.minimum) then
				context.set_minimum (minimum.int_value)
			end
			if not maximum.same_value (context.maximum) then
				context.set_maximum (maximum.int_value)
			end
			if not granularity.same_value (context.granularity) then
				context.set_granularity (granularity.int_value)
			end
		end

end
