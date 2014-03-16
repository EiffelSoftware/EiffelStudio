note
	description: "Summary description for {ESA_ERROR_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ERROR_HANDLER


create
	make

feature -- Initialization

	make (a_error_message: READABLE_STRING_32; a_error_location: READABLE_STRING_32)
		do
			set_error_message (a_error_message)
			set_error_location (a_error_location)
		end

feature -- Access

	error_message: READABLE_STRING_32
			-- Message
	error_location: READABLE_STRING_32
			-- Code to represent an error

feature -- Change Element


	set_error_message (a_message: like error_message)
			-- Set error_message with `a_message'
		do
			error_message := a_message
		ensure
			message_set: error_message = a_message
		end

	set_error_location (a_location: READABLE_STRING_32)
			-- Set error_location with `a_location'
		do
			error_location := a_location
		ensure
			error_location_set: error_location = a_location
		end


end
