note
	description: "Object handling error information"
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_ERROR_HANDLER

create
	make

feature -- Initialization

	make (a_error_message: READABLE_STRING_32; a_error_location: READABLE_STRING_32)
			-- Create an object error, set `error_message' to `a_error_message'
			-- set `error_location' to `a_error_location'.
		do
			set_error_message (a_error_message)
			set_error_location (a_error_location)
		ensure
			error_message_set:  error_message = a_error_message
			error_location_set: error_location = a_error_location
		end

feature -- Access

	error_message: READABLE_STRING_32
			-- Message.

	error_location: READABLE_STRING_32
			-- Code to represent an error.

feature -- Change Element

	set_error_message (a_message: like error_message)
			-- Set error_message with `a_message'.
		do
			error_message := a_message
		ensure
			message_set: error_message = a_message
		end

	set_error_location (a_location: READABLE_STRING_32)
			-- Set error_location with `a_location'.
		do
			error_location := a_location
		ensure
			error_location_set: error_location = a_location
		end

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
