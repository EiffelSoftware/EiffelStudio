note
	description: "Summary description for {RESTBUCKS_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	RESTBUCKS_API

create
	make

feature {NONE} -- Initialization

	make
		local
			db: BASIC_SED_FS_DATABASE
		do
			create db.make (database_path)
			database := db
		end

feature -- Access

	orders_count: INTEGER
			-- Number of existing orders.
		do
			Result := database.count_of ({ORDER})
		end

	has_order (a_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := database.has ({ORDER}, a_id)
		end

	order (a_id: READABLE_STRING_GENERAL): detachable ORDER
		do
			if attached {ORDER} database.item ({ORDER}, a_id) as o then
				Result := o
			end
		end

feature -- Element change

	submit_order (a_order: ORDER)
			-- Submit new order `a_order`.
		require
			no_id: not a_order.has_id
		do
			a_order.mark_submitted
			save_order (a_order)
		end

	save_order (a_order: ORDER)
		local
			cl: CELL [detachable READABLE_STRING_GENERAL]
		do
			a_order.add_revision
			if a_order.has_id then
				create cl.put (a_order.id)
			else
				create cl.put (Void)
			end
			database.save ({ORDER}, a_order, cl)
			if attached cl.item as l_new_id then
				if l_new_id.is_valid_as_string_8 then
					a_order.set_id (l_new_id.to_string_8)
				else
					check valid_id: False end
				end
			end
		ensure
			has_id: a_order.has_id
			incremented_revision: a_order.revision > old (a_order.revision)
		end

	delete_order (a_order: ORDER)
		do
			database.delete ({ORDER}, a_order.id)
		end

feature -- Access: order status

	is_valid_status_state (a_status: STRING): BOOLEAN
			-- Is `a_status' a valid order state
		do
			Result := Order_states.has (a_status.as_lower)
		end

	Order_states : ARRAY [STRING]
			-- List of valid status states
		once
			Result := <<
							status_unset,
							status_submitted,
							status_pay, 	status_payed,
							status_cancel, 	status_canceled,
							status_prepare,	status_prepared,
							status_deliver,
							status_completed
						>>
			Result.compare_objects
		end

	is_valid_transition (a_order: ORDER; a_new_status: STRING): BOOLEAN
			-- Is transition from `a_order.status` to `a_new_status` valid for `a_order`?
		local
			l_order_status: READABLE_STRING_GENERAL
			l_new_status: STRING
		do
			l_order_status := a_order.status
			l_new_status := a_new_status.as_lower
			if l_order_status.same_string (l_new_status) then
					-- Same status is valid, if it is a valid status
				Result := is_valid_status_state (l_new_status)
			else
				if l_order_status.same_string (status_submitted) then
					Result := 	l_new_status.same_string (status_pay)
							or 	l_new_status.same_string (status_cancel)
				elseif l_order_status.same_string (status_pay) then
					Result := 	l_new_status.same_string (status_payed)
				elseif l_order_status.same_string (status_cancel) then
					Result := 	l_new_status.same_string (status_canceled)
				elseif l_order_status.same_string (status_payed) then
					Result := l_new_status.same_string (status_prepared)
				elseif l_order_status.same_string (status_prepared) then
					Result := l_new_status.same_string (status_deliver)
				elseif l_order_status.same_string (status_deliver) then
					Result := l_new_status.same_string (status_completed)
				end
			end
		end

	is_state_valid_to_update (a_status : STRING) : BOOLEAN
			-- Is it possible to update order with status `a_status`?
		do
			if
				a_status.same_string (status_submitted)
				or else  a_status.same_string (status_pay)
				or else  a_status.same_string (status_payed)
			then
				Result := True
			end
		end

feature -- Constants: order status

	status_unset: STRING = "unset"
	status_submitted: STRING = "submitted"
	status_pay: STRING = "pay"
	status_payed: STRING = "payed"
	status_cancel: STRING = "cancel"
	status_canceled: STRING = "canceled"
	status_prepare: STRING = "prepare"
	status_prepared: STRING = "prepared"
	status_deliver: STRING = "deliver"
	status_completed: STRING = "completed"

feature {NONE} -- Access

	database: BASIC_DATABASE

feature {NONE} -- Implementation

	database_path: PATH
		once
			create Result.make_from_string ("db")
		end

;note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
