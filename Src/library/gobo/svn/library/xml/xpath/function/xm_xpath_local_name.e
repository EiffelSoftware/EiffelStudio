indexing

	description:

		"Objects that implement the XPath local-name() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_LOCAL_NAME

inherit

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			simplify, evaluate_item
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Establish invariant
		do
			name := "local-name"; namespace_uri := Xpath_standard_functions_uri
			fingerprint := Local_name_function_type_code
			minimum_argument_count := 0
			maximum_argument_count := 1
			create arguments.make (1)
			arguments.set_equality_tester (expression_tester)
			initialized := True
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, where known
		do
			Result := type_factory.string_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE is
			-- Type of argument number `argument_number'
		do
			create Result.make_optional_node
		end

feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]) is
			-- Perform context-independent static optimizations.
		do
			use_context_item_as_default
			Precursor (a_replacement)
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item to `a_result'.
		do
			arguments.item (1).evaluate_item (a_result, a_context)
			if a_result.item = Void then
				a_result.put (create {XM_XPATH_STRING_VALUE}.make (""))
			elseif not a_result.item.is_error then
				if not a_result.item.is_node then
					a_result.put (create {XM_XPATH_STRING_VALUE}.make (""))
				else
					a_result.put (create {XM_XPATH_STRING_VALUE}.make (a_result.item.as_node.local_part))
				end
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_exactly_one
		end

end
	
