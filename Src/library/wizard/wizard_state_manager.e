indexing
	description: "State navigator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_STATE_MANAGER

inherit
	WIZARD_SHARED

feature {WIZARD_WINDOW, WIZARD_SMART_TEXT_FIELD} -- Basic Operations

	back is
			-- Go to the previous state.
		require
			possible: history.count > 1 and then not history.isfirst
			can_move: can_go_back
		do
			first_window.lock_update

			if history.item.entries_changed then
				history.item.update_state_information
			end
			history.back
			history.item.clean_screen
			history.item.display_pixmap
			history.item.display

			first_window.unlock_update
		ensure
			moved_back: history.index = old history.index - 1
		end

	next is
			-- Go to the next step.
		require
			can_move: can_go_back
		do
			first_window.lock_update

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

			if not first_window.is_destroyed then
				first_window.unlock_update
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

				from
					first_window.close_request_actions.start
				until
					first_window.close_request_actions.after
				loop
					first_window.close_request_actions.item.call ([])
					first_window.close_request_actions.forth
				end
				first_window.destroy
				destroying_wizard := False
			end
		ensure
			ready_to_exit: history.count=0
		end

	show_help is
			-- Show contextual help.
		do
			history.item.display_help
		end

feature {NONE} -- Internal Operations

	proceed_with_new_state(a_window: WIZARD_STATE_WINDOW) is
			-- Proceed with new step , the next step being 'a_window'.
		require
			user_entries_checked: history.count>0 implies history.item.entries_checked
			window_exists: a_window /= Void
		do
			history.extend (a_window)
			history.go_i_th (history.count)
			a_window.clean_screen
			a_window.display_pixmap
			a_window.display
		ensure
			new_state_accessed: history.count = old history.count + 1
		end

feature -- Validation

	can_go_back: BOOLEAN is
			-- can wizard move backwards?
		do
			Result := True
		end

	can_go_next: BOOLEAN is
			-- can wizard move forward?
		do
			Result := True
		end

	can_cancel: BOOLEAN is
			-- can wizard cancel?
		do
			Result := True
		end

	check_wizard_status is
			-- checks wizard status to see if it can back or next and enables
			-- disables next and back navigation methods
		do
			if can_go_back then
				first_window.enable_back_button
			else
				first_window.disable_back_button
			end
			if can_go_next then
				first_window.enable_next_button
			else
				first_window.disable_next_button
			end
			if can_cancel then
				first_window.enable_cancel_button
			else
				first_window.disable_cancel_button
			end
		end

feature {NONE} -- Implementation

	wizard_information: WIZARD_STATE_DATA
			-- Data about current state.

	destroying_wizard: BOOLEAN;
			-- Is the wizard being currently destroyed?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WIZARD_STATE_MANAGER


