
class FONT_FORM 

inherit

	EDITOR_OK_FORM

creation

	make

feature {NONE} -- Interface

	font_b: FONT_BOX;

	form_number: INTEGER is
		do
			Result := Context_const.font_form_nbr
		end;

	format_number: INTEGER is
		do
			Result := Context_const.font_format_nbr
		end;

	command: FONT_CMD is
		once
			!! Result
		end;

feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			font_stone: FONT_STONE;
			reset_button: PUSH_B;
			reset_font_cmd: RESET_FONT_CMD
		do
			initialize (Widget_names.font_form_name, a_parent);
			create_ok_button;
			!! font_b.make (Widget_names.font_box_name, Current);
			font_b.hide_ok_button;
			font_b.hide_cancel_button;
			font_b.hide_apply_button;

			!!font_stone.make (Current, editor);
			!!reset_button.make (Widget_names.reset_font_name, Current);
			attach_left (font_b, 1);
			attach_right (font_b, 1);
			attach_top (font_b, 1);
			attach_bottom_widget (separator, font_b, 1);

			attach_right (font_stone, 20);
			attach_right_widget (font_stone, reset_button, 0);
			attach_bottom (font_stone, 10);
			attach_bottom (reset_button, 10);
			attach_bottom_widget (font_stone, separator, 5);
			attach_bottom_widget (reset_button, separator, 5);
			attach_left_position (reset_button, 7);
			detach_top (reset_button);
			detach_top (font_stone);
			detach_top (separator);
			detach_left (font_stone);
			!! reset_font_cmd;
			reset_button.add_activate_action (reset_font_cmd, editor);
			show_current;
				-- Shake font box so it will
				-- resize correctly.
			font_b.set_height (font_b.height + 1);
		end;
	
feature {NONE}

	reset is
		local
			font: FONT;
		do
			font := context.font;
			if font /= Void and then font.name /= Void then
				font_b.set_font (font);
			end;
		end;

feature 

	apply is
		do
			context.set_font_named (font_b.font.name);
		end;

end
