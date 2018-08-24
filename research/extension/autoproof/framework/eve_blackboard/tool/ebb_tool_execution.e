note
	description: "An execution of a tool over the entire lifetime 'waiting', 'running', 'finished'."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_TOOL_EXECUTION

create
	make

feature {NONE} -- Initialization

	make (a_tool: attached like tool; a_configuration: attached like configuration; a_input: attached like input)
			-- Initialize tool instance.
		do
			tool := a_tool
			configuration := a_configuration
			input := a_input

			create created_time.make_now
			started_time := Void
			finished_time := Void
		ensure
			tool_set: tool = a_tool
			configuration_set: configuration = a_configuration
			input_set: input = a_input
		end

feature -- Access

	tool: attached EBB_TOOL
			-- Tool associated with this execution.

	configuration: attached EBB_TOOL_CONFIGURATION
			-- Configuration associated with this execution.

	input: attached EBB_TOOL_INPUT
			-- Input associated with this execution.

	instance: detachable EBB_TOOL_INSTANCE
			-- Instance of tool associated with this execution (if any).

feature -- Access: timing

	created_time: attached DATE_TIME
			-- Time this execution was created.

	started_time: detachable DATE_TIME
			-- Time this execution was started.

	finished_time: detachable DATE_TIME
			-- Time this execution was finished.

feature -- Status report

	is_running: BOOLEAN
			-- Is this execution running at the moment?
		do
			if attached instance as l_instance then
				Result := l_instance.is_running
			end
		end

	is_finished: BOOLEAN
			-- Is this execution finished?

	is_canceled: BOOLEAN
			-- Is this execution canceled?

feature -- Status setting

	set_finished
			-- Set execution to be finished.
		require
			not_finished: not is_finished
		do
			create finished_time.make_now

			instance := Void
			is_finished := True
		ensure
			not_running: not is_running
			finished: is_finished
			instance_cleared: instance = Void
		end

feature -- Basic operations

	start
			-- Start a new instance.
		require
			not_running: not is_running
			not_finished: not is_finished
		do
			create started_time.make_now

				-- Create new instance
			tool.create_new_instance (Current)
			instance := tool.last_instance
			instance.start
		ensure
			instance_set: not is_finished implies attached instance
			running: not is_finished implies is_running
		end

	cancel
			-- Cancel running execution.
		require
			not_finished: not is_finished
		do
			if attached instance as l_instance then
				l_instance.cancel
			end

			set_finished
			is_canceled := True
		ensure
			not_running: not is_running
			finished: is_finished
			instance_cleared: instance = Void
			canceled: is_canceled
		end

invariant
	started_time_set: is_running implies attached started_time
	finished_time_set: is_finished implies attached finished_time
	canceled_is_finished: is_canceled implies is_finished

end
