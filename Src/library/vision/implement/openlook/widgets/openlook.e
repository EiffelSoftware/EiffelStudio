
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPENLOOK  

inherit

    TOOLKIT;

	G_ANY_O
		export
			{NONE} all
		end;

	ALL_CURS_X
		export
			{NONE} all
		end

creation

	make
	
feature {NONE}

	app_class: STRING;
			-- Application class name of the application

	application_context: POINTER;
			-- Xt context of current application

feature 

	make (application_class: STRING) is
			-- Create the toolkit.
			-- `application_class' is used for the resource specifications.
		do
			application_context := xt_init;
			if not (application_class = Void) then
				app_class := application_class.duplicate
			end
		end;

	arrow_b (an_arrow_button: ARROW_B): ARROW_B_O is
			-- OpenLook implementation of `an_arrow_button'
		do
			!!Result.make (an_arrow_button)
		end;

	bar (a_bar: BAR): BAR_O is
			-- OpenLook implementation of `a_bar'
		do
			!!Result.make (a_bar)
		end;

	base (a_base: BASE): BASE_O is
			-- OpenLook implementation of `a_base'
		do
			!!Result.make (a_base, app_class)
		end; 

	bulletin (a_bulletin: BULLETIN): BULLETIN_O is
			-- OpenLook implementation of `a_bulletin'
		do
			!!Result.make (a_bulletin);
		end;

	bulletin_d (a_bulletin_d: BULLETIN_D): BULLETIN_D_O is
			-- OpenLook implementation of `a_bulletin_d'
		do
			!!Result.make (a_bulletin_d)
		end;

	check_box (a_check_box: CHECK_BOX): CHECK_BOX_O is
			-- OpenLook implementation of `a_check_box'
		do
			!!Result.make (a_check_box)
		end;

	color (a_color: COLOR): COLOR_X is
			-- OpenLook implementation of `a_color'
		do
			!!Result.make (a_color)
		end;

	dialog_shell (a_dialog_shell: DIALOG_SHELL): DIALOG_S_O is
			-- OpenLook implementation of `a_dialog_shell'
		do
			!!Result.make (a_dialog_shell)
		end;

	draw_b (a_draw_b: DRAW_B): DRAW_B_O is
			-- OpenLook implementation of `a_draw_b'
		do
			!!Result.make (a_draw_b)
		end;

	drawing_area (a_drawing_area: DRAWING_AREA): D_AREA_O is
			-- OpenLook implementation of `a_drawing_area'
		do
			!!Result.make (a_drawing_area)
		end;

	error_d (an_error_dialog: ERROR_D): ERROR_D_O is
			-- OpenLook implementation of `an_error_dialog'
		do
			!!Result.make (an_error_dialog)
		end;

	exit is
			-- Exit from the application
		do
			xt_destroy_application_context (application_context);
			c_exit (0)
		end;

	file_sel_d (a_file_sel_dialog: FILE_SEL_D): FILE_SEL_D_O is
			-- OpenLook implementation of `a_file_sel_dialog'
		do
			!!Result.make (a_file_sel_dialog)	
		end;

	file_selec (a_file_selection: FILE_SELEC): FILE_SELEC_O is
			-- OpenLook implementation of `a_file_selec'
		do
			!!Result.make (a_file_selection)
		end;

	font (a_font: FONT): FONT_X is
			-- OpenLook implementation of `a_font'
		do
			!!Result.make (a_font)
		end;

	font_box (a_font_box: FONT_BOX): FONT_BOX_O is
			-- OpenLook implementation of `a_font_box'
		do
			!!Result.make (a_font_box)
		end;

	font_box_d (a_font_box_d: FONT_BOX_D): FONT_B_D_O is
			-- OpenLook implementation of `a_font_box_d'
		do
			!!Result.make (a_font_box_d)
		end;

	font_list (a_font_list: FONT_LIST): FONT_LIST_X is
			-- OpenLook implementation of `a_font_list'
		do
			!!Result.make (a_font_list)
		end;

	form (a_form: FORM): FORM_O is
			-- OpenLook implementation of `a_form'
		do
			!!Result.make (a_form)
		end;

	form_d (a_form_dialog: FORM_D): FORM_D_O is
			-- OpenLook implementation of `a_form_dialog'
		do
			!!Result.make (a_form_dialog)
		end;

	frame (a_frame: FRAME): FRAME_O is
			-- OpenLook implementation of `a_frame'
		do
			!!Result.make (a_frame)
		end;

	info_d (an_information_dialog: INFO_D): INFO_D_O is
			-- OpenLook implementation of `an_information_dialog'
		do
			!!Result.make (an_information_dialog)
		end;

	io_handler (an_io_handler: IO_HANDLER): IO_HANDLER_X is
			-- OpenLook implementation of `an_io_handler'
		do
			!!Result.make (an_io_handler, application_context)
		end;

	iterate is
			-- Loop the application.
		
		do
			xt_app_main_loop (application_context)
		end;

	label (a_label: LABEL): LABEL_O is
			-- OpenLook implementation of `a_label'
		do
			!!Result.make (a_label)
		end;

	label_g (a_label_gadget: LABEL_G): LABEL_G_O is
			-- OpenLook implementation of `a_label_gadget'
		do
			!!Result.make (a_label_gadget)
		end;

	menu_b (a_menu_b: MENU_B): MENU_B_O is
			-- OpenLook implementation of menu button
		do
			!!Result.make (a_menu_b)
		end;

	menu_pull (a_menu_pull: MENU_PULL): MENU_PULL_O is
			-- OpenLook implementation of `a_menu_pull'
		do
			!!Result.make (a_menu_pull)
		end;

	message (a_message: MESSAGE): MESSAGE_O is
			-- OpenLook implementation of `a_message'
		do
			!!Result.make (a_message)
		end;

	message_d (a_message_dialog: MESSAGE_D): MESSAGE_D_O is
			-- OpenLook implementation of `a_message_dialog'
		do
			!!Result.make (a_message_dialog)
		end;

	opt_pull (an_opt_pull: OPT_PULL): OPT_PULL_O is
			-- OpenLook implementation of `an_opt_pull'
		do
			!!Result.make (an_opt_pull)
		end;

	option_b (an_option_button: OPTION_B): OPTION_B_O is
			-- OpenLook implementation of `an_option_button'
		do
			!!Result.make (an_option_button)
		end; 

	override_s (an_override_s: OVERRIDE_S): OVERRIDE_S_O is
			-- OpenLook implementation of `an_override_s'
		do
			!!Result.make (an_override_s)
		end;

	popup (a_popup: POPUP): POPUP_O is
			-- OpenLook implementation of `a_popup'
		do
			!!Result.make (a_popup)
		end;

	prompt (a_prompt: PROMPT): PROMPT_O is
			-- OpenLook implementation of `a_prompt'
		do
			!!Result.make (a_prompt)
		end;

	prompt_d (a_prompt_dialog: PROMPT_D): PROMPT_D_O is
			-- OpenLook implementation of `a_prompt_dialog'
		do
			!!Result.make (a_prompt_dialog)
		end;

	pict_color_b (a_picture_color_button: PICT_COLOR_B): PICT_COL_B_O is
			 -- OpenLook implementation of `a_picture_color_button'
		do
			!!Result.make (a_picture_color_button)
		end;

	pixmap (a_pixmap: PIXMAP): PIXMAP_X is
			-- OpenLook implementation of `a_pixmap'
		do
			!!Result.make (a_pixmap)
		end;

	push_b (a_push_b: PUSH_B): PUSH_B_O is
			-- OpenLook implementation of push button
		do
			!!Result.make (a_push_b)
		end;

	push_bg (a_push_b_gadget: PUSH_BG): PUSH_BG_O is
			-- OpenLook implementation of `a_push_b_gadget'
		do
			!!Result.make (a_push_b_gadget)
		end;

	question_d (a_question_dialog: QUESTION_D): QUESTION_D_O is
			-- OpenLook implementation of `a_question_dialog'
		do
			!!Result.make (a_question_dialog)
		end;

	radio_box (a_radio_box: RADIO_BOX): RADIO_BOX_O is
			-- OpenLook implementation of `a_radio_box'
		do
			!!Result.make (a_radio_box)
		end;

	row_column (a_row_column: ROW_COLUMN): ROW_COLUMN_O is
			-- OpenLook implementation of `a_row_column'
		do
			!!Result.make (a_row_column)
		end;

	scale (a_scale: SCALE): SCALE_O is
			-- OpenLook implementation of `a_scale'
		do
			!!Result.make (a_scale)
		end;

	screen (a_screen: SCREEN): SCREEN_X is
			-- OpenLook implementation of `a_screen'
		do
			!!Result.make (a_screen, app_class)
		end;

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_X is
			-- OpenLook implementation of `a_cursor'
		do
			!!Result.make (a_cursor)
		end;

	scroll_list (a_list: SCROLL_LIST): SCROLL_L_O is
			-- OpenLook implementation of `a_list'
		do
			!!Result.make (a_list)
		end;

	scrollbar (a_scrollbar: SCROLLBAR): SCROLLBAR_O is
			-- OpenLook implementation of `a_scrollbar'
		do
			!!Result.make (a_scrollbar)
		end;

	scrolled_t (a_scrolled_text: SCROLLED_T): SCROLLED_T_O is
			-- OpenLook implementation of `a_scrolled_text'
		do
			!!Result.make (a_scrolled_text)
		end;

	scrolled_w (a_scrolled_window: SCROLLED_W): SCROLLED_W_O is
			-- OpenLook implementation of `a_scrolled_window'
		do
			!!Result.make (a_scrolled_window)
		end;

	separator (a_separator: SEPARATOR): SEPARATOR_O is
			-- OpenLook implementation of `a_separator'
		do
			!!Result.make (a_separator)
		end;

	separator_g (a_separator_gadget: SEPARATOR_G): SEPARATO_G_O is
			-- OpenLook implementation of `a_separator_gadget'
		do
			!!Result.make (a_separator_gadget)
		end;

	task (a_task: TASK): TASK_X is
			-- OpenLook implementation of `a_task'
		do
			!!Result.make (a_task, application_context)
		end;

	text (a_text: TEXT): TEXT_O is
			-- OpenLook implementation of `a_text'
		do
			!!Result.make (a_text)
		end;

	text_field (a_text_field: TEXT_FIELD): TEXT_FIELD_O is
			-- OpenLook implementation of `a_text_field'
		do
			!!Result.make (a_text_field)
		end;

	timer (a_timer: TIMER): TIMER_X is
			-- OpenLook implementation of `a_timer'
		do
			!!Result.make (a_timer, application_context)
		end;

	toggle_b (a_toggle_b: TOGGLE_B): TOGGLE_B_O is
			-- OpenLook implementation of `a_toggle_b'
		do
			!!Result.make (a_toggle_b)
		end;

	toggle_bg (a_toggle_b_gadget: TOGGLE_BG): TOGGLE_BG_O is
			-- OpenLook implementation of `a_toggle_b_gadget'
		do
			!!Result.make (a_toggle_b_gadget)
		end;

	top_shell (a_top_shell: TOP_SHELL): TOP_SHELL_O is
			-- OpenLook implementation of `a_top_shell'
		do
			!!Result.make (a_top_shell, app_class)
		end;

	warning_d (a_warning_dialog: WARNING_D): WARNING_D_O is
			-- OpenLook implementation of `a_warning_dialog'
		do
			!!Result.make (a_warning_dialog)
		end;

	working_d (a_working_dialog: WORKING_D): WORKING_D_O is
			-- OpenLook implementation of `a_working_dialog'
		do
			!!Result.make (a_working_dialog)
		end; 

feature {NONE} -- External features

	xt_init: POINTER is
		external
			"C"
		end; 

	xt_app_main_loop (context: POINTER) is
		external
			"C"
		end; 

	c_exit (val: INTEGER) is
		external
			"C"
		end;

	xt_destroy_application_context (context: POINTER) is
		external
			"C"
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
