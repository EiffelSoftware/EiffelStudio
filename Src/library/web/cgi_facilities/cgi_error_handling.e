indexing
	description: "Error Handling"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_ERROR_HANDLING
	
inherit
	CGI_IN_AND_OUT

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Basic Operations

	handle_exception is
			-- General exception hanlding.
		local
			msg: STRING
		do
			if raised_error /= Void then
				msg := raised_error
			else
				msg := ""
			end
			response_header.send_trace (msg + exception_trace)
		end

	raise_error(msg: STRING) is
			-- Raise an error.
		require
			message_exists: msg /= Void
		do
			raised_error := msg
			handle_exception
		ensure
			exists: raised_error /= Void
		end

feature {CGI_ERROR_HANDLING} -- Access

	raised_error: STRING;
			-- Error explicitely raised by developer code.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CGI_ERROR_HANDLING

