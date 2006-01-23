indexing
	description:
		"Action sequences for EV_TEXT_FIELD_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_FIELD_ACTION_SEQUENCES_I


feature -- Event handling

	return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when return key is pressed.
		do
			if return_actions_internal = Void then
				return_actions_internal :=
					 create_return_actions
			end
			Result := return_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a return action sequence.
		deferred
		end

	return_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Implementation of once per object `return_actions'.

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

