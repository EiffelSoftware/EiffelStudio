indexing
	description: "All shared attributes specific to the debugger"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	debug_tool_width: INTEGER is
		do
			Result := resources.get_integer ("debug_tool_width", 214)
		end

	debug_tool_height: INTEGER is
		do
			Result := resources.get_integer ("debug_tool_height", 214)
		end

	debug_tool_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("debug_tool_bar", true)
		end

	interrupt_every_n_instructions: INTEGER is
		do
			Result := resources.get_integer ("interrupt_every_n_instructions", 1)
		end

end -- class EB_DEBUG_TOOL_DATA
