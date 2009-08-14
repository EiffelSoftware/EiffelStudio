note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"
class
	INSERT_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	default_create

feature -- Status Change

--	insert: STRING
--			-- Inserts a new reservation into the db
--		do
--				Result := "Default Error"

--				if attached {STRING} current_request.argument_table ["name"] as name and
--				   attached {STRING} current_request.argument_table ["date"] as date and
--				   attached {STRING} current_request.argument_table ["persons"] as persons and
--				   attached {STRING} current_request.argument_table ["description"] as description then

--					if global_state.db.insert_reservation (name, date, persons.to_integer_32, description) then
--						Result := "New reservation successfully inserted."
--					else
--						Result := "Error inserting reservation"
--					end
--				else
--					Result := "Error, not enough arguments"
--				end
--		ensure
--			Result_attached: Result /= Void
--		end

	save (a_reservation: RESERVATION): STRING
		do
			print (a_reservation.description + " " + a_reservation.name)
			Result := "login.xeb"
		end

	print_something (a_arg: STRING): STRING
		do
			print ("IT WORKS " + a_arg)
			Result := "bluh.html"
		end
end
