indexing
	description	: "Sub-Window which displays user entries needed in order to proceed"
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_STATE_WINDOW

inherit
	WIZARD_STATE_MANAGER

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- Create current object with information
			-- relative to current state 'an_info'.
			-- Should be redefined when needed.
		require
			info_exists: an_info /= Void
		do
			wizard_information := clone (an_info)
			change_entries
		ensure
			information_set: wizard_information /= Void
		end

feature -- Access

	current_help_context: WIZARD_HELP_CONTEXT is
			-- Help context for this window
		deferred		
		end	
		
	help_filename: STRING
			-- Path to HTML help file for current state window (without path on windows, with complete path on gtk)
		
feature -- Basic Operations

	clean_screen is
			-- Clean Current screen, in order to display only 
			-- the current sub-window.
		do
			main_box.wipe_out
		ensure
			done: main_box.count=0
		end

	display is
			-- Display Current
		require
			clean_screen: main_box.count=0
		deferred
		ensure
			at_least_one_entry_asked_to_the_user: main_box.count>0
		end

	display_state_text is
			-- Display message text relative to current state.
		require
			texts_exists: title /= Void and message /= Void
		deferred
		ensure
			texts_written: title.text /= Void
		end

	display_pixmap is
			-- Draw pixmap
		local
			fi: FILE_NAME
			retried: BOOLEAN
			info_dialog: EV_INFORMATION_DIALOG
		do
			if not retried then
				create fi.make_from_string (wizard_pixmaps_path)
				fi.extend (pixmap_location)
				pixmap.set_with_named_file (fi)
			end
		rescue
			if not retried then
				create info_dialog.make_with_text ("Unable to open the pixmap named%N%""+fi+"%"")
				info_dialog.show_modal_to_window (first_window)
				retried := True
				retry
			end
		end

	proceed_with_current_info is
			-- Process user entries, and 
			-- perform actions accordingly.
			-- This is executed when user press 'Next'.
		do
			entries_changed := False
		ensure
			entries_processed: not entries_changed
		end

	update_state_information is
			-- Check User entries.
		require
			user_types_something: entries_changed
		do
			entries_checked := True
		ensure
			read_the_entries: entries_checked	
		end

	cancel is
			-- Action performed by Current when the user
			-- exits the wizard ( he presses "Cancel") .
		do
		end

	build is
			-- Build widgets
		deferred
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

	display_help is
			-- Show contextual help.
		local
			hc: WIZARD_HELP_CONTEXT
		do
			hc := current_help_context
			if hc /= Void then
				help_engine.show (hc)
			end
		end

	create_help_context (args: TUPLE): WIZARD_HELP_CONTEXT is
			-- Create help context
		do			
			create Result.make (Help_filename)			
		ensure
			help_context_created: Result /= Void
		end
		
feature -- Settings

	set_updatable_entries (a_table: ARRAY [ACTION_SEQUENCE [TUPLE[]]]) is
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
				a_table.item(i).extend (~change_entries)
				i := i + 1
			end
		end

	change_entries is
			-- The user clicked on the page, which 
			-- implies state_information re-computation.
		do
			entries_changed := True
		ensure
			entries_changed: entries_changed
		end
	
	set_help_filename (a_filename: like help_filename) is
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

	pixmap_location: STRING is
			-- Path in which can be found the pixmap associated with
			-- the current state.
		deferred
		ensure
			exists: Result /= Void
		end

	message: EV_LABEL
			-- Page message

	title: EV_LABEL
			-- Page title.

	subtitle: EV_LABEL
			-- Page subtitle

	is_final_state: BOOLEAN is
		do
		end

feature -- Tools

	string_cleaner: STRING_CLEANER is
		once
			create Result.make
		end

end -- class WIZARD_STATE_WINDOW


--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
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

