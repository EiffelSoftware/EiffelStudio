indexing
	description:
		"Action sequences for EV_WINDOW_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WINDOW_ACTION_SEQUENCES_I


feature -- Event handling

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is requested to be closed.
		do
			if close_request_actions_internal = Void then
				close_request_actions_internal :=
					 create_close_request_actions
			end
			Result := close_request_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a close_request action sequence.
		deferred
		end

	close_request_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `close_request_actions'.


feature -- Event handling

	move_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when window moves.
		do
			if move_actions_internal = Void then
				move_actions_internal :=
					 create_move_actions
			end
			Result := move_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_move_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a move action sequence.
		deferred
		end

	move_actions_internal: EV_GEOMETRY_ACTION_SEQUENCE
			-- Implementation of once per object `move_actions'.


feature -- Event handling

	show_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is shown.
		do
			if show_actions_internal = Void then
				show_actions_internal :=
					 create_show_actions
			end
			Result := show_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_show_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a show action sequence.
		deferred
		end

	show_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `show_actions'.

end
