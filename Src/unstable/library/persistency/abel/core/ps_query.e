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
						check correct_type: attached {OBJECT_TYPE} cursor.item as res then
							result_cache.extend (res)
						end
					end
				end
			end
		ensure then
			can_handle_retrieved_object: not is_after implies repository.can_handle (result_cache.last)
			not_after_means_known:
				not is_after and not internal_transaction.is_readonly
					implies
				repository.is_expanded (result_cache.last.generating_type)
				xor repository.is_identified (result_cache.last, internal_transaction)
		rescue
			retried := True
			do_rescue
			if internal_transaction.is_retry_allowed then
				retry
			end
		end

end
