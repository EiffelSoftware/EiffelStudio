note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST2

inherit
	ANY
		redefine
			default_create
		end

feature

	frozen default_create
		do
			create_implementation
			initialize
		end

	initialize
		do
			create s.make_empty
			s.do_nothing
		end

	create_implementation
		do
			create s.make_empty
		end

	s: attached STRING

end
