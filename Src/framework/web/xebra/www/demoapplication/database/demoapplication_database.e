note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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

	insert_reservation (a_name: STRING; a_date: STRING; a_persons: INTEGER; a_description: STRING): BOOLEAN
			-- Inserts a new reseravation

		require
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
			not_a_date_is_detached_or_empty: a_date /= Void and then not a_date.is_empty
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

end
