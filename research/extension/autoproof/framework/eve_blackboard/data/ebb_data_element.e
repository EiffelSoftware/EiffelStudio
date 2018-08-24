note
	description: "Parent class for different data elements."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EBB_DATA_ELEMENT

feature -- Access

	last_check_time: detachable DATE_TIME
			-- Time of last check.

	last_check_tool: detachable EBB_TOOL
			-- Tool of last check.

feature -- Element change

	set_last_check_time (a_time: like last_check_time)
			-- Set `last_check_time' to `a_time'.
		do
			last_check_time := a_time
		ensure
			last_check_time_set: last_check_time = a_time
		end

	set_last_check_tool (a_tool: like last_check_tool)
			-- Set `last_check_tool' to `a_tool'.
		do
			last_check_tool := a_tool
		ensure
			last_check_tool_set: last_check_tool = a_tool
		end

end
