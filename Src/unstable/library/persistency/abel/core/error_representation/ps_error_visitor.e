note
	description: "Part of the visitor pattern for errors. This class allows the users of the library to implement their own error handling mechanism, making use of polymorphism (instead of some big if-else statements)"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_ERROR_VISITOR

feature

	visit (an_error: PS_ERROR)
			-- Visit `an_error'
		do
			an_error.accept (Current)
		end

	visit_no_error (no_error: PS_NO_ERROR)
			-- When no error occured, doing nothing is a reasonable default.
		do
		end

	visit_transaction_error (transaction_error: PS_TRANSACTION_CONFLICT)
			-- Visit a transaction error
		deferred
		end

	visit_general_error (general_error: PS_GENERAL_ERROR)
			-- Visit a general error
		deferred
		end

	visit_unresolvable_transaction_conflict (unres_error: PS_UNRESOLVABLE_TRANSACTION_CONFLICT)
			-- Visit an unresolvable transaction conflict error
		deferred
		end

	visit_access_right_violation (access_right_violation: PS_ACCESS_RIGHT_VIOLATION)
			-- Visit an access right violation error
		deferred
		end

	visit_connection_problem (connection_error: PS_CONNECTION_ERROR)
			-- Visit a connection problem error
		deferred
		end

	visit_internal_error (internal_error: PS_INTERNAL_ERROR)
			-- Visit an internal error
		deferred
		end

	visit_version_mismatch (version_error: PS_VERSION_MISMATCH)
			-- Visit a version mismatch error
		deferred
		end

end
