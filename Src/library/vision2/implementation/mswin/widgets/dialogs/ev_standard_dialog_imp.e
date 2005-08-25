indexing
	description:
		"Eiffel Vision standard dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

feature -- Access

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the window and wait until the user closed it.
			--| A window is required for the gtk implementation.
		local
			modal_to: WEL_COMPOSITE_WINDOW
		do
			set_blocking_window (a_window)
			modal_to ?= blocking_window.implementation
			activate (modal_to)
			set_blocking_window (Void)
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

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		do
			blocking_window := a_window
		end

feature -- Status report

	selected_button: STRING
			-- Label of last clicked button.

feature -- Deferred

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
		deferred
		end

	selected: BOOLEAN is
		deferred
		end

end -- class EV_STANDARD_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

