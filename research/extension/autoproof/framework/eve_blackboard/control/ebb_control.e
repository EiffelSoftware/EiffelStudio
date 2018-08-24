note
	description: "Base class for Blackboard control strategies."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EBB_CONTROL

inherit

	EBB_SHARED_ALL

feature {NONE} -- Initialization

	make
			-- Initialize basic control.
		do
		ensure
			not_running: not is_running
		end

feature -- Access

	name: STRING
			-- Name of control.
		deferred
		end

feature -- Status report

	is_running: BOOLEAN
			-- Is control running?

feature -- Status setting

	start
			-- Start control.
		do
			is_running := True
		ensure
			is_running: is_running
		end

	stop
			-- Stop control.
		do
			is_running := False
		ensure
			not_running: not is_running
		end

feature -- Basic operations

	think
			-- Let control think about future actions.
		deferred
		end

	create_new_tool_executions
			-- Create new tool executions to be run later.
		deferred
		end

end
