indexing
	description: "Definition of some constants used in process launcher"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_REDIRECTION_CONSTANTS

feature
	To_stream: INTEGER is 0 
	To_file: INTEGER is 1
	To_agent: INTEGER is 2
	To_same_as_output: INTEGER is 5
end
