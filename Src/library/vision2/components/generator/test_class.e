indexing
	description: "Test class for application_generator."
	author: "Julian Rogers"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CLASS

inherit
	APPLICATION_GENERATOR

create
	make_and_launch

feature -- Create

	make_and_launch is
		do
			default_create
			prepare
			launch
		end

invariant
	invariant_clause: -- Your invariant here

end -- class TEST_CLASS
