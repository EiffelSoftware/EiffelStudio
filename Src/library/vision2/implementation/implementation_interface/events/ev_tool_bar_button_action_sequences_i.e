indexing
	description:
		"Action sequences for EV_TOOL_BAR_BUTTON_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_I


feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when button is pressed then released.
		do
			if select_actions_internal = Void then
				select_actions_internal :=
					 create_select_actions
			end
			Result := select_actions_internal
		ensure
			not_void: Result /= Void
		end

	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when drop down button is pressed.
		do
			if drop_down_actions_internal = Void then
				drop_down_actions_internal :=
					create_drop_down_actions
			end
			Result := drop_down_actions_internal
		end

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
		deferred
		end

	select_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 	Create a drop down action sequence.
		deferred
		end

	drop_down_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Implementation of once per object `drop_down_acions'.

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

