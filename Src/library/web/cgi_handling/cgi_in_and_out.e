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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

