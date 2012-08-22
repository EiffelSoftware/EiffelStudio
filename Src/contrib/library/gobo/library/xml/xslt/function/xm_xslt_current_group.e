note

	description:

		"Objects that implement the XSLT current-group() function"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_CURRENT_GROUP

inherit

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			pre_evaluate, create_iterator, compute_intrinsic_dependencies, is_current_group
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Establish invariant
		do
			name := "current-group"; namespace_uri := Xpath_standard_functions_uri
			fingerprint := Current_group_function_type_code
			minimum_argument_count := 0
			maximum_argument_count := 0
			create arguments.make (0)
			arguments.set_equality_tester (expression_tester)
			initialized := True
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, where known
		do
			Result := any_item
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	is_current_group: BOOLEAN
			-- Is `Current' the XSLT "current-group()" function?
		do
			Result := True
		end

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE
			-- Type of argument number `argument_number'
		do
			-- will never be called
		end

feature -- Status setting

	compute_intrinsic_dependencies
			-- Determine the intrinsic dependencies of an expression.
		do
			set_intrinsically_depends_upon_current_group
		end

feature -- Evaluation

	create_iterator (a_context: XM_XPATH_CONTEXT)
			-- Iterator over the values of a sequence
		local
			a_group_iterator: XM_XSLT_GROUP_ITERATOR [XM_XPATH_ITEM]
			an_evaluation_context: XM_XSLT_EVALUATION_CONTEXT
		do
			an_evaluation_context ?= a_context
			check
				evaluation_context: an_evaluation_context /= Void
				-- as this is an XSLT function
			end
			a_group_iterator := an_evaluation_context.current_group_iterator
			if a_group_iterator = Void then
				create {XM_XPATH_EMPTY_ITERATOR [XM_XPATH_NODE]} last_iterator.make
			else
				last_iterator := a_group_iterator.current_group_iterator
			end
		end

	pre_evaluate (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT)
			-- Pre-evaluate `Current' at compile time.
		do
			a_replacement.put (Current)
			-- Suppress compile-time evaluation
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality
			-- Compute cardinality.
		do
			set_cardinality_zero_or_more
		end

end


