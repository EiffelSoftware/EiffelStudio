indexing

	description:
		"Dialog to ask for search or search and replace information";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
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

--creation
--	make

feature {NONE} -- Initialization

	make (a_search_replace: SEARCH_REPLACE_DIALOG; oui_parent: COMPOSITE)
is
			-- Create a search_replace_dialog
		do
		end

feature -- Status report

	case_sensitive: BOOLEAN is
			-- Is search and replace to be case sensitive?	
		do
		end

	replace_mode: BOOLEAN is
			-- Is this dialog to do a replace?
		do
		end

	replace_text: STRING is
			-- Text to replace `search_text' with.
		do
		end

	search_text: STRING is 
			-- Text to search for
		do
		end

	search_upwards: BOOLEAN is
			-- Do this search from the bottom up?
		do
		end

feature -- Status setting

	show_direction_request is
			-- Show the direction requestor
		do
		end

	hide_direction_request is
			-- Hide the direction requestor.
		do
		end

	enable_direction_request is
			-- Enable the direction requestor
		do
		end

	disable_direction_request is
			-- Disable the direction requestor
		do
		end

	show_match_case is
			-- Show match case requestor
		do
		end

	hide_match_case is
			-- Hide match case requestor
		do
		end

	enable_match_case is
			-- Enable match case requestor
		do
		end

	disable_match_case is
			-- Disable match case requestor
		do
		end

	set_replace is
			-- Set dialog to search and replace.
		do
		end

	set_replace_text (a_text: STRING)  is
			-- Set `replace_text' to `a_text'
		do
		end

	set_search is
			-- Set dialog to search.
		do
		end

	set_search_text (a_text: STRING) is
			-- Set `search_text' to `a_text'
		do
		end

feature

	add_find_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects find option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
		end;

	add_replace_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the cancel option.
		do
		end;

	remove_find_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the find option.
		do
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace option.
		do
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace all option.
		do
		end;

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
