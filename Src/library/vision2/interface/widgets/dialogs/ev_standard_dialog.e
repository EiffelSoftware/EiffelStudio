indexing
	description:
		"EiffelVision standard dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "modal, ok, cancel"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG

inherit
	EV_ANY
		redefine
			implementation
		end

	EV_POSITIONABLE
		undefine
			initialize
		redefine
			implementation
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_title (a_title: STRING_GENERAL) is
			-- Initialize `Current' and assign `a_title' to `title'.
		require
			a_title_not_void: a_title /= Void
		do
			default_create
			set_title (a_title)
		ensure
			title_assigned: title.is_equal (a_title)
			cloned: title /= a_title
		end

feature -- Access

	title: STRING_32 is
			-- Title of `Current' displayed in title bar.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title
		ensure
			bridge_ok: Result.is_equal (implementation.title)
			cloned: Result /= implementation.title
		end

	blocking_window: EV_WINDOW is
			-- Window `Current' is a transient for.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.blocking_window
		ensure
			bridge_ok: Result = implementation.blocking_window
		end

feature -- Status report

	selected_button: STRING_32 is
			-- Label of last clicked button.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_button
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.selected_button)
		end

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			not_destroyed: not is_destroyed
			a_window_not_void: a_window /= Void
			dialog_modeless: blocking_window = Void
		do
			implementation.show_modal_to_window (a_window)
		ensure
				-- When a dialog is displayed modally, execution of code is
				-- halted until the dialog is closed or destroyed. Therefore,
				-- this postcondition will only be executed after the dialog
				-- is closed or destroyed.
			dialog_closed_so_no_blocking_window:
				not is_destroyed implies blocking_window = Void
		end

	set_title (a_title: STRING_GENERAL) is
			-- Assign `a_title' to `title'.
		require
			not_destroyed: not is_destroyed
			a_title_not_void: a_title /= Void
		do
			implementation.set_title (a_title)
		ensure
			assigned: title.is_equal (a_title)
			cloned: title /= a_title
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_STANDARD_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

invariant
	title_not_void: is_usable implies title /= Void

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




end -- class EV_STANDARD_DIALOG

