indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I
	
feature -- Event handling

	docked_actions: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE is
		-- Actions to be performed
		do
			if docked_actions_internal = Void then
				docked_actions_internal :=
					 create_docked_actions
			end
			Result := docked_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_docked_actions: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		deferred
		end

	docked_actions_internal: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.

end -- class EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I
