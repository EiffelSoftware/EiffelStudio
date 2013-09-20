note
	description: "An example error visitor."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	MY_PRIVATE_VISITOR
inherit
	PS_ERROR_VISITOR

feature -- Status report

	shall_retry: BOOLEAN
		-- Should my client retry the operation?

feature -- Visitor features

	visit_access_right_violation (error: PS_ACCESS_RIGHT_VIOLATION)
		-- Visit an access right violation error
		do
			add_some_privileges
			shall_retry := True
		end

	visit_connection_problem (error: PS_CONNECTION_ERROR)
		-- Visit a connection problem error
		do
			notify_user_of_abort
			shall_retry:=False
		end



feature -- Unimplemented visitor features

	visit_transaction_error (transaction_error: PS_TRANSACTION_CONFLICT)
			-- Visit a transaction error
		do
		end

	visit_general_error (general_error: PS_GENERAL_ERROR)
			-- Visit a general error
		do
		end

	visit_unresolvable_transaction_conflict (unres_error: PS_UNRESOLVABLE_TRANSACTION_CONFLICT)
			-- Visit an unresolvable transaction conflict error
		do
		end

	visit_internal_error (internal_error: PS_INTERNAL_ERROR)
			-- Visit an internal error
		do
			print ("Visiting internal error")
		end

	visit_version_mismatch (version_error: PS_VERSION_MISMATCH)
			-- Visit a version mismatch error
		do
		end

feature {NONE} -- Pseudocode

	notify_user_of_abort
			-- Notify the user that the operation has been aborted
		do
		end

	add_some_privileges
			-- Add some privileges for me to the database
		do
		end

end
