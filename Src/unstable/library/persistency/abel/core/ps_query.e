note
	description: "A query for objects of type OBJECT_TYPE."
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
		local
			retried: BOOLEAN
		do
			if not retried and not has_error then
				check from_precondition: attached internal_cursor as cursor then
					cursor.forth
					if cursor.after then
						is_after := True
					else
						result_cache.extend (cursor.item)
					end
				end
			end
		ensure then
			not_after_means_known: not is_after implies result_cache.last.generating_type.is_expanded or repository.is_identified (result_cache.last, internal_transaction) or internal_transaction.is_readonly
			can_handle_retrieved_object: not is_after implies repository.can_handle (result_cache.last)
		rescue
			retried := True
			do_rescue
			if internal_transaction.is_retry_allowed then
				retry
			end
		end

end
