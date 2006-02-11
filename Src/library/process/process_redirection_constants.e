indexing
	description: "Definition of some constants used in process launcher"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_REDIRECTION_CONSTANTS

feature -- Access
	to_stream: INTEGER is 0 
	to_file: INTEGER is 1
	to_agent: INTEGER is 2
	no_redirection: INTEGER is 3
	to_same_as_output: INTEGER is 5

end
