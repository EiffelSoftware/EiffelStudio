indexing
	description:
		"Dialog to ask for search or search and replace information";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SEARCH_REPLACE_DIALOG_IMP

inherit
	SEARCH_REPLACE_DIALOG_I

	DIALOG_IMP
		undefine
			process_message,
			wel_destroy,
			on_wm_menu_command,
			on_paint,
			default_style,
			on_wm_control_id_command,
			class_name,
			default_ex_style
		redefine
			set_x,
			set_y,
			set_x_y,
			set_default_position,
			realize_current,
			wel_item,
			wel_parent,
			on_control_id_command,
			set_enclosing_size
		end

	WEL_MODELESS_DIALOG
		rename
			children as wel_children,
			destroy as wel_destroy,
			parent as wel_parent,
			set_y as wel_set_y,
			set_x as wel_set_x,
			set_width as wel_set_width,
			x as wel_x,
			y as wel_y,
			show as wel_show,
			height as wel_height,
			width as wel_width,
			set_height as wel_set_height,
			hide as wel_hide,
			shown as wel_shown,
			draw_menu as wel_draw_menu,
			set_menu as wel_set_menu,
			menu as wel_menu,
			item as wel_item,
			move as wel_move,
			release_capture as wel_release_capture,
			set_capture as wel_set_capture,
			text_length as wel_text_length,
			text as wel_text,
			set_text as wel_set_text,
			set_focus as wel_set_focus			
		undefine
			on_hide,
			on_show,
			on_move,
			on_destroy,
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_set_cursor,
			on_menu_command,
			on_accelerator_command,
			on_size,
			on_key_up,
			on_key_down,
			on_draw_item,
			on_get_min_max_info,
			on_erase_background,
			background_brush
		redefine
			on_control_id_command,
			wel_parent,
			wel_item,
			class_name,
			on_cancel,
			setup_dialog
		end

	COLORED_FOREGROUND_WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (a_search_replace: SEARCH_REPLACE_DIALOG; oui_parent: COMPOSITE) is
			-- Initilaize the search_replace_dialog
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			a_search_replace.set_dialog_imp (Current)
			set_defaults
		end

	realize_current is
			-- Realize the dialog.
		local
			wc: WEL_COMPOSITE_WINDOW
			wd: WEL_DIALOG
		do
			wc ?= parent
			make_by_id (wc, Idd_replacedialog)
			wd ?= Current
			!! find_next_button.make_by_id (wd, Id_findnext)
			!! replace_button.make_by_id (wd, Id_replace)
			!! replace_all_button.make_by_id (wd, Id_replaceall)
			!! find_edit.make_by_id (wd, Idc_findedit)
			!! replace_edit.make_by_id (wd, Idc_replaceedit)
			!! word_check.make_by_id (wd, Idc_wordcheck)
			!! case_check.make_by_id (wd, Idc_casecheck)
			!! radio_up.make_by_id (wd, Idc_radioup)
			!! radio_down.make_by_id (wd, Idc_radiodown)
			!! radio_box.make_by_id (wd, Idc_radiobox)
			!! find_static.make_by_id (wd, Id_findstatic)
			!! replace_static.make_by_id (wd, Id_replacestatic)
			!! close.make_by_id (wd, Idcancel)
			activate
		end

