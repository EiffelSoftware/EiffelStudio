indexing
	description: "Allows non GUI threads to add idle actions to GUI thread%
					%Protect all access to idle actions list"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_APPLICATION_IMP

inherit
	EV_APPLICATION_IMP
		redefine
			create_idle_actions
		end

create
	make

feature -- Event Handling

	create_idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a idle action sequence.
			-- (from EV_APPLICATION_ACTION_SEQUENCES_IMP)
		do
			create {EV_THREAD_NOTIFY_ACTION_SEQUENCE} Result
		end

end -- class EV_THREAD_APPLICATION_IMP
