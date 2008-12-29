note

	description:
		"Dialog to ask for search or search and replace information"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SEARCH_REPLACE_DIALOG

inherit

	TERMINAL_OUI
		rename
			make as terminal_make
		undefine
			lower, raise
		redefine
			implementation
		end

	DIALOG
		rename
			implementation as dialog_imp
		end

create

	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a question dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.twin
			create {SEARCH_REPLACE_DIALOG_IMP} implementation.make (Current, a_parent);
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			in_replace_mode: replace_mode
		end;

feature -- Status report

	case_sensitive: BOOLEAN
			-- Is search and replace to be case sensitive?	
		require
			exists: not destroyed
		do
			Result := implementation.case_sensitive
		end

	replace_mode: BOOLEAN
			-- Is this dialog to do a replace?
		require
			exists: not destroyed
		do
			Result := implementation.replace_mode
		end

	replace_text: STRING
			-- Text to replace `search_text' with
		require
			exists: not destroyed;
			replace_mode: replace_mode
		do
			Result := implementation.replace_text
		end

	search_text: STRING
			-- Text to search for
		require
			exists: not destroyed;
		do
			Result := implementation.search_text
		end

	search_upwards: BOOLEAN
			-- Do this search from the bottom up?
		require
			exists: not destroyed;
		do
			Result := implementation.search_upwards
		end

feature -- Status setting

	show_direction_request
			-- Show the direction requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.show_direction_request
		end

	hide_direction_request
			-- Hide the direction requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.hide_direction_request
		end

	enable_direction_request
			-- Enable the direction requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.enable_direction_request
		end

	disable_direction_request
			-- Disable the direction requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.disable_direction_request
		end

	show_match_case
			-- Show match case requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.show_match_case
		end

	hide_match_case
			-- Hide match case requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.hide_match_case
		end

	enable_match_case
			-- Enable match case requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.enable_match_case
		end

	disable_match_case
			-- Disable match case requestor.
		require
			exists: not destroyed;
			not_popped_up: not is_popped_up
		do
			implementation.disable_match_case
		end

	set_replace
			-- Set dialog to search and replace.
		require
			exists: not destroyed
		do
			implementation.set_replace
		ensure
			replace_mode: replace_mode
		end

	set_replace_text (a_text: STRING)
			-- Set `replace_text' to `a_text'.
		require
			exists: not destroyed
		do
			implementation.set_replace_text (a_text)
		end

	set_search
			-- Set dialog to search.
		require
			exists: not destroyed;
		do
			implementation.set_search
		ensure
			search_mode: not replace_mode
		end

	set_search_text (a_text: STRING)
			-- Set `search_text' to `a_text'.
		require
			exists: not destroyed;
			valid_text: a_text /= Void
		do
			implementation.set_search_text (a_text)
		end

feature -- Element change

	add_find_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects find option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_find_action (a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects cancel option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_cancel_action (a_command, argument)
		end;

	add_replace_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_replace_action (a_command, argument)
		end;

	add_replace_all_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- user selects replace all option.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_replace_all_action (a_command, argument)
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed
			-- when the user selects the cancel option.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_cancel_action (a_command, argument)
		end;

	remove_find_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed
			-- when the user selects the find option.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_find_action (a_command, argument)
		end;

	remove_replace_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed
			-- when the user selects the replace option.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_replace_action (a_command, argument)
		end;

	remove_replace_all_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed
			-- when the user selects the replace all option.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_replace_all_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SEARCH_REPLACE_DIALOG_I;
			-- Implementation of search replace dialog

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




end -- class SEARCH_REPLACE_DIALOG

