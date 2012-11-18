note
	description	: "Sub-Window which displays user entries needed in order to proceed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_STATE_WINDOW

inherit
	WIZARD_STATE_MANAGER

feature {NONE} -- Initialization

	make (an_info: like wizard_information)
			-- Create current object with information
			-- relative to current state 'an_info'.
			-- Should be redefined when needed.
		require
			info_exists: an_info /= Void
		do
			wizard_information := an_info.twin
			change_entries
		ensure
			information_set: wizard_information /= Void
		end

feature -- Access

	current_help_context: WIZARD_HELP_CONTEXT
			-- Help context for this window
		deferred
		end

	help_filename: STRING
			-- Path to HTML help file for current state window (without path on windows, with complete path on gtk)

feature -- Basic Operations

	clean_screen
			-- Clean Current screen, in order to display only
			-- the current sub-window.
		do
			main_box.wipe_out
		ensure
			done: main_box.count=0
		end

	display
			-- Display Current
		require
			clean_screen: main_box.count=0
		deferred
		ensure
			at_least_one_entry_asked_to_the_user: main_box.count>0
		end

	display_state_text
			-- Display message text relative to current state.
		require
			texts_exists: title /= Void and message /= Void
		deferred
		ensure
			texts_written: title.text /= Void
		end

	display_pixmap
			-- Draw pixmap
		local
			fi: STRING_32
			retried: BOOLEAN
			info_dialog: EV_INFORMATION_DIALOG
		do
			if not retried then
				fi := wizard_pixmap_path.extended (pixmap_file_name).name
				pixmap.set_with_named_file (fi)
			end
		rescue
			if not retried then
				create info_dialog.make_with_text ({STRING_32} "Unable to open the pixmap named%N%""+fi+"%"")
				info_dialog.show_modal_to_window (first_window)
				retried := True
				retry
			end
		end

	proceed_with_current_info
			-- Process user entries, and
			-- perform actions accordingly.
			-- This is executed when user press 'Next'.
		do
			entries_changed := False
		ensure
			entries_processed: not entries_changed
		end

	update_state_information
			-- Check User entries.
		require
			user_types_something: entries_changed
		do
			entries_checked := True
		ensure
			read_the_entries: entries_checked
		end

	cancel
			-- Action performed by Current when the user
			-- exits the wizard ( he presses "Cancel") .
		do
		end

	build
			-- Build widgets
		deferred
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

	display_help
			-- Show contextual help.
		local
			hc: WIZARD_HELP_CONTEXT
		do
			hc := current_help_context
			if hc /= Void then
				help_engine.show (hc)
			end
		end

	create_help_context (args: TUPLE): WIZARD_HELP_CONTEXT
			-- Create help context
		do
			create Result.make (Help_filename)
		ensure
			help_context_created: Result /= Void
		end

feature -- Settings

	set_updatable_entries (a_table: ARRAY [ACTION_SEQUENCE [TUPLE[]]])
			-- Set the actions which imply a change
			-- in the user entries, so that we know that going forward
			-- will be done by re-computed the data.
		local
			i: INTEGER
		do
			from
				i:= 1
			until
				i > a_table.count
			loop
				a_table.item(i).extend (agent change_entries)
				a_table.item(i).extend (agent check_wizard_status)
				i := i + 1
			end
		end

	change_entries
			-- The user clicked on the page, which
			-- implies state_information re-computation.
		do
			entries_changed := True
		ensure
			entries_changed: entries_changed
		end

	set_help_filename (a_filename: like help_filename)
			-- Set `help_filename' with `a_filename'.
		require
			non_void_filename: a_filename /= Void
		do
			help_filename := a_filename
		ensure
			help_filename_set: help_filename.is_equal (a_filename)
		end

feature -- Access

	entries_checked: BOOLEAN
			-- Are the entries checked ?

	entries_changed: BOOLEAN
			-- Did the user entries changed since last time ?
			-- This boolean is used in order to do a smart "next".

	pixmap_location: FILE_NAME_32
			-- Path in which can be found the pixmap associated with
			-- the current state.
			-- Use `pixmap_file_name' instead.
		deferred
		ensure
			exists: Result /= Void
		end

	pixmap_file_name: STRING_32
			-- Name of a file with a pixmap associated with the current state.
		do
			Result := pixmap_location.to_string_32
		ensure
			result_attached: attached Result
		end

	message: EV_LABEL
			-- Page message

	title: EV_LABEL
			-- Page title.

	subtitle: EV_LABEL
			-- Page subtitle

	is_final_state: BOOLEAN
		do
		end

feature -- Tools

	string_cleaner: STRING_CLEANER
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
