note
	description:
		"Eiffel Vision standard dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

feature -- Access

	blocking_window: detachable EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show the window and wait until the user closed it.
			--| A window is required for the gtk implementation.
		local
			modal_to: detachable WEL_COMPOSITE_WINDOW
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
				-- Because on Windows, standard dialog may change the current
				-- working directory, we prevent it.
			create l_env
			l_dir := l_env.current_working_directory

			set_blocking_window (a_window)
			modal_to ?= a_window.implementation
			check modal_to /= Void end
			activate (modal_to)
			set_blocking_window (Void)

				-- After closing the dialog, we restore the current working directory.
			l_env.change_working_directory (l_dir)

			if selected then
				selected_button := internal_accept
				if ok_actions_internal /= Void then
					ok_actions_internal.call (Void)
				end
			else
				selected_button := ev_cancel
				if cancel_actions_internal /= Void then
					cancel_actions_internal.call (Void)
				end
			end
		end

	set_blocking_window (a_window: detachable EV_WINDOW)
			-- Set as transient for `a_window'.
		do
			blocking_window := a_window
		end

feature -- Status report

	selected_button: detachable STRING_32
			-- Label of last clicked button.

feature -- Deferred

	activate (a_parent: WEL_COMPOSITE_WINDOW)
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		deferred
		end

	selected: BOOLEAN
		deferred
		end

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




end -- class EV_STANDARD_DIALOG_IMP








