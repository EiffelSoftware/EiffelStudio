indexing
	description: "Class which allows to access the files %
				% corresponding to the in/out data flow"
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_IN_AND_OUT

feature -- Access

	output: STDOUT is
			-- Shared standard output.
		once
			Create Result.make
		end

	stdin: STDIN is
			-- Shared standard input
		once
			Create Result.make
		end

	response_header: CGI_RESPONSE_HEADER is
		once
			Create Result
		end

end -- class CGI_IN_AND_OUT

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

