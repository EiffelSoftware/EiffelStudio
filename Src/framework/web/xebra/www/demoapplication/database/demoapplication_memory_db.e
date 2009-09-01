note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
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
		local
			l_default_time: DATE
		do
			create reservations.make
			create users.make (2)

			users.force ( create {USER}.make (1, "fabio", "123", False), "fabio")
			users.force ( create {USER}.make (1, "admin", "123", True), "admin")

			create l_default_time.make_now
			reservations.force (create {RESERVATION}.make_with_arguments (1, "Fabio Zuend", l_default_time, 4, "Big event!"))
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

	insert_reservation (a_name: STRING; a_date: DATE; a_persons: INTEGER; a_description: STRING): BOOLEAN
			-- Inserts a new reseravation
		do
			reservations.force (create {RESERVATION}.make_with_arguments (reservations.count+1, a_name, a_date, a_persons, a_description))
			Result := True
		end

invariant
	reservations_attached: reservations /= Void
	users_attached: users /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
