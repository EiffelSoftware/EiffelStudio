note
	description: "Periodically invokes a separate agent."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_PERIODIC_AGENT_PROCESS

inherit
	CP_PERIODIC_PROCESS

create
	make_with_routine

feature {NONE} -- Initialization

	make_with_routine (a_routine: like routine; a_interval: like interval)
			-- Initialization for `Current'.
		require
			no_args: a_routine.valid_operands (Void)
		do
			routine := a_routine
			make (a_interval)
		end

feature -- Access

	routine: separate ROUTINE
			-- The agent to be invoked.


feature -- Basic operations

	run
			-- <Precursor>
		do
			routine_call (routine)
		end

feature {NONE} -- Implementation

	routine_call (a_routine: like routine)
			-- Support function to invoke a separate routine.
		do
			a_routine.call (Void)
		end

end
