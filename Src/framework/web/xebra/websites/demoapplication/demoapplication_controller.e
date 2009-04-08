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

create
	make

feature {NONE} -- Initialization	

	make
			--
		do
			base_make

			--fake reservations
			create reservations.make (10)
			reservations.extend (create {RESERVATION}.make ("1", "Fabio Zuend", "23/11/2009", "3", "blablablablablabla description"))
			reservations.extend (create {RESERVATION}.make ("2", "Fabio Zuend", "21/11/2009", "2", "blablablablablabla description"))
			reservations.extend (create {RESERVATION}.make ("3", "Fabio Zuend", "24/11/2009", "33", "blablablablablabla description"))
			reservations.extend (create {RESERVATION}.make ("4", "Fabio Zuend", "25/11/2009", "5", "blablablablablabla description"))
			reservations.extend (create {RESERVATION}.make ("5", "Fabio Zuend", "26/11/2009", "1", "blablablablablabla description"))


			--fake users
			create users.make(3)
			users.put (create {USER}.make ("admin", "123", True), "admin")
			users.put (create {USER}.make ("fabio", "123", False), "fabio")
		end


feature -- Access

	reservations: ARRAYED_LIST [RESERVATION]

	users: HASH_TABLE [USER, STRING]

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
			-- Tests if session contains authenticated flag.
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
			--
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				Result := id
			end
		end

	get_res_name_from_args: STRING
			--
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				from
					reservations.start
				until
					reservations.after
				loop
					if reservations.item_for_iteration.id.out.is_equal (id) then
						Result := reservations.item_for_iteration.name
					end
					reservations.forth
				end
			end
		end

	get_res_date_from_args: STRING
			--
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				from
					reservations.start
				until
					reservations.after
				loop
					if reservations.item_for_iteration.id.out.is_equal (id) then
						Result := reservations.item_for_iteration.date
					end
					reservations.forth
				end
			end
		end

	get_res_persons_from_args: STRING
			--
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				from
					reservations.start
				until
					reservations.after
				loop
					if reservations.item_for_iteration.id.out.is_equal (id) then
						Result := reservations.item_for_iteration.persons
					end
					reservations.forth
				end
			end
		end

	get_res_description_from_args: STRING
			--
		do
			Result := ""
			if attached {STRING} current_request.arguments["id"] as id then
				from
					reservations.start
				until
					reservations.after
				loop
					if reservations.item_for_iteration.id.out.is_equal (id) then
						Result := reservations.item_for_iteration.descripion
					end
					reservations.forth
				end
			end
		end


	not_authenticated: BOOLEAN
			--
		do
			Result := not authenticated
		end

	not_authenticated_admin: BOOLEAN
		do
			Result := not authenticated_admin
		end

	del_url: STRING
			--
		do
			Result := "reservations.xeb?del=" + reservations.item_for_iteration.id.out
		end

	delete
			--
		local
			done: BOOLEAN
		do
			if authenticated_admin then
				if attached {STRING} current_request.arguments["id"] as id and then
					attached {STRING} current_request.arguments["delete"] then

					from
						reservations.start
						done := false
					until
						reservations.after or done
					loop
						if reservations.item_for_iteration.id.out.is_equal (id) then
							reservations.remove
							done := True
						else
							reservations.forth
						end
					end
				end
			end
		end

	edit
			--
		local
			done: BOOLEAN
		do
			if authenticated_admin then
				if attached {STRING} current_request.arguments["id"] as id and
				   attached {STRING} current_request.arguments["name"] as name and
				   attached {STRING} current_request.arguments["date"] as date and
				   attached {STRING} current_request.arguments["persons"] as persons and
				   attached {STRING} current_request.arguments["description"] as description then

--					from
--						reservations.start
--						done := false
--					until
--						reservations.after or done
--					loop
--						if reservations.item_for_iteration.id.out.is_equal (id) then
--							reservations.remove
--							done := true
--						else
--							reservations.forth
--						end
--					end

					reservations.extend (create {RESERVATION}.make (id, name, date, persons, description))


				end
			end
		end

	detail_url: STRING
			--
		do
			Result := "details.xeb?id=" + reservations.item_for_iteration.id.out
		end


	logout
			-- logs out]
		do
			if attached current_session as session  then
					session.remove ("auth")
				end
		end

	login
			-- sets the authenticated flat to true
		do
			if attached current_request.arguments["name"] as name and then attached current_request.arguments["password"] as password then
				if attached users[name] as user and then
					(user.name.is_equal (name) and
					user.password.is_equal (password)) then
					if attached current_session as session  then
						session.force (user, "auth")
					end
				end
			end
		end

	username: STRING
			--
		do
			Result := ""

			if attached current_session as session then
				if attached {USER} session.get ("auth") as user then
					Result := user.name
				end
			end
		end

feature -- Access

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
