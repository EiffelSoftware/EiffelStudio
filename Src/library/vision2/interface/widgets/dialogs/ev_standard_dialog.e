indexing
	description:
		"EiffelVision standard dialog."
	status: "See notice at end of class"
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

	make_with_title (a_title: STRING) is
			-- Initialize `Current' and assign `a_title' to `title'.
		require
			a_title_not_void: a_title /= Void
		do
			default_create
			set_title (a_title)
		end

feature -- Access

	title: STRING is
			-- Title of `Current' displayed in title bar.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title
		ensure
			bridge_ok: Result.is_equal (implementation.title)
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

	selected_button: STRING is
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
			-- Show `Current' modal with respect to `a_window'.
		require
			not_destroyed: not is_destroyed
			a_window_not_void: a_window /= Void
			dialog_modeless: blocking_window = Void
		do
			implementation.show_modal_to_window (a_window)
		end

	set_title (a_title: STRING) is
			-- Assign `a_title' to `title'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_title (a_title)
		ensure
			assigned: title.is_equal (a_title)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_STANDARD_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

invariant
	title_not_void: is_usable implies title /= Void

end -- class EV_STANDARD_DIALOG

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
