indexing
	description: "Class which allows to access the files %
				% corresponding to the in/out data flow"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class CGI_IN_AND_OUT

