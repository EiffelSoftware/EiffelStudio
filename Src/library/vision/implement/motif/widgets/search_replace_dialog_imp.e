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
		rename
			is_cascade_grab as dialog_primary_application_modal,
			is_exclusive_grab as dialog_full_application_modal,
			is_no_grab as dialog_modeless,
			set_cascade_grab as set_dialog_primary_application_modal,
			set_exclusive_grab as set_dialog_full_application_modal,
			set_no_grab as set_dialog_modeless
		end;

	DIALOG_IMP
		rename
			popup as dialog_popup
		redefine	
			parent
		end;

	DIALOG_IMP
		redefine	
			parent, popup
		select
			popup
		end;

	TERMINAL_IMP
		rename
			make as terminal_make
		undefine
			lower, raise, hide,
			show, destroy,  is_form,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, created_dialog_automatically, create_widget
		redefine
			parent, set_default, children_list
		end;

	MEL_FORM_DIALOG
		rename
			make as mel_form_make,
			foreground_color as mel_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_foreground_color as mel_set_foreground_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine
			parent, set_default
		select
			form_make_no_auto_unmanage, form_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_search_replace: SEARCH_REPLACE_DIALOG; oui_parent: COMPOSITE) is
			-- Create a search_replace_dialog
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			make_no_auto_unmanage (a_search_replace.identifier, mc);
			a_search_replace.set_dialog_imp (Current);
			initialize (parent)
		end

feature -- Access

	parent: MEL_DIALOG_SHELL

feature -- Status report

	case_sensitive: BOOLEAN is
			-- Is search and replace to be case sensitive?	
		do
			Result := case_sensitive_t.is_managed and then
				case_sensitive_t.is_sensitive and then
				case_sensitive_t.state
		end

	replace_mode: BOOLEAN is
			-- Is this dialog to do a replace?
		do
			Result := replace_form.is_managed
		end

	replace_text: STRING is
			-- Text to replace `search_text' with.
		do
			Result := replace_tf.string
		end

	search_text: STRING is 
			-- Text to search for
		do
			Result := find_tf.string
		end

	search_upwards: BOOLEAN is
			-- Do this search from the bottom up?
		do
			Result := find_backwards_t.is_managed and then
				find_backwards_t.is_sensitive and then
				find_backwards_t.state
		end

feature -- Status setting

	show_direction_request is
			-- Show the direction requestor
		do
			find_backwards_t.manage
		end

	hide_direction_request is
			-- Hide the direction requestor.
		do
			find_backwards_t.unmanage
		end

	enable_direction_request is
			-- Enable the direction requestor
		do
			find_backwards_t.set_sensitive 
		end

	disable_direction_request is
			-- Disable the direction requestor
		do
			find_backwards_t.set_insensitive
		end

	show_match_case is
			-- Show match case requestor
		do
			case_sensitive_t.manage
		end;

	hide_match_case is
			-- Hide match case requestor
		do
			case_sensitive_t.unmanage
		end

	enable_match_case is
			-- Enable match case requestor
		do
			case_sensitive_t.set_sensitive
		end

	disable_match_case is
			-- Disable match case requestor
		do
			case_sensitive_t.set_insensitive
		end

	set_replace is
			-- Set dialog to search and replace.
		do
			if not replace_form.is_managed then
				replace_form.manage;
				replace_b.manage;
				replace_all_b.manage;
			end
		end

	set_replace_text (a_text: STRING)  is
			-- Set `replace_text' to `a_text'
		do
			replace_tf.set_string (a_text)
		end

	set_search is
			-- Set dialog to search.
		do
			if replace_form.is_managed then
				replace_form.unmanage	
				replace_b.unmanage;
				replace_all_b.unmanage;
			end
		end

	set_search_text (a_text: STRING) is
			-- Set `search_text' to `a_text'
		do
			find_tf.set_string (a_text)
		end

feature -- Element change

	add_find_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects find option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (find_b.activate_command);
			if list = Void then
				!! list.make;
				find_b.set_activate_callback (list, Void);
				find_tf.set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (cancel_b.activate_command);
			if list = Void then
				!! list.make;
				cancel_b.set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_replace_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (replace_b.activate_command);
			if list = Void then
				!! list.make;
				replace_b.set_activate_callback (list, Void);
				replace_tf.set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (replace_all_b.activate_command);
			if list = Void then
				!! list.make;
				replace_all_b.set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Update

	popup is
			-- Popup the dialog
		do
			find_b.set_show_as_default (1);
			dialog_popup
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the cancel option.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (cancel_b.activate_command);
			if list /= Void then	
				list.remove_command (a_command, argument)
			end;
		end;

	remove_find_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the find option.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (find_b.activate_command);
			if list /= Void then	
				list.remove_command (a_command, argument)
				list := vision_command_list (find_tf.activate_command);
				list.remove_command (a_command, argument)
			end;
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace option.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (replace_b.activate_command);
			if list /= Void then	
				list.remove_command (a_command, argument);
				list := vision_command_list (replace_tf.activate_command);
				list.remove_command (a_command, argument)
			end;
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace all option.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (replace_all_b.activate_command);
			if list /= Void then	
				list.remove_command (a_command, argument)
			end
		end;

