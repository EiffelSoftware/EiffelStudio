indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET_ACTION_SEQUENCES
	
inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I

feature -- Event handling

	docked_actions: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE is
			-- Actions to be performed when a dockable source is dragged
		do
			Result := implementation.docked_actions
		ensure
			not_void: Result /= Void
		end

end -- class EV_DOCKABLE_TARGET_ACTION_SEQUENCES