feature -- Status report

	case_sensitive: BOOLEAN is
			-- Is search and replace to be case sensitive?	
		do
			if exists then
				Result := case_check.checked
			else
				Result := private_case_checked
			end
		end

	replace_mode: BOOLEAN is
			-- Is this dialog to do a replace?
		do
			Result := private_is_replace
		end

	replace_text: STRING is
			-- Text to replace `search_text' with.
		do
			if exists then
				Result := replace_edit.text
			else
				Result := private_replace_text
			end
		end

	search_text: STRING is 
			-- Text to search for
		do
			if exists then
				Result := find_edit.text
			else
				Result := private_search_text
			end
		end

	search_upwards: BOOLEAN is
			-- Do this search from the bottom up?
		do
			if exists then
				Result := radio_up.checked
			else
				Result := private_direction_up
			end
		end

feature -- Status setting

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			private_attributes.set_x (new_x)
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set `x' to `new_x', `y' to `new_y'.
		do
			private_attributes.set_y (new_y)
			private_attributes.set_x (new_x)
		end

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			private_attributes.set_y (new_y)

		end

	set_default_position (flag: BOOLEAN) is
			-- Search dialogs do not have a default position.
		do
		end

	show_direction_request is
			-- Show the direction requestor
		do
			direction_request_shown := True
			if exists then
				radio_box.show
				radio_up.show
				radio_down.show
			end
		end

	hide_direction_request is
			-- Hide the direction requestor.
		do
			direction_request_shown := False
			if exists then
				radio_box.hide
				radio_up.hide
				radio_down.hide
			end
		end

	enable_direction_request is
			-- Enable the direction requestor
		do
			direction_request_enabled := True
			if exists then
				radio_box.enable
				radio_up.enable
				radio_down.enable
			end
		end

	disable_direction_request is
			-- Disable the direction requestor
		do
			direction_request_enabled := False
			if exists then
				radio_box.disable
				radio_up.disable
				radio_down.disable
			end
		end

	show_match_case is
			-- Show match case requestor
		do
			case_check_shown := True
			if exists then
				case_check.show
			end
		end

	hide_match_case is
			-- Hide match case requestor
		do
			case_check_shown := False
			if exists then
				case_check.hide
			end
		end

	enable_match_case is
			-- Enable match case requestor
		do
			case_check_enabled := True
			if exists then
				case_check.enable
			end
		end

	disable_match_case is
			-- Disable match case requestor
		do
			case_check_enabled := False
			if exists then
				case_check.disable
			end
		end

	set_replace is
			-- Set dialog to search and replace.
		do
			private_is_replace := True
			if exists then
				set_title ("Replace")
				replace_button.enable
				replace_all_button.enable
				replace_edit.enable
				replace_static.enable
			end
		end

	set_replace_text (a_text: STRING)  is
			-- Set `replace_text' to `a_text'
		do
			private_replace_text := clone (a_text)
			if exists then
				replace_edit.set_text (a_text)
			end
		end

	set_search is
			-- Set dialog to search.
		do
			private_is_replace := False
			if exists then
				set_title ("Find")
				replace_button.disable
				replace_all_button.disable
				replace_edit.disable
				replace_static.disable
			end	
		end

	set_search_text (a_text: STRING) is
			-- Set `search_text' to `a_text'
		do
			private_search_text := clone (a_text)
			if exists then
				find_edit.set_text (a_text)
			end
		end

	add_find_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects find option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			find_actions.add (Current, a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			cancel_actions.add (Current, a_command, argument)
		end;

	add_replace_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			replace_actions.add (Current, a_command, argument)
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			replace_all_actions.add (Current, a_command, argument)
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the cancel option.
		do
			cancel_actions.remove (Current, a_command, argument)
		end;

	remove_find_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the find option.
		do
			find_actions.remove (Current, a_command, argument)
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace option.
		do
			replace_actions.remove (Current, a_command, argument)
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace all option.
		do
			replace_all_actions.remove (Current, a_command, argument)
		end;

feature {NONE} -- Implementation

	on_cancel is
			-- Execute `cancel' action.
		do
			private_replace_text := replace_edit.text
			private_search_text := find_edit.text
			cancel_actions.execute (Current, Void)
			Terminate (Idcancel)
		end

	on_control_id_command (control_id: INTEGER) is
			-- Set status of dialog on callback of the controls.
		do
			inspect
				control_id
			when
				Id_replace then
					replace_actions.execute (Current, Void)
			when
				Id_replaceall then
					replace_all_actions.execute (Current, Void)
			when
				Id_findnext then
					find_actions.execute (Current, Void)
			when
				Idc_casecheck then
					private_case_checked := case_check.checked
			when
				Idc_radiodown then
					private_direction_up := radio_up.checked
			when
				Idc_radioup then
					private_direction_up := radio_up.checked
			else
			end
		end

	setup_dialog is
		do
			word_check.hide
			if not case_check_enabled then
				disable_match_case
			end
			if not case_check_shown then
				hide_match_case
			end
			if not private_is_replace then
				set_search
			else
				set_replace
			end
			if private_case_checked then
				case_check.set_checked
			end
			if private_direction_up then
				radio_up.set_checked
			else
				radio_down.set_checked
			end
			if not direction_request_shown then
				hide_direction_request
			end
			if not direction_request_enabled then
				disable_direction_request
			end
			if
				private_search_text /= Void and then not
				private_search_text.is_empty
			then
				find_edit.set_text (private_search_text)
			end
			if
				private_replace_text /= Void and then not
				private_replace_text.is_empty
			then
				replace_edit.set_text (private_replace_text)
			end			
		end

	set_defaults is
		do
			case_check_shown := True
			case_check_enabled := True
			private_is_replace := True
			private_case_checked := False
			private_direction_up := False
			direction_request_shown := True
			direction_request_enabled := True
		end

	case_check_shown: BOOLEAN

	case_check_enabled: BOOLEAN

	private_is_replace: BOOLEAN

	private_case_checked: BOOLEAN

	private_direction_up: BOOLEAN

	direction_request_shown: BOOLEAN

	direction_request_enabled: BOOLEAN

	find_static: WEL_STATIC

	replace_static: WEL_STATIC

	private_replace_text: STRING

	private_search_text: STRING

	find_next_button: WEL_PUSH_BUTTON

	replace_button: WEL_PUSH_BUTTON

	replace_all_button: WEL_PUSH_BUTTON

	close: WEL_PUSH_BUTTON

	find_edit: WEL_SINGLE_LINE_EDIT

	replace_edit: WEL_SINGLE_LINE_EDIT

	word_check: WEL_CHECK_BOX

	case_check: WEL_CHECK_BOX

	radio_up: WEL_RADIO_BUTTON

	radio_down: WEL_RADIO_BUTTON

	radio_box: WEL_GROUP_BOX

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionSearchReplaceDialog"
		end

	Id_findnext: INTEGER is 3000

	Id_replace: INTEGER is 3011

	Id_replaceall: INTEGER is 3002

	Idc_static: INTEGER is -1

	Idc_findedit: INTEGER is 3007

	Idc_replaceedit: INTEGER is 3008

	Idc_wordcheck: INTEGER is 3009

	Idc_casecheck: INTEGER is 3010

	Idd_replacedialog: INTEGER is 108

	Idc_radioup: INTEGER is 3014

	Idc_radiodown: INTEGER is 3015

	Idc_radiobox: INTEGER is 3016

	Id_replacestatic: INTEGER is 3018

	Id_findstatic: INTEGER is 3017

feature {NONE} -- Inapplicable

	text_font: FONT

	label_font: FONT

	button_font : FONT 

	build is
		do
		end

	forbid_recompute_size is
		do
		end

	allow_recompute_size is
		do
		end

	set_label_font (f: FONT) is
		do
		end

	set_text_font (f: FONT) is
		do
		end

	set_button_font (f: FONT) is
		do
		end

feature {NONE}

	wel_item: POINTER

	wel_parent: WEL_COMPOSITE_WINDOW

feature {NONE} -- Inapplicable

	set_enclosing_size is
		do
		end

end -- class SEARCH_REPLACE_DIALOG_IMP



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

