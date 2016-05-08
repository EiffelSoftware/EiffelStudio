note

	description:

		"Eiffel inline agents"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2006-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_INLINE_AGENT

inherit

	ET_AGENT
		rename
			arguments as actual_arguments,
			set_arguments as set_actual_arguments
		redefine
			is_inline_agent,
			reset
		end

	ET_NESTED_CLOSURE
		rename
			arguments as formal_arguments
		end

feature {NONE} -- Initialization

	make (an_actual_args: like actual_arguments)
			-- Create a new inline agent.
		do
			agent_keyword := tokens.agent_keyword
			create {ET_AGENT_IMPLICIT_CURRENT_TARGET} target.make (Current)
			actual_arguments := an_actual_args
		ensure
			actual_arguments_set: actual_arguments = an_actual_args
		end

feature -- Initialization

	reset
			-- Reset inline agent as it was just after it was last parsed.
		do
			target.reset
			if attached {ET_AGENT_ARGUMENT_OPERAND_LIST} actual_arguments as l_actuals then
				l_actuals.reset
			else
				actual_arguments := Void
			end
			if attached type as l_type then
				l_type.reset
			end
			if attached formal_arguments as l_arguments then
				l_arguments.reset
			end
			if attached preconditions as l_preconditions then
				l_preconditions.reset
			end
			if attached postconditions as l_postconditions then
				l_postconditions.reset
			end
		end

feature -- Access

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			Result := agent_keyword.position
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			Result := agent_keyword
		end

feature -- Status report

	is_qualified_call: BOOLEAN = False
			-- Is current call qualified?

	is_inline_agent: BOOLEAN = True
			-- Is `Current' an inline agent?

	is_procedure: BOOLEAN
			-- Is the associated feature a procedure?
		do
			Result := (type = Void)
		ensure then
			definition: Result = (type = Void)
		end

feature {ET_AGENT_IMPLICIT_CURRENT_TARGET} -- Implicit node positions

	implicit_target_position: ET_AST_NODE
			-- Node used to provide a position to the implicit target if any
		do
			Result := first_leaf
		end

feature {ET_AGENT_IMPLICIT_OPEN_ARGUMENT} -- Implicit node positions

	implicit_argument_position: ET_AST_NODE
			-- Node used to provide a position to implicit open arguments if any
		do
			Result := last_leaf
		end

end
