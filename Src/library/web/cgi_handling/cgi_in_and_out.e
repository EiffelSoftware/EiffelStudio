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
