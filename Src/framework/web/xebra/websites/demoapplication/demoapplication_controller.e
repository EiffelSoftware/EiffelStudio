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
			create reservations.make
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "23/11/2009", 3))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "24/11/2009", 3))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "25/11/2009", 3))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "26/11/2009", 5))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "23/11/2009", 5))
			reservations.extend (create {MY_RESERVATION}.make ("Sanddro Dezahnet", "34/66/2009", 1))
			reservations.extend (create {MY_RESERVATION}.make ("Sanddro Dezahnet", "23/23/2009", 1))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "23111/2009", 2))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "11/11/2009", 2))
			reservations.extend (create {MY_RESERVATION}.make ("Fabio Zuend", "23/55/2009", 2))
		end


feature -- Access

	reservations: LINKED_LIST [MY_RESERVATION]

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
				if attached session.get ("fabio") as item then

					Result := True
				end
			end
		end

	not_authenticated: BOOLEAN
			--
		do
			Result := not authenticated
		end

	logout
			-- logs out]
		do
			if attached current_session as session  then
					session.remove ("fabio")
				end
		end

	login
			-- sets the authenticated flat to true
		do


			if attached current_request.arguments["name"] as name and then attached current_request.arguments["password"] as password then
				if name.is_equal ("fabio") and password.is_equal ("123") then
					if attached current_session as session  then
						session.put ("fabio", "isloggedin")
							end
				end
			end
		end

	username: STRING
			--
		do
			if authenticated then
				Result := "Fabio"
			else
				Result := ""
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
