note
	description: "Summary description for {SHARED_RESTBUCKS_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESTBUCKS_API

feature -- Access: bridget to api

	has_order (a_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := api.has_order (a_id)
		end

	order (a_id: READABLE_STRING_GENERAL): detachable ORDER
		do
			Result := api.order (a_id)
		end

feature -- Element change

	submit_order (a_order: ORDER)
			-- Submit new order `a_order`.
		require
			no_id: not a_order.has_id
		do
			api.submit_order (a_order)
		ensure
			a_order.has_id
			a_order.is_submitted
		end

	update_order (a_order: ORDER)
			-- Update the order to the repository
		require
			a_order.has_id
		do
			api.save_order (a_order)
		ensure
			a_order_with_id: a_order.has_id
		end

	delete_order (a_order: ORDER)
		require
			a_order_with_id: a_order.has_id
		do
			api.delete_order (a_order)
		end

feature -- Access		

	api: RESTBUCKS_API
		once
			create Result.make
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
