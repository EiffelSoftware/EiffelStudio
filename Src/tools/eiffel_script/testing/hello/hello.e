note
	description: "[
			Hello world example
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HELLO

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			print ("Hello Eiffel Script tool !%N")
			across
				execution_environment.arguments.argument_array as ic
			loop
				print (ic.item)
				print ("%N")
			end
			print ("Please enter a text: ")
			io.read_line
			print ("> " + io.last_string)
		end

end
