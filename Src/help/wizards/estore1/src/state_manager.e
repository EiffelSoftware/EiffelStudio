indexing
	description: "State navigator"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	STATE_MANAGER

inherit
	SHARED

feature -- Basic Operations

	back is
			-- Go to the previous state.
		require
			possible: history.count>1
		local
			win: STATE_WINDOW
		do
			history.remove
			history.back
			history.item.clean_screen
			history.item.display
		ensure
			been_back: history.count>1 implies history.count = old history.count -1
		end
	
	next is
			-- Go to the next step.
		do
			history.item.update_state_information
			check
				entries_checked: history.item.entries_checked
			end
			if not history.item.entries_changed then
				history.forth
				history.item.display
			else
				history.item.proceed_with_current_info
			end
		end

	cancel_actions is
			-- Actions performed by Current when the user
			-- exits the wizard ( he presses "Cancel") .
		require
			meaningfull: history.count>0
		do
			from
				history.finish
			until
				history.before
			loop
				history.item.cancel
				history.back
			end
			history.wipe_out
		ensure
			ready_to_exit: history.count=0
		end

	proceed_with_new_state(a_window: STATE_WINDOW) is
			-- Proceed with new step , the next step being 'a_window'.
		require
			user_entries_checked: history.count>0 implies history.item.entries_checked
			window_exists: a_window /= Void
		do
			history.extend(a_window)
			history.go_i_th(history.count)
			a_window.clean_screen
			a_window.display
		ensure
			new_state_accessed: history.count = old history.count + 1
		end

feature -- Implementation

	state_information: WIZARD_INFORMATION
		-- State relative to Current State.

	final_state: BOOLEAN
		-- Is Current in a final state position ?

invariant
	state_information_defined: state_information /= Void
end -- class STATE_MANAGER
