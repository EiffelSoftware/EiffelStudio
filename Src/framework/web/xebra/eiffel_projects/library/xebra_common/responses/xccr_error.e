note
	description: "[
		The framework class for a server error command response.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XCCR_ERROR

inherit
	XC_COMMAND_RESPONSE

feature -- Access

	description: STRING
			-- Describes the error
		deferred
		ensure
			result_attached: Result /= Void
		end

end

