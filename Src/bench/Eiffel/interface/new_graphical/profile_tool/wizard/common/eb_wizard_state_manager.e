indexing
	description	: "State navigator"
	author		: "Pascal FREUND, Arnaud PICHERY [arnaud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WIZARD_STATE_MANAGER

inherit
	EB_WIZARD_SHARED
		export
			{NONE} all
			{ANY} first_window, history, main_box
		end

feature {EB_WIZARD_WINDOW} -- Basic Operations

	back is
			-- Go to the previous state.
		require
			possible: history.count > 1 and then not history.isfirst
		do
			history.item.update_state_information
			history.back

			first_window.lock_update
			history.item.clean_screen
			history.item.display
			first_window.unlock_update
		ensure
			moved_back: history.index = old history.index - 1
		end
	
	next is
			-- Go to the next step.
		do
			if not history.islast then
				from
				until
					history.islast
				loop
					history.remove_right
				end
			end
			history.item.update_state_information
			history.item.proceed_with_current_info
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

	proceed_with_new_state(a_window: EB_WIZARD_STATE_WINDOW) is
			-- Proceed with new step , the next step being 'a_window'.
		require
			window_exists: a_window /= Void
		do
			history.extend (a_window)
			history.go_i_th (history.count)
			first_window.lock_update
			a_window.clean_screen
			a_window.display
			first_window.unlock_update
		ensure
			new_state_accessed: history.count = old history.count + 1
		end

feature {NONE} -- Implementation

	destroying_wizard: BOOLEAN
			-- Is the wizard being currently destroyed?

end -- class EB_WIZARD_STATE_MANAGER
