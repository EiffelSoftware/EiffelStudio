indexing

	description:
		"Dialog to ask for search or search and replace information";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SEARCH_REPLACE_DIALOG_I

inherit
	TERMINAL_I

	DIALOG_I

feature -- Status report

	case_sensitive: BOOLEAN is
			-- Is search and replace to be case sensitive?	
		deferred
		end

	replace_mode: BOOLEAN is
			-- Is this dialog to do a replace?
		deferred
		end

	replace_text: STRING is
			-- Text to replace `search_text' with.
		require
			replace_mode: replace_mode
		deferred
		end

	search_text: STRING is 
			-- Text to search for
		deferred
		end

	search_upwards: BOOLEAN is
			-- Do this search from the bottom up?
		deferred
		end

feature -- Status setting

	show_direction_request is
			-- Show the direction requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	hide_direction_request is
			-- Hide the direction requestor.
		require
			not_popped_up: not is_popped_up
		deferred
		end

	enable_direction_request is
			-- Enable the direction requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	disable_direction_request is
			-- Disable the direction requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	show_match_case is
			-- Show match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	hide_match_case is
			-- Hide match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	enable_match_case is
			-- Enable match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	disable_match_case is
			-- Disable match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	set_replace is
			-- Set dialog to search and replace.
		deferred
		ensure
			replace_mode: replace_mode
		end

	set_replace_text (a_text: STRING)  is
			-- Set `replace_text' to `a_text'
		require
			text_not_void: a_text /= Void
		deferred
		end

	set_search is
			-- Set dialog to search.
		deferred
		ensure
			search_mode: not replace_mode
		end

	set_search_text (a_text: STRING) is
			-- Set `search_text' to `a_text'
		require
			text_not_void: a_text /= Void
		deferred
		end

feature -- Element change

	add_find_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects find option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

	add_replace_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the cancel option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_find_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the find option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace all option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

end -- class SEARCH_REPLACE_DIALOG_I



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

