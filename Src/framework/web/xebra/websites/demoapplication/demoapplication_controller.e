note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_CONTROLLER

inherit
	XWA_CONTROLLER
		redefine
			make
		end
	G_SHARED_DEMOAPPLICATION_GLOBAL_STATE

create
	make

feature {NONE} -- Initialization	

	make
			--
		do
			Precursor
			--fake reservations
--			create reservations.make (10)
--			reservations.extend (create {RESERVATION}.make ("1", "Fabio Zuend", "23/11/2009", "3", "blablablablablabla description"))
--			reservations.extend (create {RESERVATION}.make ("2", "Fabio Zuend", "21/11/2009", "2", "blablablablablabla description"))
--			reservations.extend (create {RESERVATION}.make ("3", "Fabio Zuend", "24/11/2009", "33", "blablablablablabla description"))
--			reservations.extend (create {RESERVATION}.make ("4", "Fabio Zuend", "25/11/2009", "5", "blablablablablabla description"))
--			reservations.extend (create {RESERVATION}.make ("5", "Fabio Zuend", "26/11/2009", "1", "blablablablablabla description"))


--			--fake users
--			create users.make(3)
--			users.put (create {USER}.make ("admin", "123", True), "admin")
--			users.put (create {USER}.make ("fabio", "123", False), "fabio")
		end


feature -- Access

feature -- Basic Operations

	on_page_load
			--
		do

		end

	authenticated: BOOLEAN
			-- Tests if session contains authenticated flag.
		do
			Result := False

			if attached current_session as session then
				if attached session.get ("auth") as item then
					Result := True
				end
			end
		end

	authenticated_admin: BOOLEAN
			-- Tests if session contains authenticated flag and user is admin
		do
			Result := False

			if attached current_session as session then
				if attached {USER} session.get ("auth") as session_user then
					if session_user.is_admin then
						Result := True
					end
				end
			end
		end

	get_res_id_from_args: STRING
			-- Retrieve reservartion ID from request arguments
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.id.out
				end
			end
		end

	get_res_name_from_args: STRING
			-- Retrieve reservartion name from request arguments
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.name
				end
			end
		end

	get_res_date_from_args: STRING
			-- Retrieve reservartion date from request arguments
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.date
				end
			end
		end

	get_res_persons_from_args: STRING
			-- Retrieve reservartion persons from request arguments
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.persons.out
				end
			end
		end

	get_res_description_from_args: STRING
			-- Retrieve reservartion description from request arguments
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.description
				end
			end
		end


	not_authenticated: BOOLEAN
			-- Helper
		do
			Result := not authenticated
		end

	not_authenticated_admin: BOOLEAN
			-- Helper
		do
			Result := not authenticated_admin
		end


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
		end


--	detail_url: STRING
--			-- Generates a url for viewing details of a reservation
--		do
--			Result := "details.xeb?id=" + reservations.item_for_iteration.id.out
--		end

	logout
			-- Removes the user from the session
		do
			if attached current_session as session  then
					session.remove ("auth")
				end
		end

	login: STRING
			-- Adds the user to the session
		do
			Result := "Invalid username/password"

			if attached current_request.arguments["name"] as name and then attached current_request.arguments["password"] as password then
				if attached {USER} global_state.db.valid_login (name, password) as user then
					if attached current_session as session  then
						session.put (user, "auth")
						Result := "Successfully logged in."
					end
				end
			end
		end

	username: STRING
			-- Gets username of logged in user
		do
			Result := ""

			if attached current_session as session then
				if attached {USER} session.get ("auth") as user then
					Result := user.name
				end
			end
		end

end
