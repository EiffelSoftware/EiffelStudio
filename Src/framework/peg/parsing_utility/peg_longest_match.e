note
	description: "[
		Holds the pointer of the longest match of a parse process.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_LONGEST_MATCH

create
	make

feature -- Initialization

	make
		do
			count := 1
			create {ARRAYED_LIST [STRING]} error_messages.make (0)
		end

feature -- Access

	error_messages: LIST [STRING] assign set_error_message
			-- The error message of the furthest reaching parse

feature -- Basic functionality

	set_error_message (a_messages: LIST [STRING])
			-- Sets the error messages.
		require
			a_messages_attached: attached a_messages
		do
			error_messages := a_messages
		ensure
			error_message_set: error_messages=a_messages
		end

	update_length (a_length: INTEGER)
			-- Updates the count if `a_length' is bigger than a_length
		require
			a_length_bigger_than_zero: a_length > 0
		do
			if a_length > count then
				count := a_length
				error_messages.wipe_out
			end
		end

	count: INTEGER
			-- Furthest count

	reset
			-- Resets the counter to 1
		do
			count := 1
			error_messages.wipe_out
		ensure
			count_reset: count = 1
			error_messages_wiped_out: error_messages.count = 0
		end

invariant

	count_bigger_than_zero: count > 0

end
