note
	description: "Blackboard control which doesn't do anything."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_IDLE_CONTROL

inherit

	EBB_CONTROL

create
	make

feature -- Access

	name: STRING = "Idle"
			-- <Precursor>

feature -- Basic operations

	think
			-- <Precursor>
		do
		end

	create_new_tool_executions
			-- <Precursor>
		do
		end

end
