indexing
	description: "This class is used to instantiate the MS_WINDOWS%
		% implementation of a widget"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WINDOWS_1

feature -- Access

	arrow_b (an_arrow_button: ARROW_B; managed: BOOLEAN; oui_parent: COMPOSITE): ARROW_BUTTON_WINDOWS is
                        -- MS-Windows implementation of `an_arrow_button'
		do
			!! Result.make (an_arrow_button, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	bar (a_bar: BAR; managed: BOOLEAN; oui_parent: COMPOSITE): BAR_WINDOWS is
			-- MS-Windows implementation of `a_bar'
		do
			!! Result.make (a_bar, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	base (a_base: BASE): BASE_WINDOWS is
                        -- MS-Windows implementation of `a_base'
		do
			!! Result.make (a_base)
		ensure
			widget_exists: Result /= Void
		end

	bulletin (a_bulletin: BULLETIN; managed: BOOLEAN; oui_parent: COMPOSITE): BULLETIN_WINDOWS is
			-- MS-Windows implementation of `a_bulletin'
		do
			!! Result.make (a_bulletin, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	bulletin_d (a_bulletin_d: BULLETIN_D; oui_parent: COMPOSITE): BULLETIN_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_bulletin_d'
		do
			!! Result.make (a_bulletin_d, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	check_box (a_check_box: CHECK_BOX; managed: BOOLEAN; oui_parent: COMPOSITE): CHECK_BOX_WINDOWS is
			-- MS-Windows implementation of `a_check_box'
		do
			!! Result.make (a_check_box, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	dialog_shell (a_dialog_shell: DIALOG_SHELL; oui_parent: COMPOSITE): DIALOG_SHELL_WINDOWS is
			-- MS-Windows implementation of `a_dialog_shell'
		do
			!! Result.make (a_dialog_shell, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	draw_b (a_draw_b: DRAW_B; managed: BOOLEAN; oui_parent: COMPOSITE): DRAW_BUTTON_WINDOWS is
                        -- MS-Windows implementation of `a_draw_b'
		do
			!! Result.make (a_draw_b, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	drawing_area (a_drawing_area: DRAWING_AREA; managed: BOOLEAN; oui_parent: COMPOSITE): DRAWING_AREA_WINDOWS is
                        -- MS-Windows implementation of `a_drawing_area'
		do
			!! Result.make (a_drawing_area, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	error_d (an_error_dialog: ERROR_D; oui_parent: COMPOSITE): ERROR_DIALOG_WINDOWS is
			-- MS-Windows implementation of `an_error_dialog'
		do
			!! Result.make (an_error_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	file_sel_d (a_file_sel_dialog: FILE_SEL_D; oui_parent: COMPOSITE): FILE_SELECTION_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_file_sel_dialog'
		do
			!! Result.make (a_file_sel_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	file_selec (a_file_selection: FILE_SELEC; managed: BOOLEAN; oui_parent: COMPOSITE): FILE_SELECTION_WINDOWS is
			-- MS-Windows implementation of `a_file_selec'
		do
			!! Result.make (a_file_selection, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end
 
	font_box (a_font_box: FONT_BOX; managed: BOOLEAN; oui_parent: COMPOSITE): FONT_BOX_WINDOWS is
                        -- MS-Windows implementation of `a_font_box'
		do
			!! Result.make (a_font_box, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	font_box_d (a_font_box_d: FONT_BOX_D; oui_parent: COMPOSITE): FONT_BOX_DIALOG_WINDOWS is
                        -- MS-Windows implementation of `a_font_box_d'
		do
			!! Result.make (a_font_box_d, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	font_list (a_font_list: FONT_LIST): FONT_LIST_WINDOWS is
			-- MS-Windows implementation of `a_font_list'
		do
			!! Result.make (a_font_list)
		ensure
			widget_exists: Result /= Void
		end

	form (a_form: FORM; managed: BOOLEAN; oui_parent: COMPOSITE): FORM_WINDOWS is --BUG_COMPILO
			-- MS-Windows implementation of `a_form'
		do
			!! Result.make (a_form, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	form_d (a_form_dialog: FORM_D; oui_parent: COMPOSITE): FORM_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_form_dialog'
		do
			!! Result.make (a_form_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	frame (a_frame: FRAME; managed: BOOLEAN; oui_parent: COMPOSITE): FRAME_WINDOWS is
			-- MS-Windows implementation of `a_frame'
		do
			!! Result.make (a_frame, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	info_d (an_information_dialog: INFO_D; oui_parent: COMPOSITE): INFO_DIALOG_WINDOWS is
			-- MS-Windows implementation of `an_information_dialog'
		do
			!! Result.make (an_information_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	label (a_label: LABEL; managed: BOOLEAN; oui_parent: COMPOSITE): LABEL_WINDOWS is
			-- MS-Windows implementation of `a_label'
		do
			!! Result.make (a_label, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	menu_b (a_menu_b: MENU_B; managed: BOOLEAN; oui_parent: MENU): MENU_BUTTON_WINDOWS is
			-- MS-Windows implementation of `a_menu_b'
		do
			!! Result.make (a_menu_b, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	menu_pull (a_pulldown: MENU_PULL; managed: BOOLEAN; oui_parent: MENU): MENU_PULL_WINDOWS is
			-- MS-Windows implementation of `a_pulldown'
		do
			!! Result.make (a_pulldown, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	message_d (a_message_dialog: MESSAGE_D; oui_parent: COMPOSITE): MESSAGE_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_message_dialog'
		do
			!! Result.make (a_message_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	option_b (an_option_button: OPTION_B; managed: BOOLEAN; oui_parent: COMPOSITE): OPTION_BUTTON_WINDOWS is
			-- MS-Windows implementation of `an_option_button'
		do
			!! Result.make (an_option_button, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	opt_pull (a_pulldown: OPT_PULL; managed: BOOLEAN; oui_parent: COMPOSITE): OPTION_PULL_WINDOWS is
			-- MS-Windows implementation of `a_pulldown'
		do
			!! Result.make (a_pulldown, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	override_s (an_override_s: OVERRIDE_S; oui_parent: COMPOSITE): OVERRIDE_SHELL_WINDOWS is
			-- MS-Windows implementation of `an_override_s'
		do
			!! Result.make (an_override_s, oui_parent)
		ensure
			widget_exists: Result /= Void
		end
 
	pict_color_b (a_picture_color_button: PICT_COLOR_B; managed: BOOLEAN; oui_parent: COMPOSITE): PICT_COLOR_BUTTON_WINDOWS is
                        -- MS-Windows implementation of `a_picture_color_button'
		do
			!! Result.make (a_picture_color_button, oui_parent, managed)
		ensure
			widget_exists: Result /= Void
		end

	popup (a_popup: POPUP; oui_parent: COMPOSITE): POPUP_WINDOWS is
			-- MS-Windows implementation of `a_popup'
		do
			!! Result.make (a_popup, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	prompt_d (a_prompt_dialog: PROMPT_D; oui_parent: COMPOSITE): PROMPT_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_prompt_dialog'
		do
			!! Result.make (a_prompt_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	push_b (a_push_b: PUSH_B; managed: BOOLEAN; oui_parent: COMPOSITE): PUSH_BUTTON_WINDOWS is
			-- MS-Windows implementation of push button
		do
			!! Result.make (a_push_b, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	question_d (a_question_dialog: QUESTION_D; oui_parent: COMPOSITE): QUESTION_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_question_dialog'
		do
			!! Result.make (a_question_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	radio_box (a_radio_box: RADIO_BOX; managed: BOOLEAN; oui_parent: COMPOSITE): RADIO_BOX_WINDOWS is
			-- MS-Windows implementation of `a_radio_box'
		do
			!! Result.make (a_radio_box, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	row_column (a_row_column: ROW_COLUMN; managed: BOOLEAN; oui_parent: COMPOSITE): ROW_COLUMN_WINDOWS is
			-- MS-Windows implementation of `a_row_column'
		do
			!! Result.make (a_row_column, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	scale (a_scale: SCALE; managed: BOOLEAN; oui_parent: COMPOSITE): SCALE_WINDOWS is
			-- MS-Windows implementation of `a_scale'
		do
			!! Result.make (a_scale, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	scrollable_list (a_scrollable_list: SCROLLABLE_LIST; managed, is_fixed:BOOLEAN; oui_parent: COMPOSITE): SCROLLABLE_LIST_WINDOWS is
			-- Toolkit implementation of `a_scrollable_list'
		do
			!! Result.make (a_scrollable_list, managed, is_fixed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	scrollbar (a_scrollbar: SCROLLBAR; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLBAR_WINDOWS is
			-- MS-Windows implementation of `a_scrollbar'
		do
			!! Result.make (a_scrollbar, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	scrolled_t (a_scrolled_text: SCROLLED_T; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLED_TEXT_WINDOWS is
			-- MS-Windows implementation of `a_scrolled_text'
		do
			!! Result.make (a_scrolled_text, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	scrolled_t_word_wrapped (a_scrolled_text: SCROLLED_T; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLED_TEXT_WINDOWS is
			-- MS-Windows implementation of `a_scrolled_text'
		do
			!! Result.make (a_scrolled_text, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	scrolled_w (a_scrolled_window: SCROLLED_W; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLED_WINDOW_WINDOWS is
			-- MS-Windows implementation of `a_scrolled_window'
		do
			!! Result.make (a_scrolled_window, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end
 
	search_replace_dialog (a_search_replace_dialog: SEARCH_REPLACE_DIALOG; oui_parent: COMPOSITE): SEARCH_REPLACE_DIALOG_WINDOWS is
			-- Toolkit implementation of `a_search_replace_dialog'
		do
			!! Result.make (a_search_replace_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	separator (a_separator: SEPARATOR; managed: BOOLEAN; oui_parent: COMPOSITE): SEPARATOR_WINDOWS is
			-- MS-Windows implementation of `a_separator'
		do
			!! Result.make (a_separator, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	tabbed_text (a_text: TABBED_TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TABBED_TEXT_WINDOWS is
			-- Toolkit implementation of `a_text'
		do
			!! Result.make (a_text, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	tabbed_text_word_wrapped (a_text: TABBED_TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TABBED_TEXT_WINDOWS is
			-- Toolkit implementation of `a_text'
		do
			!! Result.make (a_text, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	text (a_text: TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_WINDOWS is
			-- MS-Windows implementation of `a_text'
		do
			!! Result.make (a_text, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	text_word_wrapped (a_text_word_wrapped: TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_WINDOWS is
			-- MS-Windows implementation of `a_text_word_wrapped'
		do
			!! Result.make (a_text_word_wrapped, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	text_field (a_text_field: TEXT_FIELD; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_FIELD_WINDOWS is
			-- MS-Windows implementation of `a_text_field'
		do
			!! Result.make (a_text_field, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	toggle_b (a_toggle_b: TOGGLE_B; managed: BOOLEAN; oui_parent: COMPOSITE): TOGGLE_B_WINDOWS is
			-- MS-Windows implementation of `a_toggle_b'
		do
			!! Result.make (a_toggle_b, managed, oui_parent)
		ensure
			widget_exists: Result /= Void
		end
 
	top_shell (a_top_shell: TOP_SHELL): TOP_SHELL_WINDOWS is
                        -- MS-Windows implementation of `a_top_shell'
		do
			!! Result.make (a_top_shell)
		ensure
			widget_exists: Result /= Void
		end

	warning_d (a_warning_dialog: WARNING_D; oui_parent: COMPOSITE): WARNING_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_warning_dialog'
		do
			!! Result.make (a_warning_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

	working_d (a_working_dialog: WORKING_D; oui_parent: COMPOSITE): WORKING_DIALOG_WINDOWS is
			-- MS-Windows implementation of `a_working_dialog'
		do
			!! result.make (a_working_dialog, oui_parent)
		ensure
			widget_exists: Result /= Void
		end

end -- class WINDOWS_1

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
