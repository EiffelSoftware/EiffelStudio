indexing
	description: "State navigator"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_STATE_MANAGER

inherit
	WIZARD_SHARED

feature {WIZARD_WINDOW} -- Basic Operations

	back is
			-- Go to the previous state.
		require
			possible: history.count > 1 and then not history.isfirst
		do
			history.back
			history.item.clean_screen
			history.item.display_pixmap
			history.item.display
		ensure
			moved_back: history.index = old history.index - 1
		end
	
	next is
			-- Go to the next step.
		do
			if history.item.entries_changed and not history.islast then
				from
				until
					history.islast
				loop
					history.remove_right
				end
			end
			if history.islast then
				history.item.update_state_information
			end
			check
				entries_checked: history.item.entries_checked
			end
			if not history.islast and then not history.item.entries_changed then
				history.forth
				history.item.clean_screen
				history.item.display_pixmap
				history.item.display
			else
				history.item.proceed_with_current_info
			end
		ensure
			moved_forth: not history.item.is_final_state implies history.index = old history.index + 1
		end
	
	cancel_actions is
			-- Actions performed by Current when the user
			-- exits the wizard ( i.e. he presses "Cancel") .
		require
			meaningfull: history.count>0
		do
			if not destroying_wizard then
				destroying_wizard := True

				from
					history.finish
				until
					history.before
				loop
					history.item.cancel
					history.back
				end
				history.wipe_out

				first_window.destroy
				destroying_wizard := False
			end
		ensure
			ready_to_exit: history.count=0
		end

feature {NONE} -- Internal Operations

	proceed_with_new_state(a_window: WIZARD_STATE_WINDOW) is
			-- Proceed with new step , the next step being 'a_window'.
		require
			user_entries_checked: history.count>0 implies history.item.entries_checked
			window_exists: a_window /= Void
		do
			history.extend(a_window)
			history.go_i_th(history.count)
			a_window.clean_screen
			a_window.display_pixmap
			a_window.display
		ensure
			new_state_accessed: history.count = old history.count + 1
		end

feature {NONE} -- Implementation

	wizard_information: WIZARD_INFORMATION
			-- State relative to Current State.

	destroying_wizard: BOOLEAN
			-- Is the wizard being currently destroyed?

end -- class WIZARD_STATE_MANAGER
