note

	description:

		"Eiffel precursor expressions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_PRECURSOR_EXPRESSION

inherit

	ET_PRECURSOR_CALL
		redefine
			parenthesis_call
		end

	ET_EXPRESSION
		undefine
			reset
		redefine
			is_instance_free
		end

create

	make

feature -- Access

	parenthesis_call: detachable ET_PARENTHESIS_EXPRESSION
			-- <Precursor>

feature -- Status report

	is_instance_free: BOOLEAN
			-- Does current expression not depend on 'Current' or its attributes?
			-- Note that we do not consider unqualified calls and Precursors as
			-- instance-free because it's not always possible syntactically
			-- to determine whether the feature being called is a class feature
			-- or not.
		do
			Result := False
		end

feature -- Setting

	set_parenthesis_call (a_target: ET_EXPRESSION; a_name: ET_PARENTHESIS_SYMBOL; a_arguments: ET_ACTUAL_ARGUMENT_LIST)
			-- <Precursor>
		do
			create parenthesis_call.make (a_target, a_name, a_arguments)
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_precursor_expression (Current)
		end

end
