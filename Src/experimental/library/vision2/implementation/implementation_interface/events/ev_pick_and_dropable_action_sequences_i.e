note
	description:
		"Action sequences for EV_PICK_AND_DROPABLE_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I

feature -- Event handling

	pick_actions: EV_PND_START_ACTION_SEQUENCE
			-- Actions to be performed when `pebble' is picked up.
		do
			if attached pick_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pick_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pick_actions_internal: detachable EV_PND_START_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pick_ended_actions: EV_PND_FINISHED_ACTION_SEQUENCE
			-- Actions to be performed when a transport from `Current' ends.
		do
			if attached pick_ended_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pick_ended_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pick_ended_actions_internal: detachable EV_PND_FINISHED_ACTION_SEQUENCE
			-- Implementation of once per object `pick_ended_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when a pebble that fits here is picked.
		do
			if attached conforming_pick_actions_internal as l_result then
				Result := l_result
			else
				create Result
				conforming_pick_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	conforming_pick_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `conforming_pick_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when a pebble is dropped here.
		do
			if attached drop_actions_internal as l_result then
				Result := l_result
			else
				create Result
				drop_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	drop_actions_internal: detachable EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.
		note
			option: stable
		attribute
		end;

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




end












