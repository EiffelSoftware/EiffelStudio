note

	description:

		"Objects that implement the XPath one-or-more() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_ONE_OR_MORE

inherit

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			evaluate_item, create_iterator, create_node_iterator
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Establish invariant
		do
			name := "one-or-more"; namespace_uri := Xpath_standard_functions_uri
			fingerprint := One_or_more_function_type_code
			minimum_argument_count := 1
			maximum_argument_count := 1
			create arguments.make (1)
			arguments.set_equality_tester (expression_tester)
			set_argument_error_code ("FORG0004")
			initialized := True
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, where known
		do
			Result := arguments.item (1).item_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE
			-- Type of argument number `argument_number'
		do
			create Result.make_non_empty_sequence
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT)
			-- Evaluate as a single item to `a_result'.
		do
			arguments.item (1).evaluate_item (a_result, a_context)
		end

	create_iterator (a_context: XM_XPATH_CONTEXT)
			-- An iterator over the values of a sequence
		do
			arguments.item (1).create_iterator (a_context)
			last_iterator := arguments.item (1).last_iterator
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT)
			-- Create an iterator over a node sequence
		do
			arguments.item (1).create_node_iterator (a_context)
			last_node_iterator := arguments.item (1).last_node_iterator
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality
			-- Compute cardinality.
		do
			set_cardinality_one_or_more
		end

end

