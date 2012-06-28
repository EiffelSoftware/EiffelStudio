indexing

	description:

		"Eiffel prefix expressions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_PREFIX_EXPRESSION

inherit

	ET_FEATURE_CALL_EXPRESSION
		rename
			target as expression
		undefine
			reset,
			is_prefix_expression
		end

	ET_UNARY_EXPRESSION
		redefine
			reset,
			is_prefix_expression
		end

create

	make

feature {NONE} -- Initialization

	make (a_name: like name; e: like expression) is
			-- Create a new prefix feature call.
		require
			a_name_not_void: a_name /= Void
			e_not_void: e /= Void
		do
			name := a_name
			expression := e
		ensure
			name_set: name = a_name
			expression_set: expression = e
		end

feature -- Initialization

	reset is
			-- Reset expression as it was just after it was last parsed.
		do
			name.reset
			expression.reset
			is_boolean_operator := False
		end

feature -- Access

	name: ET_OPERATOR
			-- Feature name

	arguments: ET_ACTUAL_ARGUMENTS is
			-- Arguments
		do
		ensure then
			no_arguments: Result = Void
		end

	first_leaf: ET_AST_LEAF is
			-- First leaf node in current node
		do
			Result := name.first_leaf
		end

	position: ET_POSITION is
			-- Position of first character of
			-- current node in source code
		do
			Result := name.position
		end

feature -- Status report

	is_boolean_operator: BOOLEAN
			-- Is current prefix expression a boolean operator
			-- on a boolean expression?

	is_prefix_expression: BOOLEAN is True
			-- Is current expression a prefix expression?

feature -- Status setting

	set_boolean_operator (b: BOOLEAN) is
			-- Set `is_boolean_operator' to `b'.
		do
			is_boolean_operator := b
		ensure
			boolean_operator_set: is_boolean_operator = b
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR) is
			-- Process current node.
		do
			a_processor.process_prefix_expression (Current)
		end

invariant

	name_not_void: name /= Void

end
