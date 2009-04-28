note
	description: "Summary description for {INSERT_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSERT_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	make

feature -- Status Change

	insert: STRING
			-- Inserts a new reservation into the db
		do
				Result := "Default Error"

				if attached {STRING} current_request.arguments["name"] as name and
				   attached {STRING} current_request.arguments["date"] as date and
				   attached {STRING} current_request.arguments["persons"] as persons and
				   attached {STRING} current_request.arguments["description"] as description then

					if global_state.db.insert_reservation (name, date, persons.to_integer_32, description) then
						Result := "New reservation successfully inserted."
					else
						Result := "Error inserting reservation"
					end
				else
					Result := "Error, not enough arguments"
				end
		end
end
