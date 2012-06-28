indexing

	description:

		"Objects that implement the XPath position() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_POSITION

inherit
	
	XM_XPATH_SYSTEM_FUNCTION
		redefine
			pre_evaluate, evaluate_item, compute_intrinsic_dependencies, is_position_function
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Establish invariant.
		do
			name := "position"; namespace_uri := Xpath_standard_functions_uri
			fingerprint := Position_function_type_code
			minimum_argument_count := 0
			maximum_argument_count := 0
			create arguments.make (0)
			arguments.set_equality_tester (expression_tester)
			initialized := True
		end

feature -- Access

	is_position_function: BOOLEAN is
			-- Is `Current' an XPath position() function?
		do
			Result := True
		end

	item_type: XM_XPATH_ITEM_TYPE is
			-- Determine the data type of the expression, if possible
		do
			Result := type_factory.integer_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE is
			-- Type of argument number `argument_number'
		do

			-- This cannot be called for `Current', as it has no arguments.
			-- Therefore the pre-condition cannot be met, so we will not
			--  attempt to meet the post-condition.

		end

feature -- Status setting

	compute_intrinsic_dependencies is
			-- Determine the intrinsic dependencies of an expression.
		do
			set_intrinsically_depends_upon_position
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item to `a_result'.
		local
			l_context_position: INTEGER
		do
			if a_context = Void then
				a_result.put (create {XM_XPATH_INVALID_ITEM}.make_from_string ("Dynamic context is Void", Xpath_errors_uri, "FONC0001", Dynamic_error))
			elseif not a_context.is_context_position_set then
				a_result.put (create {XM_XPATH_INVALID_ITEM}.make_from_string ("Context position is not available",  Xpath_errors_uri, "FONC0001", Dynamic_error))
			else
				l_context_position := a_context.context_position
				if l_context_position = 0 then
					a_result.put (create {XM_XPATH_INVALID_ITEM}.make_from_string ("Context position cannot be zero", Xpath_errors_uri, "FONC0001", Dynamic_error))
				else
					a_result.put (create {XM_XPATH_MACHINE_INTEGER_VALUE}.make (l_context_position))
				end
			end
		ensure then
			possible_dynamic_error: a_result.item /= Void and then a_result.item.is_error implies
				a_result.item.error_value.type = Dynamic_error
		end


	pre_evaluate (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT) is
			-- Pre-evaluate `Current' at compile time.
		do
			a_replacement.put (Current)
			-- Forces pre-evaluation not to occur, as
			--  the value of `Current' depends upon the dynamic context.

		end
	
feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_exactly_one
		end
		
end

