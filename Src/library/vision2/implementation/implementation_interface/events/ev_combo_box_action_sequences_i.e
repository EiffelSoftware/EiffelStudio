indexing
	description:
		"Action sequences for EV_COMBO_BOX_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "$Date"
	revision: "$Revision"

deferred class
	 EV_COMBO_BOX_ACTION_SEQUENCES_I


feature -- Event handling

	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when drop down list is displayed.
		do
			if drop_down_actions_internal = Void then
				drop_down_actions_internal :=
					 create_drop_down_actions
			end
			Result := drop_down_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		deferred
		end

	drop_down_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `drop_down_actions'.
			
			
feature -- Event handling

	list_hidden_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when drop down list is hidden.
		do
			if list_hidden_actions_internal = Void then
				list_hidden_actions_internal :=
					 create_list_hidden_actions
			end
			Result := list_hidden_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_list_hidden_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a list hidden action sequence.
		deferred
		end

	list_hidden_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Implementation of once per object `list_hidden_actions'.

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

