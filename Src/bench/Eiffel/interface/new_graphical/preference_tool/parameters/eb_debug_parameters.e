indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create debugger_feature_height.make ("debugger_feature_height", rt, 214)
			create debugger_object_height.make ("debugger_object_height", rt, 214)
			create debugger_show_all_callers.make ("debugger_show_all_callers", rt, False)
			create debugger_do_flat_in_breakpoints.make ("debugger_do_flat_in_breakpoints", rt, True)
			create interrupt_every_n_instructions.make ("interrupt_every_n_instruction", rt, 500)
--			create raise_on_error.make ("raise_on_error", rt, True)
		end

feature -- Access

	debugger_feature_height: EB_INTEGER_RESOURCE
	debugger_object_height: EB_INTEGER_RESOURCE
	interrupt_every_n_instructions: EB_INTEGER_RESOURCE
	debugger_show_all_callers: EB_BOOLEAN_RESOURCE
	debugger_do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE

end -- class EB_DEBUG_PARAMETERS
