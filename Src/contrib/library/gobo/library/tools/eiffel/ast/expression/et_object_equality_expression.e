note

	description:

		"Eiffel object equality expressions (i.e. '~' and '/~')"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_OBJECT_EQUALITY_EXPRESSION

inherit

	ET_BINARY_EXPRESSION
		redefine
			reset
		end

	ET_FEATURE_CALL_EXPRESSION
		rename
			target as left,
			arguments as right
		undefine
			reset
		end

create

	make

feature {NONE} -- Initialization

	make (a_left: like left; an_operator: like operator; a_right: like right)
			-- Create a new object equality expression.
		require
			a_left_not_void: a_left /= Void
			an_operator_not_void: an_operator /= Void
			a_right_not_void: a_right /= Void
		do
			left := a_left
			operator := an_operator
			right := a_right
		ensure
			left_set: left = a_left
			operator_set: operator = an_operator
			right_set: right = a_right
		end

feature -- Initialization

	reset
			-- Reset object expression as it was just after it was last parsed.
		local
			l_convert: ET_CONVERT_EXPRESSION
		do
			l_convert ?= left
			if l_convert /= Void then
				left := l_convert.expression
			end
			left.reset
			l_convert ?= right
			if l_convert /= Void then
				right := l_convert.expression
			end
			right.reset
		end

feature -- Access

	operator: ET_SYMBOL
			-- Operator symbol ('~' or '/~')

	name: ET_FEATURE_NAME
			-- Feature name when considered as a feature call to 'is_equal'
		once
			Result := tokens.is_equal_feature_name.twin
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_object_equality_expression (Current)
		end

invariant

	operator_not_void: operator /= Void

end
