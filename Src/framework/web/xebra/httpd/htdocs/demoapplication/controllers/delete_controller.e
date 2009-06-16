note
	description: "Summary description for {DELETE_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELETE_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	make

feature -- Status Change

	delete: STRING
			-- Deletes an entry
		local
			done: BOOLEAN
		do
			Result := "ERROR: ID not found"

			if attached {STRING} current_request.arguments["id"] as id then
				global_state.db.delete_reservation (id.to_integer_32)
				Result := "Reservation successfully deleted."
			else
				Result := "ERROR: ID is missing"
			end
		ensure
			Result_attached: Result /= Void
		end
end
