indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I

feature -- Event handling

	dock_started_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			if dock_started_actions_internal = Void then
				dock_started_actions_internal :=
					 create_dock_started_actions
			end
			Result := dock_started_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_dock_started_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		do
			create Result
		end

	dock_started_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.

end -- class EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I
