indexing

	description:
		"Handles to Motif widget implementations.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	MOTIF_1
	
feature -- Widget access

	bar (a_bar: BAR; managed: BOOLEAN; oui_parent: COMPOSITE): BAR_M is
			-- Motif implementation of `a_bar'
		do
			!! Result.make (a_bar, managed, oui_parent)
		end; 

	bulletin (a_bulletin: BULLETIN; managed: BOOLEAN; oui_parent: COMPOSITE): BULLETIN_M is
			-- Motif implementation of `a_bulletin'
		do
			!! Result.make (a_bulletin, managed, oui_parent)
		end; 

	bulletin_d (a_bulletin_d: BULLETIN_D; oui_parent: COMPOSITE): BULLETIN_D_M is
			-- Motif implementation of `a_bulletin_d'
		do
			!! Result.make (a_bulletin_d, oui_parent)
		end; 

	check_box (a_check_box: CHECK_BOX; managed: BOOLEAN; oui_parent: COMPOSITE): CHECK_BOX_M is
			-- Motif implementation of `a_check_box'
		do
			!! Result.make (a_check_box, managed, oui_parent)
		end; 

	dialog_shell (a_dialog_shell: DIALOG_SHELL; oui_parent: COMPOSITE): DIALOG_S_M is
			-- Motif implementation of `a_dialog_shell'
		do
			!! Result.make (a_dialog_shell, oui_parent)
		end; 

	error_d (an_error_dialog: ERROR_D; oui_parent: COMPOSITE): ERROR_D_M is
			-- Motif implementation of `an_error_dialog'
		do
			!! Result.make (an_error_dialog, oui_parent)
		end; 

	file_sel_d (a_file_sel_dialog: FILE_SEL_D; oui_parent: COMPOSITE): FILE_SEL_D_M is
			-- Motif implementation of `a_file_sel_dialog'
		do
			!! Result.make (a_file_sel_dialog, oui_parent)
		end; 

	file_selec (a_file_selection: FILE_SELEC; managed: BOOLEAN; oui_parent: COMPOSITE): FILE_SELEC_M is
			-- Motif implementation of `a_file_selec'
		do
			!! Result.make (a_file_selection, managed, oui_parent)
		end; 

	font_list (a_font_list: FONT_LIST): FONT_LIST_X is
			-- Motif implementation of `a_font_list'
		do
			!! Result.make (a_font_list)
		end; 

	form (a_form: FORM; managed: BOOLEAN; oui_parent: COMPOSITE): FORM_M is
			-- Motif implementation of `a_form'
		do
			!! Result.make (a_form, managed, oui_parent)
		end; 

	form_d (a_form_dialog: FORM_D; oui_parent: COMPOSITE): FORM_D_M is
			-- Motif implementation of `a_form_dialog'
		do
			!! Result.make (a_form_dialog, oui_parent)
		end; 

	frame (a_frame: FRAME; managed: BOOLEAN; oui_parent: COMPOSITE): FRAME_M is
			-- Motif implementation of `a_frame'
		do
			!! Result.make (a_frame, managed, oui_parent)
		end;

	info_d (an_information_dialog: INFO_D; oui_parent: COMPOSITE): INFO_D_M is
			-- Motif implementation of `an_information_dialog'
		do
			!! Result.make (an_information_dialog, oui_parent)
		end;

	label (a_label: LABEL; managed: BOOLEAN; oui_parent: COMPOSITE): LABEL_M is
			-- Motif implementation of `a_label'
		do
			!! Result.make (a_label, managed, oui_parent)
		end;

	menu_b (a_menu_b: MENU_B; managed: BOOLEAN; oui_parent: MENU): MENU_B_M is
			-- Motif implementation of menu button
		do
			!! Result.make (a_menu_b, managed, oui_parent)
		end; 

	message_d (a_message_dialog: MESSAGE_D; oui_parent: COMPOSITE): MESSAGE_D_M is
			-- Motif implementation of `a_message_dialog'
		do
			!! Result.make (a_message_dialog, oui_parent)
		end; 

	option_b (an_option_button: OPTION_B; managed: BOOLEAN; oui_parent: COMPOSITE): OPTION_B_M is
			-- Motif implementation of `an_option_button'
		do
			!! Result.make (an_option_button, managed, oui_parent)
		end; 

	override_s (an_override_s: OVERRIDE_S; oui_parent: COMPOSITE): OVERRIDE_S_M is
			-- Motif implementation of `an_override_s'
		do
			!! Result.make (an_override_s, oui_parent)
		end; 

	popup (a_popup: POPUP; oui_parent: COMPOSITE): POPUP_M is
			-- Motif implementation of `a_popup'
		do
			!! Result.make (a_popup, oui_parent)
		end; 

	prompt_d (a_prompt_dialog: PROMPT_D; oui_parent: COMPOSITE): PROMPT_D_M is
			-- Motif implementation of `a_prompt_dialog'
		do
			!! Result.make (a_prompt_dialog, oui_parent)
		end; 

	menu_pull (a_pulldown: MENU_PULL; managed: BOOLEAN; oui_parent: MENU): MENU_PULL_M is
			-- Motif implementation of `a_pulldown'
		do
			!! Result.make (a_pulldown, managed, oui_parent)
		end; 

	opt_pull (a_pulldown: OPT_PULL; managed: BOOLEAN; oui_parent: COMPOSITE): OPT_PULL_M is
			-- Motif implementation of `a_pulldown'
		do
			!! Result.make (a_pulldown, managed, oui_parent)
		end; 

	push_b (a_push_b: PUSH_B; managed: BOOLEAN; oui_parent: COMPOSITE): PUSH_B_M is
			-- Motif implementation of push button
		do
			!! Result.make (a_push_b, managed, oui_parent)
		end; 

	question_d (a_question_dialog: QUESTION_D; oui_parent: COMPOSITE): QUESTION_D_M is
			-- Motif implementation of `a_question_dialog'
		do
			!! Result.make (a_question_dialog, oui_parent)
		end; 

	radio_box (a_radio_box: RADIO_BOX; managed: BOOLEAN; oui_parent: COMPOSITE): RADIO_BOX_M is
			-- Motif implementation of `a_radio_box'
		do
			!! Result.make (a_radio_box, managed, oui_parent)
		end; 

	row_column (a_row_column: ROW_COLUMN; managed: BOOLEAN; oui_parent: COMPOSITE): ROW_COLUMN_M is
			-- Motif implementation of `a_row_column'
		do
			!! Result.make (a_row_column, managed, oui_parent)
		end; 

	scale (a_scale: SCALE; managed: BOOLEAN; oui_parent: COMPOSITE): SCALE_M is
			-- Motif implementation of `a_scale'
		do
			!! Result.make (a_scale, managed, oui_parent)
		end; 

	scrollable_list (a_scrollable_list: SCROLLABLE_LIST; managed, is_fixed: BOOLEAN; oui_parent: COMPOSITE): SCROLLABLE_LIST_M is
			-- Motif implementation of `a_scrollable_list'
		do
			!! Result.make (a_scrollable_list, managed, is_fixed, oui_parent)
		end; 

	scrollbar (a_scrollbar: SCROLLBAR; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLBAR_M is
			-- Motif implementation of `a_scrollbar'
		do
			!! Result.make (a_scrollbar, managed, oui_parent)
		end; 

	scrolled_t (a_scrolled_text: SCROLLED_T; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLED_T_M is
			-- Motif implementation of `a_scrolled_text'
		do
			!! Result.make (a_scrolled_text, managed, oui_parent)
		end; 

	scrolled_t_word_wrapped (a_scrolled_text: SCROLLED_T; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLED_T_M is
			-- Motif implementation of `a_scrolled_text'
		do
			!! Result.make_word_wrapped (a_scrolled_text, managed, oui_parent)
		end; 

	scrolled_w (a_scrolled_window: SCROLLED_W; managed: BOOLEAN; oui_parent: COMPOSITE): SCROLLED_W_M is
			-- Motif implementation of `a_scrolled_window'
		do
			!! Result.make (a_scrolled_window, managed, oui_parent)
		end; 

	search_replace_dialog (a_search_replace_dialog: SEARCH_REPLACE_DIALOG;
oui_parent: COMPOSITE): SEARCH_REPLACE_DIALOG_M is
			-- Motif implementationof `a_serach_replace_dialog'
		do
			!! Result.make (a_search_replace_dialog, oui_parent)
		end

	separator (a_separator: SEPARATOR; managed: BOOLEAN; oui_parent: COMPOSITE): SEPARATOR_M is
			-- Motif implementation of `a_separator'
		do
			!! Result.make (a_separator, managed, oui_parent)
		end; 

	tabbed_text (a_text: TABBED_TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TABBED_TEXT_M is
			-- Motif implementation of `a_text'
		do
			!! Result.make (a_text, managed, oui_parent)
		end

	tabbed_text_word_wrapped (a_text: TABBED_TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TABBED_TEXT_M is
			-- Motif implementation of `a_text'
		do
			!! Result.make_word_wrapped (a_text, managed, oui_parent)
		end

	text (a_text: TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_M is
			-- Motif implementation of `a_text'
		do
			!! Result.make (a_text, managed, oui_parent)
		end; 

	text_word_wrapped (a_text: TEXT; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_M is
			-- Motif implementation of `a_text'
		do
			!! Result.make_word_wrapped (a_text, managed, oui_parent)
		end; 

	text_field (a_text_field: TEXT_FIELD; managed: BOOLEAN; oui_parent: COMPOSITE): TEXT_FIELD_M is
			-- Motif implementation of `a_text_field'
		do
			!! Result.make (a_text_field, managed, oui_parent)
		end; 

    password (a_password: PASSWORD; managed: BOOLEAN; oui_parent: COMPOSITE): PASSWORD_M is
            -- Motif implementation of `a_password'
        do
            !! Result.make (a_password, managed, oui_parent)
        end; 

	toggle_b (a_toggle_b: TOGGLE_B; managed: BOOLEAN; oui_parent: COMPOSITE): TOGGLE_B_M is
			-- Motif implementation of `a_toggle_b'
		do
			!! Result.make (a_toggle_b, managed, oui_parent)
		end; 

	warning_d (a_warning_dialog: WARNING_D; oui_parent: COMPOSITE): WARNING_D_M is
			-- Motif implementation of `a_warning_dialog'
		do
			!! Result.make (a_warning_dialog, oui_parent)
		end; 

	working_d (a_working_dialog: WORKING_D; oui_parent: COMPOSITE): WORKING_D_M is
			-- Motif implementation of `a_working_dialog'
		do
			!! Result.make (a_working_dialog, oui_parent)
		end 

end -- class MOTIF_1

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
