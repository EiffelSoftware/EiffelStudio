indexing
	description: "Action sequences for EV_DOCKABLE_TARGET_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I
	
feature -- Event handling

	docked_actions: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE is
		-- Actions to be performed
		do
			if docked_actions_internal = Void then
				create docked_actions_internal
			end
			Result := docked_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	docked_actions_internal: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE;
			-- Implementation of once per object `docked_actions'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I

