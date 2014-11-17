note
	description: "test_suite application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
				--| Add your code here
			print ("Hello Eiffel World!%N")
		end

end
