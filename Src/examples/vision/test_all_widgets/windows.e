
class WINDOWS

inherit

	GRAPHICS
		redefine
			init_toolkit
		end

	ENUMS

feature

	a_screen: SCREEN is
			-- Screen associated with
			-- program
		once
			!!Result.make ("");
		end;

	init_toolkit: TOOLKIT_IMP is
			-- Toolkit for the program
		once
			!!Result.make ("");
		end;

	init_windowing is
			-- Initialize the toolkit.
			-- (force call to once routines).
		do
			if (init_toolkit = Void) then end;
			if (toolkit = Void) then end;
		end;

	main_window: MAIN_WINDOW is
			-- Main window of the demo
		once
			!!Result.make ("Widgets demo", a_screen)
		end;

	actions_window: ACTIONS_WINDOW is
			-- actions window (only standard actions)
		once
			!!Result.make ("Actions", main_window);
		end;

	button_actions_window: BUTTON_ACTIONS_WINDOW is
		once
			!!Result.make ("Push_b Actions", main_window)
			Result.set_title("Push_b Actions")
		end

	label_actions_window: LABEL_ACTIONS_WINDOW is
		once
			!!Result.make ("Label Actions", main_window)
			Result.set_title("Label Actions")
		end

	pict_color_actions_window: PICT_COLOR_ACTIONS_WINDOW is
		once
			!!Result.make ("Pict_Color_Actions", main_window)
			Result.set_title("Pict_color_button Actions")
		end

	scale_actions_window: SCALE_ACTIONS_WINDOW is
		once
			!!Result.make ("Scale Actions", main_window)
			Result.set_title("Scale Actions")
		end

	scroll_list_actions_window: SCROLL_LIST_ACTIONS_WINDOW is
		once
			!!Result.make ("Scroll_list Actions", main_window)
			Result.set_title("Scroll_list Actions")
		end

	scrollbar_actions_window: SCROLLBAR_ACTIONS_WINDOW is
		once
			!!Result.make ("Scrollbar Actions", main_window)
			Result.set_title("Scrollbar Actions")
		end

	scrolled_t_actions_window: SCROLLED_T_ACTIONS_WINDOW is
		once
			!!Result.make ("Scrolled_t Actions", main_window)
			Result.set_title("Scrolled_t Actions")
		end

	separator_actions_window: SEPARATOR_ACTIONS_WINDOW is
		once
			!!Result.make ("Separator Actions", main_window)
			Result.set_title("Separator Actions")
		end

	text_actions_window: TEXT_ACTIONS_WINDOW is
		once
			!!Result.make("Text Actions", main_window)
			Result.set_title("Text Actions")
		end

	text_field_actions_window: TEXT_FIELD_ACTIONS_WINDOW is
		once
			!!Result.make ("Text_field Actions", main_window)
			Result.set_title("Text_field Actions")
		end

	toggle_actions_window: TOGGLE_ACTIONS_WINDOW is
		once
			!!Result.make ("Toggle_b Actions", main_window)
			Result.set_title ("Toggle_b Actions")
		end

	bulletin_d_actions_window: BULLETIN_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Bulletin_d Actions", main_window)
			Result.set_title ("Bulletin_d Actions")
		end

	prompt_d_actions_window: PROMPT_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Prompt_d Actions", main_window)
			Result.set_title ("Prompt_d Actions")
		end

	file_sel_d_actions_window: FILE_SEL_D_ACTIONS_WINDOW is
		once
			!!Result.make ("File_sel_d Actions", main_window)
			Result.set_title ("File_sel_d Actions")
		end

	form_d_actions_window: FORM_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Form_d Actions", main_window)
			Result.set_title ("Form_d Actions")
		end

	font_box_d_actions_window: FONT_BOX_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Font_box_d Actions", main_window)
			Result.set_title ("Font_box_d Actions")
		end

	message_d_actions_window: MESSAGE_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Message_d Actions", main_window)
			Result.set_title ("Message_d Actions")
		end

	error_d_actions_window: ERROR_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Error_d Actions", main_window)
			Result.set_title ("Error_d Actions")
		end

	info_d_actions_window: INFO_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Info_d Actions", main_window)
			Result.set_title ("Info_d Actions")
		end

	question_d_actions_window: QUESTION_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Question_d Actions", main_window)
			Result.set_title ("Question_d Actions")
		end

	warning_d_actions_window: WARNING_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Warning_d Actions", main_window)
			Result.set_title ("Warning_d Actions")
		end

	working_d_actions_window: WORKING_D_ACTIONS_WINDOW is
		once
			!!Result.make ("Working_d Actions", main_window)
			Result.set_title ("Working_d Actions")
		end

	bulletin_demo_window: BULLETIN_DEMO_WINDOW is
		once
			!!Result.make ("Bulletin demo", main_window)
			Result.set_title("Bulletin demo")
			demo_window_array.put (Result, b_bulletin)
		end

	form_demo_window: FORM_DEMO_WINDOW is
		once
			!!Result.make ("Form demo", main_window)
			Result.set_title("Form demo")
			demo_window_array.put (Result, b_form)
		end

	radio_box_demo_window: RADIO_BOX_DEMO_WINDOW is
		once
			!!Result.make ("Radio_box demo", main_window)
			Result.set_title("Radio_box demo")
			demo_window_array.put (Result, b_radio_box)
		end

	frame_demo_window: FRAME_DEMO_WINDOW is
		once
			!!Result.make ("Frame demo", main_window)
			Result.set_title("Frame demo")
			demo_window_array.put (Result, b_frame)
		end

	Scrolled_w_demo_window: SCROLLED_W_DEMO_WINDOW is
		once
			!!Result.make ("Scrolled window demo", main_window)
			Result.set_title("Scrolled window demo")
			demo_window_array.put (Result, b_scrolled_w)
		end

	menu_demo_window: MENU_DEMO_WINDOW is
		once
			!!Result.make ("Menu demo", main_window)
			Result.set_title ("Menu demo")
			demo_window_array.put (Result, b_menu)
		end

	opt_pull_demo_window: OPT_PULL_DEMO_WINDOW is
		once
			!!Result.make ("Option pull demo", main_window)
			Result.set_title ("Option_pull demo")
			demo_window_array.put (Result, b_option_pull)
		end

	separator_demo_window: SEPARATOR_DEMO_WINDOW is
		once
			!!Result.make ("Separator demo", main_window)
			Result.set_title ("Separator demo")
			demo_window_array.put (Result, b_separator)
		end

	scrollbar_demo_window: SCROLLBAR_DEMO_WINDOW is
		once
			!!Result.make ("Scrollbar demo", main_window)
			Result.set_title ("Scrollbar demo")
			demo_window_array.put (Result, b_scrollbar)
		end

	scale_demo_window: SCALE_DEMO_WINDOW is
		once
			!!Result.make ("Scale demo", main_window)
			Result.set_title ("Scale demo")
			demo_window_array.put (Result, b_scale)
		end

	pict_col_b_demo_window: PICT_COL_B_DEMO_WINDOW is
		once
			!!Result.make ("Pict_color_button demo", main_window)
			Result.set_title ("Pict_color_b demo")
			demo_window_array.put (Result, b_pict_color)
		end

	button_demo_window: BUTTON_DEMO_WINDOW is
		once
			!!Result.make ("Button demo", main_window)
			Result.set_title ("Push_b demo")
			demo_window_array.put (Result, b_push)
		end

	label_demo_window: LABEL_DEMO_WINDOW is
		once
			!!Result.make ("Label demo", main_window)
			Result.set_title ("Label demo")
			demo_window_array.put (Result, b_label)
		end

	draw_b_demo_window: DRAW_B_DEMO_WINDOW is
		once
			!!Result.make ("Draw button demo", main_window)
			Result.set_title ("Draw_b")
			demo_window_array.put (Result, b_draw)
		end

	toggle_demo_window: TOGGLE_DEMO_WINDOW is
		once
			!!Result.make ("Toggle demo", main_window)
			Result.set_title ("Toggle_b demo")
			demo_window_array.put (Result, b_toggle)
		end

	drawing_area_demo_window: DRAWING_AREA_DEMO_WINDOW is
		once
			!!Result.make ("Drawing area demo", main_window)
			Result.set_title ("Drawing_area demo")
			demo_window_array.put (Result, b_drawing_area)
		end

	scroll_list_demo_window: SCROLL_LIST_DEMO_WINDOW is
		once
			!!Result.make ("Scroll list demo", main_window)
			Result.set_title ("Scroll_list demo")
			demo_window_array.put (Result, b_scroll_list)
		end

	text_field_demo_window: TEXT_FIELD_DEMO_WINDOW is
		once
			!!Result.make ("Text field demo", main_window)
			Result.set_title ("Text_field demo")
			demo_window_array.put (Result, b_text_field)
		end

	text_demo_window: TEXT_DEMO_WINDOW is
		once
			!!Result.make ("Text demo", main_window)
			Result.set_title ("Text demo")
			demo_window_array.put (Result, b_text)
		end

	scrolled_t_demo_window: SCROLLED_T_DEMO_WINDOW is
		once
			!!Result.make ("Scrolled text demo", main_window)
			Result.set_title ("Scrolled_t demo")
			demo_window_array.put (Result, b_scrolled_t)
		end

	bulletin_d_demo_window: BULLETIN_D_DEMO_WINDOW is
		once
			!!Result.make ("Bulletin_d demo", main_window)
			Result.set_title ("Bulletin_d demo")
			demo_window_array.put (Result, d_bulletin_d)
		end

	prompt_d_demo_window: PROMPT_D_DEMO_WINDOW is
		once
			!!Result.make ("Prompt_d demo", main_window)
			Result.set_title ("Prompt_d demo")
			demo_window_array.put (Result, d_prompt_d)
		end

	file_sel_d_demo_window: FILE_SEL_D_DEMO_WINDOW is
		once
			!!Result.make ("File_sel_d demo", main_window)
			Result.set_title ("File_sel_d demo")
			demo_window_array.put (Result, d_file_sel_d)
		end

	form_d_demo_window: FORM_D_DEMO_WINDOW is
		once
			!!Result.make ("Form_d demo", main_window)
			Result.set_title ("Form_d demo")
			demo_window_array.put (Result, d_form_d)
		end

	font_box_d_demo_window: FONT_BOX_D_DEMO_WINDOW is
		once
			!!Result.make ("Font_box_d demo", main_window)
			Result.set_title ("Font_box_d demo")
			demo_window_array.put (Result, d_font_box_d)
		end

	message_d_demo_window: MESSAGE_D_DEMO_WINDOW is
		once
			!!Result.make ("Message_d demo", main_window)
			Result.set_title ("Message_d demo")
			demo_window_array.put (Result, d_message_d)
		end

	error_d_demo_window: ERROR_D_DEMO_WINDOW is
		once
			!!Result.make ("Error_d demo", main_window)
			Result.set_title ("Error_d demo")
			demo_window_array.put (Result, d_error_d)
		end

	info_d_demo_window: INFO_D_DEMO_WINDOW is
		once
			!!Result.make ("Info_d demo", main_window)
			Result.set_title ("Info_d demo")
			demo_window_array.put (Result, d_info_d)
		end

	question_d_demo_window: QUESTION_D_DEMO_WINDOW is
		once
			!!Result.make ("Question_d demo", main_window)
			Result.set_title ("Question_d demo")
			demo_window_array.put (Result, d_question_d)
		end

	warning_d_demo_window: WARNING_D_DEMO_WINDOW is
		once
			!!Result.make ("Warning_d demo", main_window)
			Result.set_title ("Warning_d demo")
			demo_window_array.put (Result, d_warning_d)
		end

	working_d_demo_window: WORKING_D_DEMO_WINDOW is
		once
			!!Result.make ("Working_d demo", main_window)
			Result.set_title ("Working_d demo")
			demo_window_array.put (Result, d_working_d)
		end

	demo_window_array: ARRAY [ANY_DEMO_WINDOW] is
		once
			!!Result.make (1, 35)
		end

	md: MESSAGE_D is
		once
			!!Result.make ("Message Dialog", main_window)
			Result.set_title("Message")
			Result.hide_cancel_button
			Result.hide_help_button
			Result.allow_resize
		end

	prompt: PROMPT_D is
		once
			!!Result.make ("Prompt Dialog", main_window)
			Result.set_title("Input")
			Result.hide_help_button
			Result.hide_apply_button
			Result.allow_resize
		end

	font_box: FONT_BOX_D is
		once
			!!Result.make ("Select Font", main_window)
			Result.set_title ("Select Font")
			Result.hide_apply_button
		end

end -- class WINDOWS


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

