
-- Implementation toolkit.

deferred class TOOLKIT

inherit

	CURSOR_TYPE
		export
			{NONE} all
		end

feature

	arrow_b (an_arrow_button: ARROW_B; managed: BOOLEAN): ARROW_B_I is
			-- Toolkit implementation of `an_arrow_button'
		deferred
		end; -- arrow_b

	base (a_base: BASE): BASE_I is
			-- Toolkit implementation of `a_base'
		deferred
		end;

	color (a_color: COLOR): COLOR_I is
			-- Toolkit implementation of `a_color'
		deferred
		end; -- color

	dialog_shell (a_dialog_shell: DIALOG_SHELL): DIALOG_S_I is
			-- Toolkit implementation of `a_dialog_shell'
		deferred
		end; -- dialog_shell

	exit is
			-- Exit from the application
		deferred
		end; -- exit

	font (a_font: FONT): FONT_I is
			-- Toolkit implementation of `a_font'
		deferred
		end; -- font

	font_box (a_font_box: FONT_BOX; managed: BOOLEAN): FONT_BOX_I is
			-- Toolkit implementation of `a_font_box'
		deferred
		end; -- font_box

	font_box_d (a_font_box_d: FONT_BOX_D): FONT_B_D_I is
			-- Toolkit implementation of `a_font_box_d'
		deferred
		end;

	global_cursor: SCREEN_CURSOR is
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.
		deferred
		end; -- global_cursor

	io_handler (an_io_handler: IO_HANDLER): IO_HANDLER_I is
			-- Toolkit implementation of `an_io_handler'
		deferred
		end; -- io_handler

	iterate is
			-- Loop the application.
		deferred
		end; -- iterate

	override_s (an_override_shell: OVERRIDE_S): OVERRIDE_S_I is
			-- Toolkit implementation of `an_override_shell'
		deferred
		end; -- override_s

	pict_color_b (a_picture_color_button: PICT_COLOR_B; managed: BOOLEAN): PICT_COL_B_I is
			-- Toolkit implementation of `a_picture_color_button'
		deferred
		end; -- pict_color_b

	pixmap (a_pixmap: PIXMAP): PIXMAP_I is
			-- Toolkit implementation of `a_pixmap'
		deferred
		end;

	--pointer (a_pointer: MOUSE_POINTER): MOUSE_POINTER_I is
	--	deferred
	--	end;

	restore_cursors is
			-- Restore the cursors as they were before `set_global_cursor'.
	   require
