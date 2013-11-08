note
	description: "An example error visitor."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	MY_PRIVATE_VISITOR

inherit
	PS_DEFAULT_ERROR_VISITOR
		redefine
			visit_transaction_aborted_error,
			visit_connection_setup_error
		end

feature -- Status report

	shall_retry: BOOLEAN
		-- Should my client retry the operation?

feature -- Visitor features

	visit_transaction_aborted_error (transaction_aborted_error: PS_TRANSACTION_ABORTED_ERROR)
		-- Visit a transaction aborted error
		do
			shall_retry := True
		end

	visit_connection_setup_error (connection_setup_error: PS_CONNECTION_SETUP_ERROR)
		-- Visit a connection setup error
		do
			notify_user_of_abort
			shall_retry:=False
		end

feature {NONE} -- Pseudocode

	notify_user_of_abort
			-- Notify the user that the operation has been aborted
		do
		end

end
