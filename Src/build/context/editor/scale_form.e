
class SCALE_FORM 

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

	text: EB_TEXT_FIELD;

	is_value_shown: EB_TOGGLE_B;

	is_output_only: EB_TOGGLE_B;

	granularity: INTEGER_TEXT_FIELD;

	minimum: INTEGER_TEXT_FIELD;

	maximum: INTEGER_TEXT_FIELD;

	is_maximum_right_bottom: EB_TOGGLE_B;

	is_vertical: EB_TOGGLE_B;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, scale_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			text_l, granularity_l, min_l, max_l: LABEL_G;
		do
			initialize (Scale_form_name, a_parent);

			!!text.make (T_extfield, Current, scale_text_cmd, a_parent);
			!!granularity.make (T_extfield, Current, scale_gran_cmd, a_parent);
			!!minimum.make (T_extfield, Current, scale_min_cmd, a_parent);
			!!maximum.make (T_extfield, Current, scale_max_cmd, a_parent);
			!!is_value_shown.make (S_how_value, Current, scale_show_cmd, a_parent);
			!!is_output_only.make (O_utput_only, Current, scale_output_cmd, a_parent);
			!!is_maximum_right_bottom.make (M_aximum_right_bottom, Current, scale_max_right_cmd, a_parent);
			!!is_vertical.make (V_ertical, Current, scale_dir_cmd, a_parent);

			granularity.set_width (50);
			minimum.set_width (50);
			maximum.set_width (50);

			!!text_l.make (T_ext_label, Current);
			!!granularity_l.make (G_ranularity, Current);
			!!min_l.make (M_inimum, Current);
			!!max_l.make (M_aximum, Current);

			attach_left (is_vertical, 10);
			attach_left (text_l, 10);
			attach_left (text, 150);
			attach_right (text, 10);
			attach_left (min_l, 10);
			attach_left (minimum, 200);
			attach_right (minimum, 10);
			attach_left (max_l, 10);
			attach_left (maximum, 200);
			attach_right (maximum, 10);
			attach_left (granularity_l, 10);
			attach_left (granularity, 200);
			attach_right (granularity, 10);
			attach_left (is_maximum_right_bottom, 10);
			attach_left (is_value_shown, 10);
			attach_left (is_output_only, 10);

			attach_top (is_vertical, 10);
			attach_top_widget (is_vertical, text, 10);
			attach_top_widget (is_vertical, text_l, 10);
			attach_top_widget (text, minimum, 10);
			attach_top_widget (text, min_l, 10);
			attach_top_widget (minimum, maximum, 10);
			attach_top_widget (minimum, max_l, 10);
			attach_top_widget (maximum, granularity, 10);
			attach_top_widget (maximum, granularity_l, 10);
			attach_top_widget (granularity, is_maximum_right_bottom, 10);
			attach_top_widget (is_maximum_right_bottom, is_value_shown, 10);
			attach_top_widget (is_value_shown, is_output_only, 10);
			detach_bottom (is_output_only);
		end;

	
feature {NONE}

	context: SCALE_C;

	reset is
			-- reset the content of the form
		do
			is_vertical.set_state (context.is_vertical);
			--is_maximum_right_bottom.set_state (context.is_maximum_right_bottom);
			--is_value_shown.set_state (context.is_value_shown);
			is_output_only.set_state (context.is_output_only);
			if not (context.text = Void) then
				text.set_text (context.text);
			else
				text.set_text ("");
			end;
			minimum.set_int_value (context.minimum);
			maximum.set_int_value (context.maximum);
			granularity.set_int_value (context.granularity);
		end;

	
feature 

	apply is
			-- update the context according to the content of the form
		do
			if context.is_vertical /= is_vertical.state then
				context.set_vertical (is_vertical.state);
			end;
			--if context.is_maximum_right_bottom /= is_maximum_right_bottom.state then
				--context.set_maximum_right_bottom (is_maximum_right_bottom.state);
			--end;
			--if context.is_value_shown /= is_value_shown.state then
				--context.show_value (is_value_shown.state);
			--end;
			--if context.is_output_only /= is_output_only.state then
				--context.set_output_only (is_output_only.state);
			--end;
			if not equal (text.text, context.text) then
				context.set_text (text.text);
			end;
			if not minimum.same_value (context.minimum) then
				context.set_minimum (minimum.int_value);
			end;
			if not maximum.same_value (context.maximum) then
				context.set_maximum (maximum.int_value);
			end;
			if not granularity.same_value (context.granularity) then
				context.set_granularity (granularity.int_value);
			end;
		end;

end
