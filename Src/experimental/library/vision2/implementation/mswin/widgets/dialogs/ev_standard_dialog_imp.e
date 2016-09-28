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

feature -- Access

	blocking_window: detachable EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status setting

	hide
			-- <Precursor>
		local
			l_null, l_parent: POINTER
			l_enumerator: WEL_WINDOW_ENUMERATOR
			l_children: ARRAYED_LIST [POINTER]
		do
				-- Get all windows of the system, and find the window which is owned
				-- by `hwnd_parent'. If found we send the WM_CLOSE message that will
				-- close it, having the effect of hiding the window.
			create l_enumerator
			l_children := l_enumerator.enumerate_all_hwnds
			l_parent := hwnd_parent
			from
				l_children.start
			until
				l_children.after
			loop
				if {WEL_API}.get_window (l_children.item, {WEL_GW_CONSTANTS}.gw_owner) = l_parent then
						-- We found our dialog, we can terminate the iteration.
					{WEL_API}.send_message (l_children.item, {WEL_WM_CONSTANTS}.wm_close, l_null, l_null)
					l_children.finish
				else
					l_children.forth
				end
			end
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show the window and wait until the user closed it.
			--| A window is required for the gtk implementation.
		local
			modal_to: detachable WEL_COMPOSITE_WINDOW
			l_env: EXECUTION_ENVIRONMENT
			l_dir: PATH
		do
				-- Because on Windows, standard dialog may change the current
				-- working directory, we prevent it.
			create l_env
			l_dir := l_env.current_working_path

			set_blocking_window (a_window)
			modal_to ?= a_window.implementation
			check modal_to /= Void then end
			activate (modal_to)
			set_blocking_window (Void)

				-- After closing the dialog, we restore the current working directory.
			l_env.change_working_path (l_dir)

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

	selected_button: detachable IMMUTABLE_STRING_32
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	destroy
			-- <Precursor>
		do
			if not is_destroyed then
					-- No one should be referencing Current anymore.
				set_is_destroyed (True)
				dispose
			end
		end

	dispose
		deferred
		end

	hwnd_parent: POINTER
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_STANDARD_DIALOG_IMP








