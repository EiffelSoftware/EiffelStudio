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

feature {PS_ERROR} -- Visitor functions: Top-level categories

--	visit_no_error (no_error: PS_NO_ERROR)
--			-- When no error occured, doing nothing is a reasonable default.
--		do
--		end

	visit_uncategorized_error (error: PS_ERROR)
			-- Visit an uncategorized error
		deferred
		end

	visit_operation_error (operation_error: PS_OPERATION_ERROR)
			-- Visit an invalid operation error
		deferred
		end

	visit_connection_setup_error (connection_setup_error: PS_CONNECTION_SETUP_ERROR)
			-- Visit a connection setup error
		deferred
		end

	visit_backend_error (backend_error: PS_BACKEND_ERROR)
			-- Visit a backend runtime error
		deferred
		end

	visit_internal_error (internal_error: PS_INTERNAL_ERROR)
			-- Visit an internal error
		deferred
		end

feature {PS_ERROR} -- Visitor functions: Connection Setup Error subcategories

	visit_authorization_error (authorization_error: PS_AUTHORIZATION_ERROR)
			-- Visit an authorization error
		deferred
		end

feature {PS_ERROR} -- Visitor functions: Operation Error subcategories

	visit_external_routine_error (external_routine_error: PS_EXTERNAL_ROUTINE_ERROR)
			-- Visit an external routine failure
		deferred
		end

	visit_message_not_understood_error (message_not_understood_error: PS_MESSAGE_NOT_UNDERSTOOD_ERROR)
			-- Visit a message not understood error
		deferred
		end

	visit_integrity_constraint_violation_error (integrity_constraint_violation_error: PS_INTEGRITY_CONSTRAINT_VIOLATION_ERROR)
			-- Visit an integrity constraint violation error
		deferred
		end

	visit_transaction_aborted_error (transaction_aborted_error: PS_TRANSACTION_ABORTED_ERROR)
			-- Visit a transaction aborted error
		deferred
		end

	visit_version_mismatch_error (version_mismatch_error: PS_VERSION_MISMATCH_ERROR)
			-- Visit a version mismatch error
		deferred
		end

end
