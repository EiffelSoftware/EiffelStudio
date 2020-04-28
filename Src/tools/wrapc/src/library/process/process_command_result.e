note
	description: "Summary description for {PROCESS_COMMAND_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_COMMAND_RESULT

create
	make

convert
	output: {READABLE_STRING_8}

feature -- Initialization

	make (a_exit_code: INTEGER; a_output: READABLE_STRING_8; a_error_output: READABLE_STRING_8)
		do
			exit_code := a_exit_code
			output := a_output
			error_output := a_error_output
		end

feature -- Access

	output: READABLE_STRING_8

	error_output: READABLE_STRING_8

	exit_code: INTEGER

;note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
