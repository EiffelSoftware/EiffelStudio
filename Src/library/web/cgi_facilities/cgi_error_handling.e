indexing
	description: "Error Handling"
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

	raised_error: STRING
			-- Error explicitely raised by developer code.

end -- class CGI_ERROR_HANDLING

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

