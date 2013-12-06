note
	description: "Iteration cursor over the result of a query."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RESULT_CURSOR [G -> ANY]

inherit

	ITERATION_CURSOR [G]

	PS_ABEL_EXPORT

create {PS_ABSTRACT_QUERY}
	make

feature -- Access

	item: G
			-- Item at current cursor position.
		do
			check attached detachable_item as res then
				Result := res
			end
--			Result := attach (detachable_item)
		end

feature -- Status report

	after: BOOLEAN
			-- Are there no more items to iterate over?

feature -- Cursor movement

	forth
			-- Move cursor to next position.
		do
			if attached {PS_QUERY [ANY]} query as q then
				q.internal_transaction.repository.next_entry (q)
			else
				check attached {PS_TUPLE_QUERY [ANY]} query as tq then
					tq.internal_transaction.repository.next_tuple_entry (tq)
				end
			end
		ensure then
			item_is_identified: attached{TUPLE}item or (not after implies query.generic_type.is_expanded or query.internal_transaction.repository.is_identified (item, query.internal_transaction))
			item_can_be_handled: attached{PS_TUPLE_QUERY[ANY]} query or query.internal_transaction.repository.can_handle (item)
		end

feature {PS_ABEL_EXPORT} -- Basic operations

	set_entry (object: detachable ANY)
			-- Set `item' to `object', or after if `object' is Void.
		require
			actual_type_is_G: (object /= Void) implies (attached {G} object)
		do
			if attached {G} object as new_item then
				detachable_item := new_item
				after := False
				query.result_cache.extend (new_item)
			else
				after := True
			end
		ensure
			Void_means_after: object = Void implies after
			not_void_means_item: object /= Void implies not after and object = item
		end

feature {PS_ABSTRACT_QUERY} -- Initialization

	set_query (a_query: PS_ABSTRACT_QUERY [ANY, ANY])
			-- Set query to `a_query'. Part of initialization process.
		do
			detachable_query := a_query
		ensure
			query_set: query = a_query
		end

	query: PS_ABSTRACT_QUERY [ANY, ANY]
			-- Get the query which has `Current' as its result cursor.
		do
			Result := attach (detachable_query)
		end

	make
			-- Create a new result set.
		do
			after := true
		end

feature {NONE} -- Implementation

	detachable_item: detachable G
			-- `item' as detachable (Void safety).

	detachable_query: detachable PS_ABSTRACT_QUERY [ANY, ANY]
			-- `query' as detachable (Void safety).

invariant
	attached_item_or_after: attached detachable_item or after
	attached_query_or_after: attached detachable_query or after
	item_can_be_handled: not after and not attached {PS_TUPLE_QUERY[ANY]} detachable_query
		 implies query.internal_transaction.repository.can_handle (item)
end
