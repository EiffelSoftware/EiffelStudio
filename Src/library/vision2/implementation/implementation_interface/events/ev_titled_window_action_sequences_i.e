note
	description:
		"Action sequences for EV_WINDOW_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TITLED_WINDOW_ACTION_SEQUENCES_I

feature -- Event handling

	maximize_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is maximized.
		do
			if attached maximize_actions_internal as l_result then
				Result := l_result
			else
				create Result
				maximize_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	maximize_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `maximize_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	minimize_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is minimized.
		do
			if attached minimize_actions_internal as l_result then
				Result := l_result
			else
				create Result
				minimize_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	minimize_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `minimize_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	restore_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is leaves `minimized'
			-- or `maximized' state.
		do
			if attached restore_actions_internal as l_result then
				Result := l_result
			else
				create Result
				restore_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	restore_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `minimize_actions'.
		note
			option: stable
		attribute
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




end











