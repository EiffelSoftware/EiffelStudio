indexing
	description:
		"Action sequences for EV_WINDOW_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TITLED_WINDOW_ACTION_SEQUENCES_I

feature -- Event handling

	maximize_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is maximized.
		do
			if maximize_actions_internal = Void then
				maximize_actions_internal :=
					 create_maximize_actions
			end
			Result := maximize_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_maximize_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a maximized action sequence.
		deferred
		end

	maximize_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `maximize_actions'.
		
feature -- Event handling

	minimize_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is minimized.
		do
			if minimize_actions_internal = Void then
				minimize_actions_internal :=
					 create_minimize_actions
			end
			Result := minimize_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_minimize_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a minimized action sequence.
		deferred
		end

	minimize_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `minimize_actions'.
			
feature -- Event handling

	restore_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is leaves `minimized'
			-- or `maximized' state.
		do
			if restore_actions_internal = Void then
				restore_actions_internal :=
					 create_restore_actions
			end
			Result := restore_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_restore_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a minimized action sequence.
		deferred
		end

	restore_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `minimize_actions'.

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

