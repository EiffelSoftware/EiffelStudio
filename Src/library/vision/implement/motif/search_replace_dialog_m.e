indexing

	description:
		"Dialog to ask for search or search and replace information";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SEARCH_REPLACE_DIALOG_M

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

	DIALOG_M
		redefine	
			parent
		end;

	TERMINAL_M
		rename
			make as terminal_make
		undefine
			lower, raise, hide,
			show, destroy,  is_form,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, created_dialog_automatically, create_widget
		redefine
			parent, set_default
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
				find_backwards_t.state
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
				adjust_buttons;
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
				adjust_buttons
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
		do
			find_b.add_activate_callback (mel_vision_callback (a_command), argument)
			find_tf.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			cancel_b.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_replace_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			replace_b.add_activate_callback (mel_vision_callback (a_command), argument)
			replace_tf.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			replace_all_b.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the cancel option.
		do
			cancel_b.remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_find_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the find option.
		do
			find_b.remove_activate_callback (mel_vision_callback (a_command), argument)
			find_tf.remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace option.
		do
			replace_b.remove_activate_callback (mel_vision_callback (a_command), argument)
			replace_tf.remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace all option.
		do
			replace_all_b.remove_activate_callback (mel_vision_callback (a_command), argument)
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
			sep.set_bottom_offset (5);
			sep.attach_bottom_to_widget (buttons_form);
			buttons_form.attach_left;
			buttons_form.attach_right;
			buttons_form.attach_bottom;

			find_b.set_left_offset (5);
			replace_b.set_left_offset (5);
			replace_b.set_right_offset (5);
			replace_all_b.set_left_offset (5);
			replace_all_b.set_right_offset (5);
			cancel_b.set_left_offset (5);
			cancel_b.set_right_offset (5);

			adjust_buttons
		end;
		
	adjust_buttons is
			-- Adjust the buttons of the buttons_form.
		local
			i: INTEGER;
			list: LINKED_LIST [MEL_RECT_OBJ];
			mel_obj: MEL_RECT_OBJ;
			c: INTEGER
		do
			!! list.make;
			i := i + 1; -- `find' button always managed
			list.extend (find_b)
			if (replace_b.is_managed) then
				i := i + 1;
				list.extend (replace_b)
			end;
			if (replace_all_b.is_managed) then
				i := i + 1;
				list.extend (replace_all_b)
			end;
			i := i + 1; -- `cancel' button always managed
			list.extend (cancel_b)
			buttons_form.unmanage;
			c := list.count;
			list.start;
			check
				valid_c: c = 2 or else c = 4
			end;
			if c = 2 then
				buttons_form.set_fraction_base (2);
				mel_obj := list.item;
				mel_obj.attach_left;
				mel_obj.attach_right_to_position (1);
				list.forth;
				mel_obj := list.item;
				mel_obj.attach_right;
				mel_obj.attach_left_to_position (1);
			else  -- c = 4
				buttons_form.set_fraction_base (4);
				mel_obj := list.item;
				mel_obj.attach_left;
				mel_obj.attach_right_to_position (1);
				list.forth;
				mel_obj := list.item;
				mel_obj.attach_left_to_position (1);
				mel_obj.attach_right_to_position (2);
				list.forth;
				mel_obj := list.item;
				mel_obj.attach_left_to_position (2);
				mel_obj.attach_right_to_position (3);
				list.forth;
				mel_obj := list.item;
				mel_obj.attach_right;
				mel_obj.attach_left_to_position (3);
			end;
			buttons_form.manage
		end

end -- class SEARCH_REPLACE_DIALOG_M


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
