note

	description:

	"Objects that perform a cast on each item in a sequence"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_ATOMIC_SEQUENCE_CONVERTER

inherit

	XM_XPATH_UNARY_EXPRESSION
		redefine
			simplify, check_static_type, item_type, evaluate_item, create_iterator,
			compute_special_properties, is_node_sequence, create_node_iterator
		end

	XM_XPATH_ITEM_MAPPING_FUNCTION

create

	make

feature {NONE} -- Initialization

	make (a_sequence: XM_XPATH_EXPRESSION; a_required_type: XM_XPATH_ATOMIC_TYPE)
			-- Establish invariant.
		require
			sequence_not_void: a_sequence /= Void
			required_type_not_void: a_required_type /= Void
		do
			make_unary (a_sequence)
			required_type := a_required_type
			compute_static_properties
		ensure
			static_properties_computed: are_static_properties_computed
			base_expression_set: base_expression = a_sequence
			required_type_set: required_type = a_required_type
			static_properties_computed: are_static_properties_computed
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Determine the data type of the expression, if possible
		do
			Result := required_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	is_node_sequence: BOOLEAN
			-- Is `Current' a sequence of zero or more nodes?
		do
			Result := False
		end

feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION])
			-- Perform context-independent static optimizations.
		local
			l_sequence_extent: XM_XPATH_SEQUENCE_EXTENT
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			base_expression.simplify (l_replacement)
			if l_replacement.item.is_error then
				set_replacement (a_replacement, l_replacement.item)
			else
				set_base_expression (l_replacement.item)
			end
			if base_expression.is_value then
				-- TODO: possible BUG - no static context available to get compile-time dynamic context
				create_iterator (Void)
				if last_iterator.is_error then
					set_last_error (last_iterator.error_value)
				else
					create l_sequence_extent.make (last_iterator)
					set_replacement (a_replacement, l_sequence_extent)
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

	check_static_type (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE)
			-- Perform static type-checking of `Current' and its subexpressions.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
			l_cast_expression: XM_XPATH_CAST_EXPRESSION
		do
			create l_replacement.make (Void)
			base_expression.check_static_type (l_replacement, a_context, a_context_item_type)
			set_base_expression (l_replacement.item)
			if base_expression.is_error then
				set_replacement (a_replacement, base_expression)
			else
				if is_sub_type (base_expression.item_type, required_type) then
					set_replacement (a_replacement, base_expression)
				elseif not base_expression.cardinality_allows_many then
					create l_cast_expression.make (base_expression, required_type, base_expression.cardinality_allows_zero)
					l_cast_expression.set_parent (container)
					set_replacement (a_replacement, l_cast_expression)
				else
					a_replacement.put (Current)
				end
			end
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT)
			-- Evaluate as a single item to `a_result'.
		do
			base_expression.evaluate_item (a_result, a_context)
			if a_result.item /= Void and then not a_result.item.is_error then
				check
					atomic_value: a_result.item.is_atomic_value
				end
				a_result.item.as_atomic_value.convert_to_type (required_type)
				a_result.put (a_result.item.as_atomic_value.converted_value)
			end
		end

	create_iterator (a_context: XM_XPATH_CONTEXT)
			-- An iterator over the values of a base_expression
		local
			an_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
		do
			base_expression.create_iterator (a_context)
			an_iterator := base_expression.last_iterator
			if an_iterator.is_error then
				last_iterator := an_iterator
			else
				create {XM_XPATH_ITEM_MAPPING_ITERATOR} last_iterator.make (an_iterator, Current)
			end
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT)
			-- Create an iterator over a node sequence.
		do
			-- pre-condition is never met
		end

	mapped_item (a_item: XM_XPATH_ITEM): XM_XPATH_ITEM
			-- `a_item' mapped to base_expression
		do
			if a_item /= Void then
				check
					atomic_value: a_item.is_atomic_value
				end
				a_item.as_atomic_value.convert_to_type (required_type)
				Result := a_item.as_atomic_value.converted_value
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	required_type: XM_XPATH_ATOMIC_TYPE
			-- Target type

	display_operator: STRING
			-- Format `operator' for display
		do
			Result := "convert items to " + required_type.conventional_name
		end

	compute_special_properties
			-- Compute special properties.
		do
			Precursor
			set_non_creating
		end

invariant

	required_type_not_void: initialized implies required_type /= Void

end
