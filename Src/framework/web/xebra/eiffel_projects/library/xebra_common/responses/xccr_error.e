note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XCCR_ERROR

inherit
	XC_COMMAND_RESPONSE


feature {NONE} -- Initialization

feature -- Access

	description: STRING
			-- Describes the error
		deferred
		ensure
			result_attached: Result /= Void
		end



feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

