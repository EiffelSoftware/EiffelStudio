indexing

	description: "Implementation toolkit";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TOOLKIT

inherit

	CURSOR_TYPE
		export
			{NONE} all
		end

feature -- Access

	arrow_b (an_arrow_button: ARROW_B; managed: BOOLEAN; 
		oui_parent: COMPOSITE): ARROW_B_I is
			-- Toolkit implementation of `an_arrow_button'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	base (a_base: BASE): BASE_I is
			-- Toolkit implementation of `a_base'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	color (a_color: COLOR): COLOR_I is
			-- Toolkit implementation of `a_color'
		deferred
		end;

	color_for_screen (a_color: COLOR; a_screen: SCREEN): COLOR_I is
			-- Toolkit implementation of `a_color' for `a_screen'
		deferred
		end;

	dialog_shell (a_dialog_shell: DIALOG_SHELL; 
		oui_parent: COMPOSITE): DIALOG_S_I is
			-- Toolkit implementation of `a_dialog_shell'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	font (a_font: FONT): FONT_I is
			-- Toolkit implementation of `a_font'
		deferred
		ensure
			font_exists: Result /= Void
		end;

	font_for_screen (a_font: FONT; a_screen: SCREEN): FONT_I is
			-- Toolkit implementation of `a_font' for `a_screen'
		deferred
		ensure
			font_exists: Result /= Void
		end;

	font_box (a_font_box: FONT_BOX; managed: BOOLEAN; 
		oui_parent: COMPOSITE): FONT_BOX_I is
			-- Toolkit implementation of `a_font_box'
		deferred
		ensure
			font_exists: Result /= Void
		end;

	font_box_d (a_font_box_d: FONT_BOX_D; oui_parent: COMPOSITE): FONT_B_D_I is
			-- Toolkit implementation of `a_font_box_d'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	global_cursor: SCREEN_CURSOR is
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.
		deferred
		end;

	name: STRING is
			-- Toolkit implementation name
		deferred
		end

	override_s (an_override_shell: OVERRIDE_S; 
		oui_parent: COMPOSITE): OVERRIDE_S_I is
			-- Toolkit implementation of `an_override_shell'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	pict_color_b (a_picture_color_button: PICT_COLOR_B; managed: BOOLEAN; 
		oui_parent: COMPOSITE): PICT_COL_B_I is
			-- Toolkit implementation of `a_picture_color_button'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	pixmap (a_pixmap: PIXMAP): PIXMAP_I is
			-- Toolkit implementation of `a_pixmap'
		deferred
		ensure
			pixmap_exists: Result /= Void
		end;

	pixmap_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN): PIXMAP_I is
			-- Toolkit implementation of `a_pixmap' for `a_screen'
		deferred
		ensure
			pixmap_exists: Result /= Void
		end;

	restore_cursors is
			-- Restore the cursors as they were before `set_global_cursor'.
		deferred
		ensure
			no_global_cursor_anymore: (global_cursor = Void)
		end;

	screen (a_screen: SCREEN): SCREEN_I is
			-- Toolkit implementation of `a_screen'
		deferred
		ensure
			screen_exists: Result /= Void
		end;

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_I is
			-- Toolkit implementation of `a_cursor'
		deferred
		ensure
			screen_cursor_exists: Result /= Void
		end;

	screen_cursor_for_screen (a_cursor: SCREEN_CURSOR; a_screen: SCREEN): SCREEN_CURSOR_I is
			-- Toolkit implementation of `a_cursor'
		deferred
		ensure
			screen_cursor_exists: Result /= Void
		end;

	set_global_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set a global cursor for the whole application.
			-- Warning: the effect of calling `set_type' on a SCREEN_CURSOR
			-- or `set_cursor' on a WIDGET is not defined.
			-- It depends on the specific implementation.
		require
			a_cursor_exists: a_cursor /= Void
			no_global_cursor_already_set: (global_cursor = Void)
		deferred
		ensure
			correctly_set: global_cursor = a_cursor
		end;

	task (a_task: TASK): TASK_I is
			-- Toolkit implementation of `a_task'
		deferred
		ensure
			task_exists: Result /= Void
		end;

	timer (a_timer: TIMER): TIMER_I is
			-- Toolkit implementation of `a_timer'
		deferred
		ensure
			timer_exists: Result /= Void
		end;

	top_shell (a_top_shell: TOP_SHELL): TOP_SHELL_I is
			-- Toolkit implementation of `a_top_shell'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	bar (a_bar: BAR; managed: BOOLEAN; oui_parent: COMPOSITE): BAR_I is
			-- Toolkit implementation of `a_bar'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	bulletin (a_bulletin: BULLETIN; managed: BOOLEAN; 
		oui_parent: COMPOSITE): BULLETIN_I is
			-- Toolkit implementation of `a_bulletin'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	bulletin_d (a_bulletin_d: BULLETIN_D; 
		oui_parent: COMPOSITE): BULLETIN_D_I is
			-- Toolkit implementation of `a_bulletin_d'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	check_box (a_check_box: CHECK_BOX; managed: BOOLEAN; 
		oui_parent: COMPOSITE): CHECK_BOX_I is
			-- Toolkit implementation of `a_check_box'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	draw_b (a_draw_b: DRAW_B; managed: BOOLEAN; 
		oui_parent: COMPOSITE): DRAW_B_I is
			-- Toolkit implementation of `a_draw_b'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	drawing_area (a_drawing_area: DRAWING_AREA; managed: BOOLEAN; 
		oui_parent: COMPOSITE): D_AREA_I is
			-- Toolkit implementation of `a_drawing_area'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	error_d (an_error_dialog: ERROR_D; oui_parent: COMPOSITE): ERROR_D_I is
			-- Toolkit implementation of `an_error_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	file_sel_d (a_file_selec_dialog: FILE_SEL_D; 
		oui_parent: COMPOSITE): FILE_SEL_D_I is
			-- Toolkit implementation of `a_file_selec_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	file_selec (a_file_selection: FILE_SELEC; managed: BOOLEAN; 
		oui_parent: COMPOSITE): FILE_SELEC_I is
			-- Toolkit implementation of `a_file_selection'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	font_list (a_font_list: FONT_LIST): FONT_LIST_I is
			-- Toolkit implementation of `a_font_list'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	form (a_form: FORM; managed: BOOLEAN; oui_parent: COMPOSITE): FORM_I is
			-- Toolkit implementation of `a_form'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	form_d (a_form_dialog: FORM_D; oui_parent: COMPOSITE): FORM_D_I is
			-- Toolkit implementation of `a_form_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	frame (a_frame: FRAME; managed: BOOLEAN; oui_parent: COMPOSITE): FRAME_I is
			-- Toolkit implementation of `a_frame'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	info_d (an_information_dialog: INFO_D; oui_parent: COMPOSITE): INFO_D_I is
			-- Toolkit implementation of `an_information_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	label (a_label: LABEL; managed: BOOLEAN; oui_parent: COMPOSITE): LABEL_I is
			-- Toolkit implementation of `a_label'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	menu_b (a_menu_b: MENU_B; managed: BOOLEAN; 
		oui_parent: MENU): MENU_B_I is
			-- Toolkit implementation of `a_menu_b'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	message_d (a_message_dialog: MESSAGE_D; 
		oui_parent: COMPOSITE): MESSAGE_D_I is
			-- Toolkit implementation of `a_message_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	option_b (an_option_button: OPTION_B; managed: BOOLEAN; 
		oui_parent: COMPOSITE): OPTION_B_I is
			-- Toolkit implementation of `an_option_button'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	popup (a_popup: POPUP; oui_parent: COMPOSITE): POPUP_I is
			-- Toolkit implementation of `a_popup'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	prompt_d (a_prompt_dialog: PROMPT_D; 
		oui_parent: COMPOSITE): PROMPT_D_I is
			-- Toolkit implementation of `a_prompt_dialog`
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	menu_pull (a_new_pull: MENU_PULL; managed: BOOLEAN; 
		oui_parent: MENU): MENU_PULL_I is
			-- Toolkit implementation of `a_new_pull'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	opt_pull (an_opt_pull: OPT_PULL; managed: BOOLEAN; 
		oui_parent: COMPOSITE): OPT_PULL_I is
			-- Toolkit implementation of `an_opt_pull'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	push_b (a_push_b: PUSH_B; managed: BOOLEAN; 
		oui_parent: COMPOSITE): PUSH_B_I is
			-- Toolkit implementation of `a_push_b'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	question_d (a_question_dialog: QUESTION_D; 
		oui_parent: COMPOSITE): QUESTION_D_I is
			-- Toolkit implementation of `a_question_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	radio_box (a_radio_box: RADIO_BOX; managed: BOOLEAN; 
		oui_parent: COMPOSITE): RADIO_BOX_I is
			-- Toolkit implementation of `a_radio_box'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	row_column (a_row_column: ROW_COLUMN; managed: BOOLEAN; 
		oui_parent: COMPOSITE): ROW_COLUMN_I is
			-- Toolkit implementation of `a_row_column'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	scale (a_scale: SCALE; managed: BOOLEAN; oui_parent: COMPOSITE): SCALE_I is
			-- Toolkit implementation of `a_scale'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	scrollable_list (a_scrollable_list: SCROLLABLE_LIST; managed, 
		is_fixed: BOOLEAN; oui_parent: COMPOSITE): SCROLLABLE_LIST_I is
			-- Toolkit implementation of `a_scrollable_list'
		deferred
		ensure
			widget_exists: Result /= Void
		end

	scrollbar (a_scrollbar: SCROLLBAR; managed: BOOLEAN; 
		oui_parent: COMPOSITE): SCROLLBAR_I is
			-- Toolkit implementation of `a_scrollbar'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	scrolled_t (a_scrolled_text: SCROLLED_T; managed: BOOLEAN; 
		oui_parent: COMPOSITE): SCROLLED_T_I is
			-- Toolkit implementation of `a_scrolled_text'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	scrolled_t_word_wrapped (a_scrolled_text: SCROLLED_T; managed: BOOLEAN; 
		oui_parent: COMPOSITE): SCROLLED_T_I is
			-- Toolkit implementation of `a_scrolled_text'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	scrolled_w (a_scrolled_window: SCROLLED_W; managed: BOOLEAN; 
		oui_parent: COMPOSITE): SCROLLED_W_I is
			-- Toolkit implementation of `a_scrolled_window'
		deferred
		ensure
			widget_exists: Result /= Void
		end;
	
	search_replace_dialog (a_search_replace_dialog: SEARCH_REPLACE_DIALOG; 
		oui_parent: COMPOSITE): SEARCH_REPLACE_DIALOG_I is
			-- Toolkit implementation of `a_search_replace_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end

	separator (a_separator: SEPARATOR; managed: BOOLEAN; 
		oui_parent: COMPOSITE): SEPARATOR_I is
			-- Toolkit implementation of `a_separator'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	text (a_text: TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_I is
			-- Toolkit implementation of `a_text'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	text_word_wrapped (a_text: TEXT; managed: BOOLEAN; 
		oui_parent: COMPOSITE): TEXT_I is
			-- Toolkit implementation of `a_text'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	text_field (a_text_field: TEXT_FIELD; managed: BOOLEAN; 
		oui_parent: COMPOSITE): TEXT_FIELD_I is
			-- Toolkit implementation of `a_text_field'
		deferred
		ensure
			widget_exists: Result /= Void
		end;
	
	password (a_password: PASSWORD; managed: BOOLEAN; 
		oui_parent: COMPOSITE): PASSWORD_I is
			-- Toolkit implementation of `a_password'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	toggle_b (a_toggle_b: TOGGLE_B; managed: BOOLEAN; 
		oui_parent: COMPOSITE): TOGGLE_B_I is
			-- Toolkit implementation of `a_toggle_b'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	warning_d (a_warning_dialog: WARNING_D; 
		oui_parent: COMPOSITE): WARNING_D_I is
			-- Toolkit implementation of `a_warning_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	working_d (a_working_dialog: WORKING_D; 
		oui_parent: COMPOSITE): WORKING_D_I is
			-- Toolkit implementation of `a_working_dialog'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	set_default_resources (a_list: ARRAY[WIDGET_RESOURCE]) is
			-- Set the default resources of the application
		deferred
		end;

	widget_resource: WIDGET_RESOURCE_I is
		deferred
		end;

feature -- Basic operations

	iterate is
			-- Loop the application.
		deferred
		end;

	exit is
			-- Exit from the application
		deferred
		end;


end -- class TOOLKIT


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

