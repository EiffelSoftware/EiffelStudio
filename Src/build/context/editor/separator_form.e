
class SEPARATOR_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			context
		end;
	SEPARATOR_CONST


creation

	make

	
feature {NONE}

	is_vertical: EB_TOGGLE_B;

	b_no_line, b_single_line, b_double_line: EB_TOGGLE_B;
	b_single_dashed_line, b_double_dashed_line: EB_TOGGLE_B;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, separator_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			line_style: LABEL_G;
			radio_b: RADIO_BOX
		do
			initialize (Separator_form_name, a_parent);

			!!is_vertical.make (V_ertical, Current, sep_dir_cmd, a_parent);
			!!line_style.make (L_ine_style, Current);
			!!radio_b.make (R_ow_column, Current);
			!!b_single_line.make (S_ingle, radio_b, sep_line_cmd, a_parent);
			!!b_single_dashed_line.make (S_ingle_dashed, radio_b, sep_line_cmd, a_parent);
			!!b_double_line.make (D_ouble, radio_b, sep_line_cmd, a_parent);
			!!b_double_dashed_line.make (D_ouble_dashed, radio_b, sep_line_cmd, a_parent);
			!!b_no_line.make (N_o_line, radio_b, sep_line_cmd, a_parent);

			attach_left (is_vertical, 10);
			attach_left (line_style, 10);
			attach_left (radio_b, 100);
			attach_right (radio_b, 10);

			attach_top (is_vertical, 10);
			attach_top_widget (is_vertical, line_style, 10);
			attach_top_widget (is_vertical, radio_b, 10);
			attach_bottom (radio_b, 50);
		end;

	
feature {NONE}

	context: SEPARATOR_C;

	reset is
		do
			is_vertical.set_state (context.is_vertical);
			inspect
				context.line_mode
			when no_line then
				b_no_line.arm
			when double_line then
				b_double_line.arm
			when single_dashed_line then
				b_single_dashed_line.arm
			when double_dashed_line then
				b_double_dashed_line.arm
			else
				b_single_line.arm
			end;
		end;

	
feature 

	apply is
		do
			if context.is_vertical /= is_vertical.state then
				context.set_size (context.height, context.width);
				context.set_vertical (is_vertical.state);
			end;
			if new_mode /= context.line_mode then
				context.set_line (new_mode);
			end;
		end;

	
feature {NONE}

	new_mode: INTEGER is
		do
			if b_no_line.state then
				Result := context.no_line
			elseif b_single_line.state then
				Result := context.single_line
			elseif b_double_line.state then
				Result := context.double_line
			elseif b_single_dashed_line.state then
				Result := context.single_dashed_line
			else
				Result := context.double_dashed_line
			end;
		end;

end
