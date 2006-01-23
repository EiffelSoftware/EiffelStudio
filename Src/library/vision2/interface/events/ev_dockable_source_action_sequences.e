indexing
	description: "Action sequences for EV_DOCKABLE_SOURCE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCES
	
inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I

feature -- Event handling

	dock_started_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a dockable source is dragged.
		do
			Result := implementation.dock_started_actions
		ensure
			not_void: Result /= Void
		end
		
	dock_ended_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed after a dock completes from `Current'.
			-- Either to a dockable target or a dockable dialog.
		do
			Result := implementation.dock_ended_actions
		ensure
			not_void: Result /= Void
		end
		
	
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




end -- class EV_DOCKABLE_SOURCE_ACTION_SEQUENCES

