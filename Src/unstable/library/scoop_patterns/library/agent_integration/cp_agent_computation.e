note
	description: "[
		Task object that execute an agent.

		Note: There are several restrictions imposed on the imported agent.
		The first three items originate from {CP_AGENT_IMPORTER}:

		1)  Every closed argument has to be either truly separate or a basic
			expanded type. It is NOT sufficient to just declare the argument
			as separate, as this cannot	be checked due to a runtime limitation.

		2)  The target must be open.

		3)  There must not be any leftovers from a previous call,
			i.e. `operands' and {FUNCTION}.last_result must be Void.

		4)  The type of the target must not declare any attributes.
			This is because the target has to be created reflectively
			and provided to the agent uninitialized.

		5)  Except for the target, the agent must not have open arguments.

		The creation procedure `make_unsafe' does not check rules 1)
		and 4). If you want to use it, make sure that every closed
		argument is declared as	separate, and that the agent never
		touches an attribute of its target (implicitly or explicitly).
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_AGENT_COMPUTATION [RESULT_TYPE -> detachable separate ANY]

inherit

	CP_COMPUTATION [RESULT_TYPE]

	CP_ABSTRACT_AGENT_TASK [FUNCTION [ANY, TUPLE, RESULT_TYPE]]

create
	make_safe,
	make_unsafe,
	make_from_separate

feature -- Basic operations

	computed: RESULT_TYPE
			-- <Precursor>
		do
			Result := routine.item ([new_target])
		end

end
