-- The main-window

class MAIN_WINDOW

inherit

	BASE
		rename
			make as base_make
		undefine
			init_toolkit
		end;

	WINDOWS
	ENUMS

creation

	make

feature

	bulletin: BULLETIN;

	exit_b,
	bulletin_b, form_b, radio_box_b, frame_b, scrolled_w_b,
	menu_b, option_pull_b, separator_b,
	scrollbar_b, scale_b, pict_color_b, push_b, label_b,
	draw_b, toggle_b, drawing_area_b, scroll_list_b,
	text_field_b, text_b, scrolled_t_b,
	bulletin_d_b, form_d_b, prompt_d_b, font_box_d_b,
	message_d_b, error_d_b, question_d_b, info_d_b, working_d_b,
	warning_d_b, file_sel_d_b: MAIN_WINDOW_BUTTON;

	make(a_name: STRING; a_s: SCREEN) is
	do
		current_demo:=no_demo
		base_make (a_name, a_s);
		!!bulletin.make ("bulletin", Current)
		!!exit_b.associate (Current, b_exit, "Exit", 150, 20)
		!!bulletin_b.associate (Current, b_bulletin, "Bulletin", 20, 60)
		!!form_b.associate (Current, b_form, "Form", 20, 100)
		!!radio_box_b.associate (Current, b_radio_box, "Radio_box", 20, 140)
		!!frame_b.associate (Current, b_frame, "Frame", 20, 180)
		!!scrolled_w_b.associate (Current, b_scrolled_w, "Scrolled_w", 20, 220)
		!!menu_b.associate (Current, b_menu, "Menu", 20, 260)
		!!option_pull_b.associate (Current, b_option_pull, "Option_pull", 20, 300)
		!!separator_b.associate (Current, b_separator, "Separator", 20, 340)
		!!scroll_list_b.associate (Current, b_scroll_list, "Scroll_list", 20, 380)
		!!scrolled_t_b.associate (Current, b_scrolled_t, "Scrolled_t", 20, 420)

		!!scrollbar_b.associate (Current, b_scrollbar, "Scrollbar", 150, 60)
		!!scale_b.associate (Current, b_scale, "Scale", 150, 100)
		!!pict_color_b.associate (Current, b_pict_color, "Pict_color_b", 150, 140)
		!!push_b.associate (Current, b_push, "Push_b", 150, 180)
		!!label_b.associate (Current, b_label, "Label", 150, 220)
		!!draw_b.associate (Current, b_draw, "Draw_b", 150, 260)
		!!toggle_b.associate (Current, b_toggle, "Toggle_b", 150, 300)
		!!drawing_area_b.associate (Current, b_drawing_area, "Drawing_area", 150, 340)
		!!text_field_b.associate (Current, b_text_field, "Text_field", 150, 380)
		!!text_b.associate (Current, b_text, "Text", 150, 420)

		!!bulletin_d_b.associate (Current, b_bulletin_d, "Bulletin_d", 280, 60)
		!!form_d_b.associate (Current, b_form_d, "Form_d", 280, 100)
		!!prompt_d_b.associate (Current, b_prompt_d, "Prompt_d", 280, 140)
		!!font_box_d_b.associate (Current, b_font_box_d, "Font_box_d", 280, 180)
		!!message_d_b.associate (Current, b_message_d, "Message_d", 280, 220)
		!!error_d_b.associate (Current, b_error_d, "Error_d", 280, 260)
		!!question_d_b.associate (Current, b_question_d, "Question_d", 280, 300)
		!!info_d_b.associate (Current, b_info_d, "Info_d", 280, 340)
		!!working_d_b.associate (Current, b_working_d, "Working_d", 280, 380)
		!!warning_d_b.associate (Current, b_warning_d, "Warning_d", 280, 420)
		!!file_sel_d_b.associate (Current, b_file_sel_d, "File_sel_d", 280, 460)
		set_size (400, 510);
	end; -- make

	current_demo: INTEGER;

	work (arg: INTEGER_REF) is
	do
		if arg.item = b_exit then	-- exit application
			exit
		elseif current_demo = no_demo
		then
			inspect arg.item
			when b_bulletin then
				actions_window.popup
				current_demo:= b_bulletin
				actions_window.set_title("Bulletin Actions")
				bulletin_demo_window.popup
			when b_form then
				actions_window.popup
				current_demo:= b_form
				actions_window.set_title("Form Actions")
				form_demo_window.popup
			when b_radio_box then
				actions_window.popup
				current_demo:= b_radio_box
				actions_window.set_title("Radio_box Actions")
				radio_box_demo_window.popup
			when b_frame then
				actions_window.popup
				current_demo:= b_frame
				actions_window.set_title("Frame Actions")
				frame_demo_window.popup
			when b_scrolled_w then
				actions_window.popup
				current_demo:= b_scrolled_w
				actions_window.set_title("Scrolled_w Actions")
				scrolled_w_demo_window.popup
			when b_menu then
				actions_window.popup
				current_demo:= b_menu
				actions_window.set_title("Menu Actions")
				menu_demo_window.popup
			when b_option_pull then
				actions_window.popup
				current_demo:= b_option_pull
				actions_window.set_title("Option_pull Actions")
				opt_pull_demo_window.popup
			when b_separator then
				separator_actions_window.popup
				current_demo:=b_separator
				separator_demo_window.popup
			when b_scrollbar then
				scrollbar_actions_window.popup
				current_demo:=b_scrollbar
				scrollbar_demo_window.popup
			when b_scale then
				scale_actions_window.popup
				current_demo:=b_scale
				scale_demo_window.popup
			when b_pict_color then
				pict_color_actions_window.popup
				current_demo:=b_pict_color
				pict_col_b_demo_window.popup
			when b_push then
				button_actions_window.popup
				current_demo:=b_push
				button_demo_window.popup
			when b_label then
				label_actions_window.popup
				current_demo:=b_label
				label_demo_window.popup
			when b_draw then
				actions_window.popup
				current_demo:= b_draw
				actions_window.set_title("Draw_b Actions")
				draw_b_demo_window.popup
			when b_toggle then
				toggle_actions_window.popup
				current_demo:=b_toggle
				toggle_demo_window.popup
			when b_drawing_area then
				actions_window.popup
				current_demo:= b_drawing_area
				actions_window.set_title("Drawing_area Actions")
				drawing_area_demo_window.popup
			when b_scroll_list then
				scroll_list_actions_window.popup
				current_demo:=b_scroll_list
				scroll_list_demo_window.popup
			when b_text_field then
				text_field_actions_window.popup
				current_demo:=b_text_field
				text_field_demo_window.popup
			when b_text then
				text_actions_window.popup
				current_demo:=b_text
				text_demo_window.popup
			when b_scrolled_t then
				scrolled_t_actions_window.popup
				current_demo:=b_scrolled_t
				scrolled_t_demo_window.popup
			when b_bulletin_d then
				bulletin_d_actions_window.popup
				current_demo:=d_bulletin_d
				bulletin_d_demo_window.popup
			when b_form_d then
				form_d_actions_window.popup
				current_demo:=d_form_d
				form_d_demo_window.popup
			when b_prompt_d then
				prompt_d_actions_window.popup
				current_demo:=d_prompt_d
				prompt_d_demo_window.popup
			when b_font_box_d then
				font_box_d_actions_window.popup
				current_demo:=d_font_box_d
				font_box_d_demo_window.popup
			when b_message_d then
				message_d_actions_window.popup
				current_demo:=d_message_d
				message_d_demo_window.popup
			when b_error_d then
				error_d_actions_window.popup
				current_demo:=d_error_d
				error_d_demo_window.popup
			when b_info_d then
				info_d_actions_window.popup
				current_demo:=d_info_d
				info_d_demo_window.popup
			when b_question_d then
				question_d_actions_window.popup
				current_demo:=d_question_d
				question_d_demo_window.popup
			when b_working_d then
				working_d_actions_window.popup
				current_demo:=d_working_d
				working_d_demo_window.popup
			when b_warning_d then
				warning_d_actions_window.popup
				current_demo:=d_warning_d
				warning_d_demo_window.popup
			when b_file_sel_d then
				file_sel_d_actions_window.popup
				current_demo:=d_file_sel_d
				file_sel_d_demo_window.popup
			else
			end
			if current_demo /= no_demo then
				bulletin_b.set_insensitive
				form_b.set_insensitive
				radio_box_b.set_insensitive
				frame_b.set_insensitive
				scrolled_w_b.set_insensitive
				menu_b.set_insensitive
				option_pull_b.set_insensitive
				separator_b.set_insensitive
				scrollbar_b.set_insensitive
				scale_b.set_insensitive
				pict_color_b.set_insensitive
				push_b.set_insensitive
				label_b.set_insensitive
				draw_b.set_insensitive
				toggle_b.set_insensitive
				drawing_area_b.set_insensitive
				scroll_list_b.set_insensitive
				text_field_b.set_insensitive
				text_b.set_insensitive
				scrolled_t_b.set_insensitive
				bulletin_d_b.set_insensitive
				form_d_b.set_insensitive
				prompt_d_b.set_insensitive
				font_box_d_b.set_insensitive
				message_d_b.set_insensitive
				error_d_b.set_insensitive
				question_d_b.set_insensitive
				info_d_b.set_insensitive
				working_d_b.set_insensitive
				warning_d_b.set_insensitive
				file_sel_d_b.set_insensitive
			end
		end
	end -- work

	finish is
	local
		dialog: DIALOG
	do
		if demo_window_array.valid_index (current_demo) then
			dialog ?= demo_window_array.item (current_demo)
			dialog.popdown
		end
		current_demo:=no_demo
		if not bulletin_demo_window.main_widget.destroyed then
			bulletin_b.set_sensitive
		end
		if not form_demo_window.main_widget.destroyed then
			form_b.set_sensitive
		end
		if not radio_box_demo_window.main_widget.destroyed then
			radio_box_b.set_sensitive
		end
		if not frame_demo_window.main_widget.destroyed then
			frame_b.set_sensitive
		end
		if not scrolled_w_demo_window.main_widget.destroyed then
			scrolled_w_b.set_sensitive
		end
		if not menu_demo_window.main_widget.destroyed then
			menu_b.set_sensitive
		end
		if not opt_pull_demo_window.main_widget.destroyed then
			option_pull_b.set_sensitive
		end
		if not separator_demo_window.main_widget.destroyed then
			separator_b.set_sensitive
		end
		if not scrollbar_demo_window.main_widget.destroyed then
			scrollbar_b.set_sensitive
		end
		if not scale_demo_window.main_widget.destroyed then
			scale_b.set_sensitive
		end
		if not pict_col_b_demo_window.main_widget.destroyed then
			pict_color_b.set_sensitive
		end
		if not button_demo_window.main_widget.destroyed then
			push_b.set_sensitive
		end
		if not label_demo_window.main_widget.destroyed then
			label_b.set_sensitive
		end
		if not draw_b_demo_window.main_widget.destroyed then
			draw_b.set_sensitive
		end
		if not toggle_demo_window.main_widget.destroyed then
			toggle_b.set_sensitive
		end
		if not drawing_area_demo_window.main_widget.destroyed then
			drawing_area_b.set_sensitive
		end
		if not scroll_list_demo_window.main_widget.destroyed then
			scroll_list_b.set_sensitive
		end
		if not text_field_demo_window.main_widget.destroyed then
			text_field_b.set_sensitive
		end
		if not text_demo_window.main_widget.destroyed then
			text_b.set_sensitive
		end
		if not scrolled_t_demo_window.main_widget.destroyed then
			scrolled_t_b.set_sensitive
		end
		if not bulletin_d_demo_window.main_widget.destroyed then
			bulletin_d_b.set_sensitive
		end
		if not form_d_demo_window.main_widget.destroyed then
			form_d_b.set_sensitive
		end
		if not prompt_d_demo_window.main_widget.destroyed then
			prompt_d_b.set_sensitive
		end
		if not font_box_d_demo_window.main_widget.destroyed then
			font_box_d_b.set_sensitive
		end
		if not message_d_demo_window.main_widget.destroyed then
			message_d_b.set_sensitive
		end
		if not error_d_demo_window.main_widget.destroyed then
			error_d_b.set_sensitive
		end
		if not question_d_demo_window.main_widget.destroyed then
			question_d_b.set_sensitive
		end
		if not info_d_demo_window.main_widget.destroyed then
			info_d_b.set_sensitive
		end
		if not working_d_demo_window.main_widget.destroyed then
			working_d_b.set_sensitive
		end
		if not warning_d_demo_window.main_widget.destroyed then
			warning_d_b.set_sensitive
		end
		if not file_sel_d_demo_window.main_widget.destroyed then
			file_sel_d_b.set_sensitive
		end
	end; -- finish

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

