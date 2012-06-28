indexing

	description:

		"Eiffel agent actual arguments"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_AGENT_ARGUMENT_OPERAND

inherit

	ET_ARGUMENT_OPERAND

	ET_AGENT_ARGUMENT_OPERAND_ITEM

feature -- Access

	agent_actual_argument: ET_AGENT_ARGUMENT_OPERAND is
			-- Agent actual argument in comma-separated list
		do
			Result := Current
		end

end
