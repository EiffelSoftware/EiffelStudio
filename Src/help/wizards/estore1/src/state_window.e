indexing
	description: "Sub-Window which displays user entries needed in order to proceed"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STATE_WINDOW

inherit
	STATE_MANAGER

feature -- Initialization

	make(an_info: like state_information) is
			-- Create current object with information
			-- relative to current state 'an_info'.
			-- Should be redefined when needed.
		do
			state_information := clone(an_info)
			change_entries
		ensure
			information_set: state_information /= Void
		end

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

	proceed_with_current_info is
			-- Process user entries, and 
			-- perform actions accordingly.
			-- This is executed when user press 'Next'.
		do
			entries_changed := FALSE
		ensure
			entries_processed: not entries_changed
		end

	update_state_information is
			-- Check User entries.
		require
			entries_not_yet_read: not entries_checked
			user_types_something: entries_changed
		do
			entries_checked := TRUE
		ensure
			read_the_entries: entries_checked	
		end

	build is
			-- Build widgets.
		require
			main_box_empty: main_box.count=0
		deferred
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

	cancel is
			-- Action performed by Current when the user
			-- exits the wizard ( he presses "Cancel") .
		do
		end

feature -- Settings

	change_entries is
			-- The user clicked on the page, which 
			-- implies state_information re-computation.
		do
			entries_changed := TRUE
		ensure
			entries_changed: entries_changed
		end

feature -- Access

	entries_checked: BOOLEAN
		-- Are the entries checked ?

	entries_changed: BOOLEAN
		-- Did the user entries changed since last time ?
		-- This boolean is used in order to do a smart "next".

end -- class STATE_WINDOW
