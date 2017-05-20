note
	description:
		"Action sequences for EV_WINDOW_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WINDOW_ACTION_SEQUENCES_I


feature -- Event handling

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is requested to be closed.
		do
			if attached close_request_actions_internal as l_result then
				Result := l_result
			else
				create Result
				close_request_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	close_request_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `close_request_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	move_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when window moves.
		do
			if attached move_actions_internal as l_result then
				Result := l_result
			else
				create Result
				move_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	move_actions_internal: detachable EV_GEOMETRY_ACTION_SEQUENCE
			-- Implementation of once per object `move_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is shown.
		do
			if attached show_actions_internal as l_result then
				Result := l_result
			else
				create Result
				show_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	show_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `show_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	hide_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is hiden.
		do
			if attached hide_actions_internal as l_result then
				Result := l_result
			else
				create Result
				hide_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	hide_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `hide_actions'.
		note
			option: stable
		attribute
		end;

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











