note
	description: "Provides a default action for errors. Clients can inherit and overwrite behaviour for specific error categories."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_ERROR_VISITOR

inherit
	PS_ERROR_VISITOR


feature {PS_ERROR} -- Visitor functions: Top-level categories

	visit_uncategorized_error (error: PS_ERROR)
			-- Visit an uncategorized error
		do
			print (error.tag)
			print ("%N%N")
			if attached error.description as desc then
				print (desc + "%N")
			end
			error.raise
		end

	visit_connection_setup_error (connection_setup_error: PS_CONNECTION_SETUP_ERROR)
			-- Visit a connection setup error
		do
			visit_uncategorized_error (connection_setup_error)
		end

	visit_operation_error (operation_error: PS_OPERATION_ERROR)
			-- Visit an invalid operation error
		do
			visit_uncategorized_error (operation_error)
		end

	visit_backend_error (backend_error: PS_BACKEND_ERROR)
			-- Visit a backend runtime error
		do
			visit_uncategorized_error (backend_error)
		end

	visit_internal_error (internal_error: PS_INTERNAL_ERROR)
			-- Visit an internal error
		do
			visit_uncategorized_error (internal_error)
		end

feature {PS_ERROR} -- Visitor functions: Connection Setup Error subcategories

	visit_authorization_error (authorization_error: PS_AUTHORIZATION_ERROR)
			-- Visit an authorization error
		do
			visit_connection_setup_error (authorization_error)
		end

feature {PS_ERROR} -- Visitor functions: Operation Error subcategories


	visit_external_routine_error (external_routine_error: PS_EXTERNAL_ROUTINE_ERROR)
			-- Visit an external routine failure
		do
			visit_operation_error (external_routine_error)
		end

	visit_message_not_understood_error (message_not_understood_error: PS_MESSAGE_NOT_UNDERSTOOD_ERROR)
			-- Visit a message not understood error
		do
			visit_operation_error (message_not_understood_error)
		end

	visit_integrity_constraint_violation_error (integrity_constraint_violation_error: PS_INTEGRITY_CONSTRAINT_VIOLATION_ERROR)
			-- Visit an integrity constraint violation error
		do
			visit_operation_error (integrity_constraint_violation_error)
		end

	visit_transaction_aborted_error (transaction_aborted_error: PS_TRANSACTION_ABORTED_ERROR)
			-- Visit a transaction aborted error
		do
			visit_operation_error (transaction_aborted_error)
		end

	visit_version_mismatch_error (version_mismatch_error: PS_VERSION_MISMATCH_ERROR)
			-- Visit a version mismatch error
		do
			visit_operation_error (version_mismatch_error)
		end

end
