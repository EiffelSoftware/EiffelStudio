note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEMOAPPLICATION_DATABASE


feature -- Access

	is_connected: BOOLEAN
			-- Check if already connected to the database.

feature -- Status Change

	open: BOOLEAN
			-- Opens the connection
		deferred
		end

	close
			-- Closes the connection
		deferred
		end

feature -- Basic Operations

	reservation_by_id (a_id: INTEGER): detachable RESERVATION
			-- Retrieves a reservation with an id
		deferred
		end

	reservations: LINKED_LIST [RESERVATION]
			-- Retrieves all reservations
		deferred
		ensure
			Result_attached: Result /= Void
		end

	insert_reservation (a_name: STRING; a_date: DATE; a_persons: INTEGER; a_description: STRING): BOOLEAN
			-- Inserts a new reseravation

		require
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
			not_a_date_is_detached_or_empty: a_date /= Void
			not_a_description_is_detached_or_empty: a_description /= Void and then not a_description.is_empty
		deferred
		end

	delete_reservation (a_id: INTEGER)
			-- Deletes a reservation
		deferred
		end

	valid_login (a_name: STRING; a_password: STRING): detachable USER
			-- Tries to log in a user.	
		require
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
			not_a_password_detached_or_empty: a_password /= Void and then not a_password.is_empty
		deferred
		end

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
