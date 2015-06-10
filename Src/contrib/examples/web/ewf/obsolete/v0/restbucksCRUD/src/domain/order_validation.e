note
	description: "Summary description for {ORDER_TRANSITIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER_VALIDATION
feature -- Access

	is_valid_status_state (a_status: STRING) : BOOLEAN
		--is `a_status' a valid coffee order state
		do
			a_status.to_lower
			Order_states.compare_objects
			Result := Order_states.has (a_status)
		end

	Order_states : ARRAY[STRING]
		-- List of valid status states
		once
			Result := <<"submitted","pay","payed", "cancel","canceled","prepare","prepared","deliver","completed">>
		end


	is_valid_transition (order:ORDER a_status : STRING) :BOOLEAN
		-- Given the current order state, determine if the transition is valid
		do
			a_status.to_lower
			if order.status.same_string ("submitted") then
				Result := a_status.same_string ("pay") or  a_status.same_string ("cancel") or order.status.same_string (a_status)
			elseif order.status.same_string ("pay") then
				Result := a_status.same_string ("payed") or order.status.same_string (a_status)
			elseif order.status.same_string ("cancel") then
				Result := a_status.same_string ("canceled") or order.status.same_string (a_status)
			elseif order.status.same_string ("payed") then
				Result := a_status.same_string ("prepared") or order.status.same_string (a_status)
			elseif order.status.same_string ("prepared") then
				Result := a_status.same_string ("deliver") or order.status.same_string (a_status)
			elseif order.status.same_string ("deliver") then
				Result := a_status.same_string ("completed") or order.status.same_string (a_status)
			end
		end

	is_state_valid_to_update ( a_status : STRING) : BOOLEAN
			-- Given the current state `a_status' of an order, is possible to update the order?
		do
			if a_status.same_string ("submitted") or else  a_status.same_string ("pay") or else  a_status.same_string ("payed")    then
				Result := true
			end
		end

note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
