indexing
	description:
		"Action sequences for EV_TEXT_COMPONENT_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP

inherit
	EV_TEXT_COMPONENT_ACTION_SEQUENCES_I


feature -- Event handling

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a change action sequence.
		do
			create Result			
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

