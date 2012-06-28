indexing

	description:

		"Objects that implement the XPath remove() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_REMOVE

inherit

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			create_iterator, create_node_iterator, simplify
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Establish invariant
		do
			name := "remove"; namespace_uri := Xpath_standard_functions_uri
			fingerprint := Remove_function_type_code
			minimum_argument_count := 2
			maximum_argument_count := 2
			create arguments.make (2)
			arguments.set_equality_tester (expression_tester)
			initialized := True
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, where known
		do
			Result := arguments.item (1).item_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE is
			-- Type of argument number `argument_number'
		do
			inspect
				argument_number
			when 1 then
				create Result.make_any_sequence
			when 2 then
				create Result.make_single_integer
			end
		end

feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]) is
			-- Perform context-independent static optimizations
		local
			l_tail_expression: XM_XPATH_TAIL_EXPRESSION
		do
			Precursor (a_replacement)
			if a_replacement.item = Current then

				-- Recognize remove(seq, 1) as a tail expression.
				-- This is worth doing because tail expressions
				--  used in a recursive call are handled specially.

				if arguments.item (2).is_numeric_value and then arguments.item (2).as_numeric_value.is_platform_integer and then
					arguments.item (2).as_numeric_value.as_integer = 1 then
					create l_tail_expression.make (arguments.item (1), 2)
					a_replacement.put (Void)
					set_replacement (a_replacement, l_tail_expression)
				end
			end
		end

feature -- Evaluation

	create_iterator (a_context: XM_XPATH_CONTEXT) is
			-- Create iterator over the values of a sequence.
		local
			l_sequence: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
			l_item: XM_XPATH_ITEM
			l_count: INTEGER
			l_result: DS_CELL [XM_XPATH_ITEM]
		do
			last_iterator := Void
			arguments.item (1).create_iterator (a_context)
			l_sequence := arguments.item (1).last_iterator
			if l_sequence.is_error then
				last_iterator := l_sequence
			else
				create l_result.make (Void)
				arguments.item (2).evaluate_item (l_result, a_context)
				l_item := l_result.item
				check
					position_not_void: l_item /= Void
					-- Static typing
				end
				if l_item.is_error then
					create {XM_XPATH_INVALID_ITERATOR} last_iterator.make (l_item.error_value)
				else
					check
						integer: l_item.is_numeric_value
						-- static typing
					end
					if l_item.as_numeric_value.is_platform_integer then
						l_count := l_item.as_numeric_value.as_integer
						create {XM_XPATH_REMOVE_ITERATOR} last_iterator.make (l_sequence, l_count)
					else
						create {XM_XPATH_INVALID_ITERATOR} last_iterator.make_from_string ("Position exceeds implementation limit", Gexslt_eiffel_type_uri, "SEQUENCE_TOO_LONG", Dynamic_error)
					end
				end
			end
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT) is
			-- Create an iterator over a node sequence
		do
			create_iterator (a_context)
			last_node_iterator := last_iterator.as_node_iterator
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_zero_or_more
		end
		
end
	
