note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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

	get_user_by_id (a_id: INTEGER): USER
			-- Retrieves a user with an id
		deferred
		end

	get_all_users: LIST [USER]
			-- Retrieves all users
		deferred
		end

	get_reservation_by_id (a_id: INTEGER): RESERVATION
			-- Retrieves a user with an id
		deferred
		end

	get_all_reservations: LIST [RESERVATION]
			-- Retrieves all users
		deferred
		end

	delete_reservation (a_id: INTEGER)
			-- Deletes a reservation
		deferred
		end

end
