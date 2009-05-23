note
	description: "[
		{XWA_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_VALIDATOR

feature -- Initialization
feature -- Access

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
