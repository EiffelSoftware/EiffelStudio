note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_MEMORY_DB

inherit
	DEMOAPPLICATION_DATABASE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.	
		do
			create reservations.make
			create users.make (2)

			users.force ( create {USER}.make (1, "fabio", "123", False), "fabio")
			users.force ( create {USER}.make (1, "admin", "123", True), "admin")

			reservations.force (create {RESERVATION}.make_with_arguments (1, "Fabio Zuend", "2009-02-06", 4, "Big event!"))
		ensure
			reservations_attached: reservations /= Void
			users_attached: users /= Void
		end

feature -- Access

	reservations: LINKED_LIST [RESERVATION]

	users: HASH_TABLE [USER, STRING]

feature -- Status Change

	open: BOOLEAN
			-- Opens the connection
		do
			Result := True
		end

	close
			-- Closes the connection
		do
		end

feature -- Basic Operations

	reservation_by_id (a_id: INTEGER): detachable RESERVATION
			-- Retrieves a reservation with an id
		do
			from
				reservations.start
			until
				reservations.after
			loop
				if reservations.item_for_iteration.id.is_equal (a_id) then
					Result := reservations.item_for_iteration
				end
				reservations.forth
			end
		end

	delete_reservation (a_id: INTEGER)
			-- Deletes a reservation
		do
			from
				reservations.start
			until
				reservations.after
			loop
				if reservations.item_for_iteration.id.is_equal (a_id) then
					reservations.remove
				end
				reservations.forth
			end
		end

	valid_login (a_name: STRING; a_password: STRING): detachable USER
			-- Tries to log in a user.	
		do
			if attached {USER} users[a_name] as user then
				if user.password.is_equal (a_password) then
					Result := user
				end
			end
		end

	insert_reservation (a_name: STRING; a_date: STRING; a_persons: INTEGER; a_description: STRING): BOOLEAN
			-- Inserts a new reseravation
		do
			reservations.force (create {RESERVATION}.make_with_arguments (reservations.count+1, a_name, a_date, a_persons, a_description))
			Result := True
		end

invariant
	reservations_attached: reservations /= Void
	users_attached: users /= Void
end
