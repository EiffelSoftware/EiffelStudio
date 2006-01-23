indexing
	description:
		"Action sequences for EV_PICK_AND_DROPABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I

feature -- Event handling


	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end
		
	pick_ended_actions: EV_PND_FINISHED_ACTION_SEQUENCE is
			-- Actions to be performed when a transport from `Current' ends.
			-- If transport completed successfully, then event data
			-- is target. If cancelled, then event data is Void.
		do
			Result := implementation.pick_ended_actions
		ensure
			not_void: Result /= Void
		end

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits here is picked.
		do
			Result := implementation.conforming_pick_actions
		ensure
			not_void: Result /= Void
		end


	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			Result := implementation.drop_actions
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




end

