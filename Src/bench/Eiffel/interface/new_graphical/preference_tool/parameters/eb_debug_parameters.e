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

feature -- Access

	debugger_feature_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_feature_height)
		end

	debugger_object_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_object_height)
		end

	interrupt_every_n_instructions: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.interrupt_every_n_instructions)
		end

	debugger_show_all_callers: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_show_all_callers)
		end

	debugger_do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_do_flat_in_breakpoints)
		end


end -- class EB_DEBUG_PARAMETERS
