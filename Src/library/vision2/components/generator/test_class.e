indexing
	description: "Test class for application_generator."
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

end -- class TEST_CLASS
