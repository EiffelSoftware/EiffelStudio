indexing
	description:
		"Action sequences for EV_CONTAINER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_CONTAINER_ACTION_SEQUENCES_I


feature -- Event handling

	new_item_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when a new item is added.
		do
			if new_item_actions_internal = Void then
				new_item_actions_internal :=
					 create_new_item_actions
			end
			Result := new_item_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_new_item_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Create a new_item action sequence.
		deferred
		end

	new_item_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE;
			-- Implementation of once per object `new_item_actions'.

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

