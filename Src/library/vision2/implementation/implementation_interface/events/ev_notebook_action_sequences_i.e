indexing
	description:
		"Action sequences for EV_NOTEBOOK_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_NOTEBOOK_ACTION_SEQUENCES_I


feature -- Event handling

	selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `selected_item' changes.
		do
			if selection_actions_internal = Void then
				selection_actions_internal :=
					 create_selection_actions
			end
			Result := selection_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection action sequence.
		deferred
		end

	selection_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Implementation of once per object `selection_actions'.

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