--			a_global_cursor_set_before: not (global_cursor = Void)
		deferred
		ensure
			no_global_cursor_anymore: (global_cursor = Void)
		end; -- restore_global_cursors

	screen (a_screen: SCREEN): SCREEN_I is
			-- Toolkit implementation of `a_screen'
		deferred
		end; -- screen

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_I is
			-- Toolkit implementation of `a_cursor'
		deferred
		end;

	set_global_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set a global cursor for the whole application.
			-- Warning: the effect of calling `set_type' on a SCREEN_CURSOR
			-- or `set_cursor' on a WIDGET is not defined.
			-- It depends on the specific implementation.
		require
			a_cursor_exists: not (a_cursor = Void);
			no_global_cursor_already_set: (global_cursor = Void)
		deferred
		ensure
			correctly_set: global_cursor = a_cursor
		end; -- set_global_cursor

	task (a_task: TASK): TASK_I is
			-- Toolkit implementation of `a_task'
		deferred
		end; -- task

	timer (a_timer: TIMER): TIMER_I is
			-- Toolkit implementation of `a_timer'
		deferred
		end;

	top_shell (a_top_shell: TOP_SHELL): TOP_SHELL_I is
			-- Toolkit implementation of `a_top_shell'
		deferred
		end;

	bar (a_bar: BAR; managed: BOOLEAN): BAR_I is
			-- Toolkit implementation of `a_bar'
		deferred
		end; -- bar

	bulletin (a_bulletin: BULLETIN; managed: BOOLEAN): BULLETIN_I is
			-- Toolkit implementation of `a_bulletin'
		deferred
		end; -- bulletin

	bulletin_d (a_bulletin_d: BULLETIN_D): BULLETIN_D_I is
			-- Toolkit implementation of `a_bulletin_d'
		deferred
		end; -- bulletin_d

	check_box (a_check_box: CHECK_BOX; managed: BOOLEAN): CHECK_BOX_I is
			-- Toolkit implementation of `a_check_box'
		deferred
		end;

	draw_b (a_draw_b: DRAW_B; managed: BOOLEAN): DRAW_B_I is
			-- Toolkit implementation of `a_draw_b'
		deferred
		end;

	drawing_area (a_drawing_area: DRAWING_AREA; managed: BOOLEAN): D_AREA_I is
			-- Toolkit implementation of `a_drawing_area'
		deferred
		end;

	error_d (an_error_dialog: ERROR_D): ERROR_D_I is
			-- Toolkit implementation of `an_error_dialog'
		deferred
		end; -- error_d

	file_sel_d (a_file_selec_dialog: FILE_SEL_D): FILE_SEL_D_I is
			-- Toolkit implementation of `a_file_selec_dialog'
		deferred
		end; -- file_sel_d

	file_selec (a_file_selection: FILE_SELEC; managed: BOOLEAN): FILE_SELEC_I is
			-- Toolkit implementation of `a_file_selection'
		deferred
		end; -- file_selec

	font_list (a_font_list: FONT_LIST): FONT_LIST_I is
			-- Toolkit implementation of `a_font_list'
		deferred
		end;

	form (a_form: FORM; managed: BOOLEAN): FORM_I is
			-- Toolkit implementation of `a_form'
		deferred
		end; -- form

	form_d (a_form_dialog: FORM_D): FORM_D_I is
			-- Toolkit implementation of `a_form_dialog'
		deferred
		end; -- form_d

	frame (a_frame: FRAME; managed: BOOLEAN): FRAME_I is
			-- Toolkit implementation of `a_frame'
		deferred
		end; -- frame

	info_d (an_information_dialog: INFO_D): INFO_D_I is
			-- Toolkit implementation of `an_information_dialog'
		deferred
		end; -- info_d

	label (a_label: LABEL; managed: BOOLEAN): LABEL_I is
			-- Toolkit implementation of `a_label'
		deferred
		end;

	label_g (a_label_gadget: LABEL; managed: BOOLEAN): LABEL_G_I is
			-- Toolkit implementation of `a_label_gadget'
		deferred
		end;

	menu_b (a_menu_b: MENU_B; managed: BOOLEAN): MENU_B_I is
			-- Toolkit implementation of `a_menu_b'
		deferred
		end; -- menu_b

	message (a_message: MESSAGE; managed: BOOLEAN): MESSAGE_I is
			-- Toolkit implementation of `a_message'
		deferred
		end; -- message

	message_d (a_message_dialog: MESSAGE_D): MESSAGE_D_I is
			-- Toolkit implementation of `a_message_dialog'
		deferred
		end; -- message_d

	option_b (an_option_button: OPTION_B; managed: BOOLEAN): OPTION_B_I is
			-- Toolkit implementation of `an_option_button'
		deferred
		end;

	popup (a_popup: POPUP): POPUP_I is
			-- Toolkit implementation of `a_popup'
		deferred
		end;

	prompt (a_prompt: PROMPT; managed: BOOLEAN): PROMPT_I is
			-- Toolkit implementation of `a_prompt'
		deferred
		end;

	prompt_d (a_prompt_dialog: PROMPT_D): PROMPT_D_I is
			-- Toolkit implementation of `a_prompt_dialog`
		deferred
		end; -- prompt_d

	menu_pull (a_new_pull: MENU_PULL; managed: BOOLEAN): MENU_PULL_I is
			-- Toolkit implementation of `a_new_pull'
		deferred
		end; -- menu_pull

	opt_pull (an_opt_pull: OPT_PULL; managed: BOOLEAN): OPT_PULL_I is
			-- Toolkit implementation of `an_opt_pull'
		deferred
		end; -- opt_pull

	push_b (a_push_b: PUSH_B; managed: BOOLEAN): PUSH_B_I is
			-- Toolkit implementation of `a_push_b'
		deferred
		end; -- push_b

	push_bg (a_push_b_gadget: PUSH_BG; managed: BOOLEAN): PUSH_BG_I is
			-- Toolkit implementation of `a_push_b_gadget'
		deferred
		end;

	question_d (a_question_dialog: QUESTION_D): QUESTION_D_I is
			-- Toolkit implementation of `a_question_dialog'
		deferred
		end;

	radio_box (a_radio_box: RADIO_BOX; managed: BOOLEAN): RADIO_BOX_I is
			-- Toolkit implementation of `a_radio_box'
		deferred
		end;

	row_column (a_row_column: ROW_COLUMN; managed: BOOLEAN): ROW_COLUMN_I is
			-- Toolkit implementation of `a_row_column'
		deferred
		end;

	scale (a_scale: SCALE; managed: BOOLEAN): SCALE_I is
			-- Toolkit implementation of `a_scale'
		deferred
		end;

	scroll_list (a_list: SCROLL_LIST; managed: BOOLEAN): SCROLL_L_I is
			-- Toolkit implementation of `a_list'
		deferred
		end;

	scrollbar (a_scrollbar: SCROLLBAR; managed: BOOLEAN): SCROLLBAR_I is
			-- Toolkit implementation of `a_scrollbar'
		deferred
		end;

	scrolled_t (a_scrolled_text: SCROLLED_T; managed: BOOLEAN): SCROLLED_T_I is
			-- Toolkit implementation of `a_scrolled_text'
		deferred
		end;

	scrolled_t_word_wrapped (a_scrolled_text: SCROLLED_T; managed: BOOLEAN): SCROLLED_T_I is
			-- Toolkit implementation of `a_scrolled_text'
		deferred
		end;

	scrolled_w (a_scrolled_window: SCROLLED_W; managed: BOOLEAN): SCROLLED_W_I is
			-- Toolkit implementation of `a_scrolled_window'
		deferred
		end;

	separator (a_separator: SEPARATOR; managed: BOOLEAN): SEPARATOR_I is
			-- Toolkit implementation of `a_separator'
		deferred
		end;

	separator_g (a_separator_gadget: SEPARATOR_G; managed: BOOLEAN): SEPARATO_G_I is
			-- Toolkit implementation of `a_separator_gadget'
		deferred
		end;

	text (a_text: TEXT; managed: BOOLEAN): TEXT_I is
			-- Toolkit implementation of `a_text'
		deferred
		end;

	text_word_wrapped (a_text: TEXT; managed: BOOLEAN): TEXT_I is
			-- Toolkit implementation of `a_text'
		deferred
		end;

	text_field (a_text_field: TEXT_FIELD; managed: BOOLEAN): TEXT_FIELD_I is
			-- Toolkit implementation of `a_text_field'
		deferred
		end;

	toggle_b (a_toggle_b: TOGGLE_B; managed: BOOLEAN): TOGGLE_B_I is
			-- Toolkit implementation of `a_toggle_b'
		deferred
		end;

	toggle_bg (a_toggle_b_gadget: TOGGLE_BG; managed: BOOLEAN): TOGGLE_BG_I is
			-- Toolkit implementation of `a_toggle_b_gadget'
		deferred
		end;

	warning_d (a_warning_dialog: WARNING_D): WARNING_D_I is
			-- Toolkit implementation of `a_warning_dialog'
		deferred
		end;

	working_d (a_working_dialog: WORKING_D): WORKING_D_I is
			-- Toolkit implementation of `a_working_dialog'
		deferred
		end

	set_default_resources (a_list: ARRAY[WIDGET_RESOURCE]) is
			-- Set the default resources of the application
		deferred
		end;

	widget_resource: WIDGET_RESOURCE_I is
		deferred
		end;


end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
