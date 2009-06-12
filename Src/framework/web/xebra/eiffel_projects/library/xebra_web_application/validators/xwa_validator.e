note
	description: "[
		Generic class for the validation of input. Its descendants have to implement
		the validation of the input and an error message.
		The descendant has to implement a constructor with the signature 'make'
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_VALIDATOR

feature -- Basic Functionality

	validate (a_argument: STRING): BOOLEAN
			-- Validates if `a_argument' is valid
		require
			a_argument_attached: attached a_argument
		deferred
		end

	message: STRING
			-- What error message should be displayed?
		deferred
		ensure
			result_attached: attached Result
		end

end
