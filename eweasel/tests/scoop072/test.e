note
	description: "Test if a call with an expanded argument is asynchronous."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			other: separate TEST
			eclass: ECLASS
			any: ANY
			sync: POINTER
		do
			create eclass
			any := eclass

			create other
			separate other as o do
				o.test_with_expanded (eclass)
				print ("make_first%N")
				sync := o.default_pointer
			end

			create other
			separate other as o do
				o.test_with_any (any)
				print ("make_second%N")
				sync := o.default_pointer
			end
		end

feature -- Tests

	second: INTEGER_64 = 1_000_000_000

	test_with_expanded (a_eclass: ECLASS)
		do
			sleep (second)
			print ("test_with_expanded%N")
		end

	test_with_any (any: separate ANY)
		do
			sleep (second)
			print ("test_with_any%N")
		end

end
