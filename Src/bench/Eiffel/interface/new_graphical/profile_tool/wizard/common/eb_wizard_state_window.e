indexing
	description	: "Sub-Window which displays user entries needed in order to proceed"
	author		: "Pascal FREUND, Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WIZARD_STATE_WINDOW

inherit
	EB_WIZARD_STATE_MANAGER

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- Create current object with information
			-- relative to current state 'an_info'.
			-- Should be redefined when needed.
		require
			info_exists: an_info /= Void
		do
			wizard_information := an_info
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
			texts_written: title.text /= Void
		end

	proceed_with_current_info is
			-- Process user entries, and 
			-- perform actions accordingly.
			-- This is executed when user press 'Next'.
		deferred
		end

	update_state_information is
			-- Check User entries.
		do
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

feature -- Access

	message: EV_LABEL
			-- Page message

	title: EV_LABEL
			-- Page title.

	subtitle: EV_LABEL
			-- Page subtitle

	is_final_state: BOOLEAN is
			-- Is this state a final state? (False by default)
		do
		end

feature {NONE} -- Implementation

	wizard_information: EB_WIZARD_INFORMATION
			-- State relative to Current State.

end -- class WIZARD_STATE_WINDOW
