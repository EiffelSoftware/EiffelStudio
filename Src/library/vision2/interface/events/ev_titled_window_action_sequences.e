indexing
	description:
		"Action sequences for EV_WINDOW."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TITLED_WINDOW_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_TITLED_WINDOW_ACTION_SEQUENCES_I

feature -- Event handling

	minimize_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is minimized.
		do
			Result := implementation.minimize_actions
		ensure
			not_void: Result /= Void
		end

	maximize_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is maximized.
		do
			Result := implementation.maximize_actions
		ensure
			not_void: Result /= Void
		end
		
	restore_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window leaves `maximized' or
			-- `minimized' state.
		do
			Result := implementation.restore_actions
		ensure
			not_void: Result /= Void
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
