indexing
	description: "Visitor for responses"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_RESPONSE_VISITOR

feature -- Process

	process_normal_response (a_response: AUT_NORMAL_RESPONSE) is
			-- Process `a_response'.
		require
			a_response_attached: a_response /= Void
		deferred
		end

	process_error_response (a_response: AUT_ERROR_RESPONSE) is
			-- Process `a_response'.
		require
			a_response_attached: a_response /= Void
		deferred
		end

	process_bad_response (a_response: AUT_BAD_RESPONSE) is
			-- Process `a_response'.
		require
			a_response_attached: a_response /= Void
		deferred
		end

end
