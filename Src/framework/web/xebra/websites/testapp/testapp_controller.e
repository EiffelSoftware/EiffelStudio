note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTAPP_CONTROLLER

create
	make

feature -- please give me an name

	make
			--
		do


		end

	give_me_a_hello: STRING
		-- Gives him a hello
		do
			Result := "Hello!"
		end

	print_to_console
		-- Prints something
		do
			print ("Test test!%N")
		end


end