feature {NONE} -- Implementation

	buttons_form: MEL_FORM;

	find_form, replace_form, toggle_form: MEL_FORM;

	find_b, replace_b, replace_all_b, cancel_b: MEL_PUSH_BUTTON_GADGET;
			-- Action buttons

	case_sensitive_t, find_backwards_t: MEL_TOGGLE_BUTTON_GADGET;	
			-- State toggles

	find_l, replace_l: MEL_LABEL_GADGET;
			-- Labels

	find_tf, replace_tf: MEL_TEXT_FIELD
			-- Text fields for find and replace text

	set_default is
			-- Create and attach the widgets.
		local
			rc: MEL_ROW_COLUMN;
			sep: MEL_SEPARATOR
		do
			!! rc.make ("searchRowColumn", Current, True);
			!! sep.make ("searchRowColumn", Current, True);

			!! find_form.make ("findForm", rc, True);
			!! find_l.make ("Find: ", find_form, True);
			!! find_tf.make ("findTextField", find_form, True);
			!! replace_form.make ("replaceForm", rc, True);
			!! replace_l.make ("Replace: ", replace_form, True);
			!! replace_tf.make ("replaceTextField", replace_form, True);

			!! toggle_form.make ("toggleForm", rc, True);
			!! case_sensitive_t.make ("Case sensitive", toggle_form, True);
			!! find_backwards_t.make ("Find backwards", toggle_form, True);

			!! buttons_form.make ("buttonForm", Current, True);
			!! find_b.make (" Find ", buttons_form, True);
			!! replace_b.make (" Replace ", buttons_form, True);
			!! replace_all_b.make (" Replace all ", buttons_form, True);
			!! cancel_b.make (" Cancel ", buttons_form, True);

			rc.attach_top;
			rc.attach_left;
			rc.attach_right;
			rc.attach_bottom_to_widget (sep);

			find_l.attach_bottom;
			find_l.attach_left;
			find_tf.attach_top;
			find_tf.attach_right;
			find_tf.attach_bottom;
			find_tf.attach_left_to_widget (find_l);
			find_tf.set_left_offset (5);
			find_l.set_left_offset (5);
			find_l.set_bottom_offset (2);

			case_sensitive_t.attach_left;
			case_sensitive_t.attach_top;
			case_sensitive_t.attach_bottom;

			find_backwards_t.attach_left;
			find_backwards_t.attach_bottom;
			find_backwards_t.attach_left_to_widget (case_sensitive_t);

			replace_l.attach_bottom;
			replace_l.attach_left;
			replace_tf.attach_top;
			replace_tf.attach_right;
			replace_tf.attach_bottom;
			replace_tf.attach_left_to_widget (replace_l);
			replace_tf.set_left_offset (5);
			replace_l.set_left_offset (5);
			replace_l.set_bottom_offset (2);

			sep.attach_left;
			sep.attach_right;
			sep.set_left_offset (2);
			sep.set_right_offset (2);
			sep.set_bottom_offset (5);
			sep.attach_bottom_to_widget (buttons_form);
			buttons_form.attach_left;
			buttons_form.attach_right;
			buttons_form.attach_bottom;

			find_b.set_left_offset (5);
			find_b.set_default_button_shadow_thickness (1);
			replace_b.set_left_offset (4);
			replace_b.set_right_offset (4);
			replace_b.set_default_button_shadow_thickness (1);
			replace_all_b.set_left_offset (4);
			replace_all_b.set_right_offset (4);
			replace_all_b.set_default_button_shadow_thickness (1);
			cancel_b.set_left_offset (4);
			cancel_b.set_right_offset (5);
			cancel_b.set_default_button_shadow_thickness (1);

			buttons_form.set_fraction_base (12);
			find_b.attach_left;
			replace_b.attach_left_to_position (3);
			replace_b.attach_right_to_position (6);
			replace_all_b.attach_left_to_position (6);
			replace_all_b.attach_right_to_position (9);
			find_b.attach_right_to_position (3);
			cancel_b.attach_left_to_position (9);
			cancel_b.attach_right;
		end;
		
feature {NONE} -- Implementation

    children_list: LIST [POINTER] is
            -- List of children C widget points to be used
            -- for resouce settting
        do
            Result := descendants
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

