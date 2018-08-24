note
	description: "Represents a running tool."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EBB_TOOL_INSTANCE

feature {NONE} -- Initialization

	make (a_execution: attached like execution)
			-- Initialize tool instance.
		do
			execution := a_execution
			tool := a_execution.tool
			configuration := a_execution.configuration
			input := a_execution.input
		ensure
			execution_set: execution = a_execution
			tool_set: tool = a_execution.tool
			configuration_set: configuration = a_execution.configuration
			input_set: input = a_execution.input
		end

feature -- Access

	execution: attached EBB_TOOL_EXECUTION
			-- Tool execution associated with this instance.

	tool: attached EBB_TOOL
			-- Tool associated with this instance.

	configuration: attached EBB_TOOL_CONFIGURATION
			-- Configuration associated with this instance.

	input: attached EBB_TOOL_INPUT
			-- Input associated with this instance.

	status_message: detachable READABLE_STRING_GENERAL
			-- Status message of the tool.

feature -- Status report

	is_running: BOOLEAN
			-- Is instance running?
		deferred
		end

feature -- Element change

	set_status_message (a_string: READABLE_STRING_GENERAL)
			-- Set `status_message' to `a_string'.
		do
			status_message := a_string.twin
		end

feature {EBB_TOOL_EXECUTION} -- Basic operations

	start
			-- Start instance.
		deferred
		end

	cancel
			-- Cancel instance.
		deferred
		end

end
