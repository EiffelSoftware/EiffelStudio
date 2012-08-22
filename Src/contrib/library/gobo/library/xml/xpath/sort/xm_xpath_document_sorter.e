note

	description:

		"Objects that sort a sequence of nodes into document order"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_DOCUMENT_SORTER

inherit

	XM_XPATH_UNARY_EXPRESSION
		redefine
			simplify, optimize, compute_special_properties, promote, create_iterator,
			calculate_effective_boolean_value, is_document_sorter, as_document_sorter,
			item_type, create_node_iterator
		end

create

	make

feature {NONE} -- Initialization

	make (a_expression: XM_XPATH_EXPRESSION)
		require
			a_expression_not_void: a_expression /= Void
			a_expression_initialized: a_expression.are_static_properties_computed
		do
			make_unary (a_expression)
			if base_expression.context_document_nodeset or else base_expression.single_document_nodeset then
				create {XM_XPATH_LOCAL_ORDER_COMPARER} comparer
			else
				create {XM_XPATH_GLOBAL_ORDER_COMPARER} comparer
			end
			compute_static_properties
		end

feature -- Access

	comparer: XM_XPATH_NODE_ORDER_COMPARER
			-- Comparer

	is_document_sorter: BOOLEAN
			-- Is `Current' a document sorter?
		do
			Result := True
		end

	as_document_sorter: XM_XPATH_DOCUMENT_SORTER
			-- `Current' seen as a document sorter
		do
			Result := Current
		end

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, when known
		do
			Result := base_expression.item_type
		end
feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION])
			-- Perform context-independent static optimizations.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			base_expression.simplify (l_replacement)
			set_base_expression (l_replacement.item)
			if base_expression.is_error or else base_expression.ordered_nodeset then
				set_replacement (a_replacement, base_expression)
			else
				a_replacement.put (Current)
			end
		end

	optimize (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE)
			-- Perform optimization of `Current' and its subexpressions.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			base_expression.optimize (l_replacement, a_context, a_context_item_type)
			set_base_expression (l_replacement.item)
			if base_expression.is_error or else base_expression.ordered_nodeset then
				set_replacement (a_replacement, base_expression)
			else
				a_replacement.put (Current)
			end
		end

	promote (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_offer: XM_XPATH_PROMOTION_OFFER)
			-- Promote this subexpression.
		local
			l_promotion: XM_XPATH_EXPRESSION
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			a_offer.accept (Current)
			l_promotion := a_offer.accepted_expression
			if l_promotion /= Void then
				set_replacement (a_replacement, l_promotion)
			else
				a_replacement.put (Current)
				create l_replacement.make (Void)
				base_expression.promote (l_replacement, a_offer)
				if base_expression /= l_replacement.item then
					set_base_expression (l_replacement.item)
					reset_static_properties
				end
			end
		end

feature -- Evaluation

	create_iterator (a_context: XM_XPATH_CONTEXT)
			-- Iterator over the values of a sequence
		local
			an_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
		do
			base_expression.create_iterator (a_context)
			an_iterator := base_expression.last_iterator
			if an_iterator.is_error then
				last_iterator := an_iterator
			else
				if an_iterator.is_node_iterator then
					create {XM_XPATH_DOCUMENT_ORDER_ITERATOR} last_iterator.make (an_iterator.as_node_iterator, comparer)
				else
					if an_iterator.is_empty_iterator then
						last_iterator := an_iterator
					else
						create {XM_XPATH_INVALID_ITERATOR} last_iterator.make_from_string ("Unexpected sequence", Gexslt_eiffel_type_uri, "NON_NODE_SEQUENCE", Dynamic_error)
					end
				end
			end
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT)
			-- Iterator over a node sequence
		local
			l_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
		do
			base_expression.create_node_iterator (a_context)
			l_iterator := base_expression.last_node_iterator
			if l_iterator.is_error then
				last_node_iterator := l_iterator
			else
				create {XM_XPATH_DOCUMENT_ORDER_ITERATOR} last_node_iterator.make (l_iterator, comparer)
			end
		end

	calculate_effective_boolean_value (a_context: XM_XPATH_CONTEXT)
			-- Effective boolean value
		do
			base_expression.calculate_effective_boolean_value (a_context)
			last_boolean_value := base_expression.last_boolean_value
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_special_properties
			-- Compute special properties.
		do
			clone_special_properties (base_expression)
			set_ordered_nodeset
		end

	display_operator: STRING
			-- Format `operator' for display
		do
			Result := "sort unique"
		end

end

