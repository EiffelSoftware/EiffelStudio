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
		require
			texts_exists: title /= Void and message /= Void
		deferred
		ensure
			texts_written: title.text /= Void and message.text /= Void
	end

	display_pixmap is
			-- Draw pixmap
		local
			fi: FILE_NAME
		do
			create fi.make_from_string (wizard_pixmaps_path)
			fi.extend (pixmap_location)
			pixmap.set_with_named_file (fi)
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

feature -- Settings

	set_updatable_entries (tab: ARRAY[ACTION_SEQUENCE[TUPLE[]]]) is
			-- Set the actions which imply a change
			-- in the user entries, so that we know that going forward
			-- will be done by re-computed the data.
		local
			i: INTEGER
		do
			from
				i:= 1
			until
				i > tab.count
			loop
				tab.item(i).extend (~change_entries)
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
