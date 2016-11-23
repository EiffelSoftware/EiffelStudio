note
	description: "[
			Error handling facility, allows to report errors,
			check for errors and register a different error handler,
			where errors should be redirected to.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_HANDLER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize error handling structures.
		do
			create {ARRAYED_LIST [ERROR]} error_messages.make (1)
			create error_listeners
			register_error_callback (agent error_messages.force (?))
		end

feature -- Access

	has_error: BOOLEAN
			-- Error occured?
		do
			Result := not error_messages.is_empty
		end

	error_messages: LIST [ERROR]
			-- Error messages.

feature -- Element change			

	reset_error
			-- Reset errors.
		do
			error_messages.wipe_out
		ensure
			has_no_error: not has_error
		end

	register_error_callback (a_callback: PROCEDURE [TUPLE [ERROR]])
			-- Register `a_callback' as new target to send error messages to.
		do
			error_listeners.force (a_callback)
		end

feature -- Error reporting

	report_error (a_error: ERROR)
			-- Report error `a_error'.
		do
			across
				error_listeners as ic
			loop
				ic.item (a_error)
			end
		end

	report_new_error (a_message: READABLE_STRING_GENERAL)
			-- Report error message `a_message'.
		do
			report_error (create {ERROR}.make (a_message))
		end

	report_error_with_parent (a_message: READABLE_STRING_GENERAL; a_parent: ERROR)
			-- Report error message `a_prefix': `a_message'.
		do
			report_error (create {ERROR}.make_with_parent (a_message, a_parent))
		end

feature {NONE} -- Implementation

	error_listeners: ACTION_SEQUENCE [TUPLE [ERROR]]
			-- All procedures that are notified on error.

;note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
