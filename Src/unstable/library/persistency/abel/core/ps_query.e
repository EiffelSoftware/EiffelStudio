note
	description: "Represents a query for objects of type OBJECT_TYPE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_QUERY [OBJECT_TYPE -> ANY]

inherit
	PS_ABSTRACT_QUERY [OBJECT_TYPE, OBJECT_TYPE]

create
	make, make_with_criterion

feature -- Status report

	is_tuple_query: BOOLEAN = False
			-- Is `Current' an instance of PS_TUPLE_QUERY?

feature {PS_ABEL_EXPORT} -- Implementation: Element change

	retrieve_next
			-- Retrieve the next item from the database and store it in `result_cache'.
		do
			check attached internal_cursor as cursor then
				cursor.forth
				if cursor.after then
					is_after := True
				else
					result_cache.extend (cursor.item)
--					set_result_item (cursor.item)
				end
			end
--			check attached read_manager as rm then
--				rm.next_entry (Current)
--			end
		ensure then
			not_after_means_known: not is_after implies result_cache.last.generating_type.is_expanded or repository.is_identified (result_cache.last, internal_transaction)
			can_handle_retrieved_object: not is_after implies repository.can_handle (result_cache.last)
		rescue
			repository.rollback_transaction (internal_transaction, False)
			close
		end

end
