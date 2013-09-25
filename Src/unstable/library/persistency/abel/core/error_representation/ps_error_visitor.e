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

	visit_authorization_error (auth_error: PS_AUTHORIZATION_ERROR)
			-- Visit an authorization error
		deferred
		end

	visit_transaction_error (transaction_error: PS_TRANSACTION_ABORTED_ERROR)
			-- Visit a transaction error
		deferred
		end

	visit_general_error (general_error: PS_ERROR)
			-- Visit a general error
		deferred
		end

	visit_access_right_violation (access_right_violation: PS_ACCESS_RIGHT_VIOLATION_ERROR)
			-- Visit an access right violation error
		deferred
		end

	visit_integrity_constraint_violation (integrity_constraint_violation: PS_INTEGRITY_CONSTRAINT_VIOLATION_ERROR)
			-- Visit an integrity constraint violation error
		deferred
		end

	visit_message_not_understood (message_not_understood: PS_MESSAGE_NOT_UNDERSTOOD_ERROR)
			-- Visit a message not understood error
		deferred
		end

	visit_invalid_operation_error (invalid_operation: PS_INVALID_OPERATION_ERROR)
			-- Visit an invalid operation error
		deferred
		end

	visit_connection_problem (connection_error: PS_CONNECTION_SETUP_ERROR)
			-- Visit a connection problem error
		deferred
		end

	visit_backend_runtime_error (backend_runtime_error: PS_BACKEND_RUNTIME_ERROR)
			-- Visit a backend runtime error
		deferred
		end

	visit_internal_error (internal_error: PS_INTERNAL_ERROR)
			-- Visit an internal error
		deferred
		end

	visit_version_mismatch (version_error: PS_VERSION_MISMATCH_ERROR)
			-- Visit a version mismatch error
		deferred
		end

end
