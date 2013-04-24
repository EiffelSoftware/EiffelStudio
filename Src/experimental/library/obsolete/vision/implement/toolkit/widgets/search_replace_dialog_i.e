note

	description:
		"Dialog to ask for search or search and replace information"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SEARCH_REPLACE_DIALOG_I

inherit
	TERMINAL_I

	DIALOG_I

feature -- Status report

	case_sensitive: BOOLEAN
			-- Is search and replace to be case sensitive?	
		deferred
		end

	replace_mode: BOOLEAN
			-- Is this dialog to do a replace?
		deferred
		end

	replace_text: STRING
			-- Text to replace `search_text' with.
		require
			replace_mode: replace_mode
		deferred
		end

	search_text: STRING 
			-- Text to search for
		deferred
		end

	search_upwards: BOOLEAN
			-- Do this search from the bottom up?
		deferred
		end

feature -- Status setting

	show_direction_request
			-- Show the direction requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	hide_direction_request
			-- Hide the direction requestor.
		require
			not_popped_up: not is_popped_up
		deferred
		end

	enable_direction_request
			-- Enable the direction requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	disable_direction_request
			-- Disable the direction requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	show_match_case
			-- Show match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	hide_match_case
			-- Hide match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	enable_match_case
			-- Enable match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	disable_match_case
			-- Disable match case requestor
		require
			not_popped_up: not is_popped_up
		deferred
		end

	set_replace
			-- Set dialog to search and replace.
		deferred
		ensure
			replace_mode: replace_mode
		end

	set_replace_text (a_text: STRING)
			-- Set `replace_text' to `a_text'
		require
			text_not_void: a_text /= Void
		deferred
		end

	set_search
			-- Set dialog to search.
		deferred
		ensure
			search_mode: not replace_mode
		end

	set_search_text (a_text: STRING)
			-- Set `search_text' to `a_text'
		require
			text_not_void: a_text /= Void
		deferred
		end

feature -- Element change

	add_find_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects find option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

	add_replace_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the cancel option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_find_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the find option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed 
			-- when the user selects the replace all option.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SEARCH_REPLACE_DIALOG_I

