indexing
	description: "[
		Interface representing a subset of some {TAGABLE_COLLECTION_I}
		defined by an expression.
		
		Filtering is based on defined tags in each of the itmes. The
		interface is collection and observer at the same time. That way
		changes in the original collection will be applied to the 
		filtered collection imediatly.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILTERED_COLLECTION_I [G -> TAGABLE_I]

inherit
	TAGABLE_COLLECTION_I [G]

	ACTIVE_COLLECTION_OBSERVER [G]

feature -- Status report

	is_expression_set: BOOLEAN
			-- Has `expression' been set yet?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Access

	expression: !STRING
			--
		require
			usable: is_interface_usable
			expression_set: is_expression_set
		deferred
		end

feature -- Status setting

	update_expression (a_expression: like expression)
			-- Set `expression' to `a_expression' and
			-- update `items' accordingly
		require
			usable: is_interface_usable
			expression_not_empty: not expression.is_empty
		deferred
		ensure
			expression_set: is_expression_set
			expression_updated: expression = a_expression
		end

invariant
	not_expression_set_implies_items_empty: not is_expression_set implies items.is_empty

end
