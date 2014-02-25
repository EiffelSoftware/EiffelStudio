note
	description: "Summary description for {ESA_ERROR_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ERROR_HANDLER

feature -- Initialization


feature -- Access

	error_message: detachable READABLE_STRING_32
			-- Message
	error_code: INTEGER
			-- Code to represent an error

feature -- Change Element

	reset
			-- Reset error to default values
		do
			error_code := 0
			has_error := False
			error_message := Void
		end
		
	set_error_message (a_message: like error_message)
			-- Set error_message with `a_message'
		do
			error_message := a_message
		ensure
			message_set: error_message = a_message
		end

	set_error_code (a_code: INTEGER)
			-- Set error_code with `error_code'
		do
			error_code := a_code
		ensure
			error_code_set: error_code = a_code
		end

	set_has_error
		do
			has_error := True
		ensure
			has_error_set: has_error
		end

feature -- Status Error

	has_error: BOOLEAN



end
